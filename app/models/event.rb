class Event < ApplicationRecord
  TYPES = %i(duty other party).freeze

  scope :created_by, ->(user) { where(creator_id: user.id) }
  scope :with_participant, ->(user) do
    joins(:event_participants).where('participant_id = ?', user.id)
  end

  belongs_to :creator, class_name: 'User'

  has_many :event_participants, dependent: :destroy
  has_many :participants, through: :event_participants

  validates :event_type, inclusion: { in: Event::TYPES.map(&:to_s) }
  validates :title, presence: true
  validates :starts_at, date: { allow_blank: true }
  validates :finishes_at, date: { allow_blank: true, after: :starts_at, message: 'must be after starts_at' }
end
