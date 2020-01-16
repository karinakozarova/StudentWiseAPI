class EventVote < ApplicationRecord
  belongs_to :event
  belongs_to :voter, class_name: 'User'

  validates :finished, inclusion: { in: [true, false] }
  validates :voter_id, uniqueness: { scope: :event_id, message: 'already voted for this event' }

  after_save :set_event_status
  after_destroy :set_event_status

  def set_event_status
    event.set_status
  end
end
