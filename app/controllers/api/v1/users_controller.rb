class Api::V1::UsersController < ApiController
  before_action :authenticate_user!
  before_action :require_group!
  before_action :set_user, only: :show

  def index
    @users = User.with_group_of(current_user).all
  end

  def show
  end

  private

  def set_user
    @user = User.with_group_of(current_user).find(params[:id])
  end
end
