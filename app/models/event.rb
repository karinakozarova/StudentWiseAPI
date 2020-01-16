class Event < ApplicationRecord
  KINDS = %i(duty other party).freeze
  STATUSES = %i(finished marked_as_finished pending unfinished).freeze

  MIN_VOTES = 3.freeze

  scope :with_creator, ->(user) do
    where(creator_id: user.id) unless user.admin?
  end
  scope :with_participant, ->(user) do
    joins(:event_participants).where('participant_id = ?', user.id) unless user.admin?
  end

  belongs_to :creator, class_name: 'User'

  has_many :event_participants, dependent: :destroy
  has_many :event_votes, dependent: :destroy
  has_many :participants, through: :event_participants
  has_many :voters, through: :event_votes

  validates :kind, inclusion: { in: KINDS.map(&:to_s) }
  validates :status, inclusion: { in: STATUSES.map(&:to_s) }
  validates :title, presence: true
  validates :starts_at, date: { allow_blank: true }
  validates :finishes_at, date: { allow_blank: true, after: :starts_at, message: "must be after 'starts_at'" }

  after_create :add_creator_to_participants

  def in_review?
    status.to_sym == :marked_as_finished
  end

  def votable?
    votable_types = %i(duty other)

    votable_types.each do |type|
      return true if kind.to_sym == type
    end
    return false
  end

  def locked?(status_to_check = nil)
    locked_types = %i(finished unfinished)
    status_to_check ||= status.to_sym

    locked_types.each do |status|
      return true if status_to_check == status
    end
    return false
  end

  def add_creator_to_participants
    event_participants.create(participant_id: creator_id)
  end

  def set_status!
    update!(status: determine_status)
  end

  private

  def determine_status
    users_count = User.all.count
    participants_count = participants.count
    votes_count = event_votes.count

    if participants_count < 1
      :pending
    elsif votes_count < [users_count, MIN_VOTES].min
      :marked_as_finished
    else
      if event_votes.where(finished: false).any?
        :unfinished
      else
        :finished
      end
    end
  end
end
