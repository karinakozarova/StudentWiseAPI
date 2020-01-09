class Api::V1::Devise::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render partial: 'api/v1/users/user', locals: { user: resource }
  end

  def verify_signed_out_user
    head :unauthorized unless user_signed_in?
  end

  def respond_to_on_destroy
    head :no_content
  end
end
