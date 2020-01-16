class V1::ComplaintPresenter < ApplicationPresenter
  presents :complaint

  def status_changed?
    complaint.status_previously_changed?
  end
end
