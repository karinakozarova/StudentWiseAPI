class V1::EventVotePresenter < ApplicationPresenter
  presents :event_vote

  def event_status_changed?
    event_vote.event.previous_changes.include?(:event_status)
  end
end
