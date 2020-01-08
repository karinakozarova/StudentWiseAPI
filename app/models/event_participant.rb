class EventParticipant < ApplicationRecord
  belongs_to :event
  belongs_to :participant, class_name: 'User'

  validates :participant_id, uniqueness: { scope: :event_id, message: 'already participates in this event' }
end
