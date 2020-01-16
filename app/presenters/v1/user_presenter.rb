class V1::UserPresenter < ApplicationPresenter
  presents :user

  def privileged?
    v.current_user.id == user.id || v.current_user.admin?
  end
end
