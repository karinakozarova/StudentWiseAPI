class V1::EventPresenter < ApplicationPresenter
  presents :event

  def event_status_changed?
    event.event_status_previously_changed?
  end

  def locked_changed?
    if event_status_changed?
      return true if event.locked? != event.locked?(previous_changes[:event_status])
    end
    return false
  end
end
