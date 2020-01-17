class V1::UserPresenter < ApplicationPresenter
  presents :user

  def privileged?
    v.current_user.id == user.id || v.current_user.admin?
  end

  def group_changed?
    user.group_id_previously_changed?
  end
end
