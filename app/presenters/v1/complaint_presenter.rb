class V1::ComplaintPresenter < ApplicationPresenter
  presents :complaint

  def status_changed?
    complaint.status_previously_changed?
  end

  def locked_changed?
    if status_changed?
      return true if complaint.locked? != complaint.locked?(previous_changes[:status])
    end
    return false
  end
end
