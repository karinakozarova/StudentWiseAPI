class Event < ApplicationRecord
  TYPES = %i(duty other party).freeze
  STATUSES = %i(finished marked_as_finished pending unfinished).freeze

  MIN_VOTES = 3.freeze

  scope :created_by, ->(user) { where(creator_id: user.id) }
  scope :with_participant, ->(user) do
    joins(:event_participants).where('participant_id = ?', user.id)
  end

  belongs_to :creator, class_name: 'User'

  has_many :event_participants, dependent: :destroy
  has_many :participants, through: :event_participants
  has_many :event_votes, dependent: :destroy
  has_many :voters, through: :event_votes

  validates :event_type, inclusion: { in: Event::TYPES.map(&:to_s) }
  validates :event_status, inclusion: { in: Event::STATUSES.map(&:to_s) }
  validates :title, presence: true
  validates :starts_at, date: { allow_blank: true }
  validates :finishes_at, date: { allow_blank: true, after: :starts_at, message: 'must be after starts_at' }

  def in_review?
    event_status.to_sym == :marked_as_finished
  end

  def votable?
    votable_types = %i(duty other)

    votable_types.each do |type|
      return true if event_type.to_sym == type
    end
    return false
  end

  def locked?
    locked_types = %i(finished unfinished)

    locked_types.each do |status|
      return true if event_status.to_sym == status
    end
    return false
  end

  def set_event_status
    update!(event_status: determine_event_status)
  end

  private

  def determine_event_status
    users_count = User.all.count
    participants_count = participants.count
    votes_count = event_votes.count

    if participants_count < 1
      :pending
    elsif votes_count < [users_count, Event::MIN_VOTES].min
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
