class Event < ApplicationRecord
  scope :created_by, ->(user) { where(creator_id: user.id) }

  TYPES = %i(duty other party).freeze

  belongs_to :creator, class_name: 'User'

  validates :event_type, inclusion: { in: Event::TYPES.map(&:to_s) }
  validates :title, presence: true
  validates :starts_at, date: { allow_blank: true }
  validates :finishes_at, date: { allow_blank: true, after: :starts_at, message: 'must be after starts_at' }
end
