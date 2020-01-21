class Api::V1::Devise::SessionsController < Devise::SessionsController
  include TwoFaHelper

  respond_to :json

  def create
    @user = User.authenticate(sign_in_params[:email], sign_in_params[:password])

    if @user&.two_fa_enabled?
      @user.set_two_fa_challenge!
      render 'api/v1/two_fa/challenge', status: :ok
    else
      super
    end
  end

  private

  def respond_with(resource, _opts = {})
    render partial: 'api/v1/users/user', locals: { user: resource }
  end

  def verify_signed_out_user
    unauthorized_response unless user_signed_in?
  end

  def respond_to_on_destroy
    head :no_content
  end
end
