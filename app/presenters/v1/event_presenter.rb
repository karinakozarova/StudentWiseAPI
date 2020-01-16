class V1::EventPresenter < ApplicationPresenter
  presents :event

  def status_changed?
    event.status_previously_changed?
  end

  def locked_changed?
    if status_changed?
      return true if event.locked? != event.locked?(previous_changes[:status])
    end
    return false
  end
end
