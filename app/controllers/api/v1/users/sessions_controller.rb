class Api::V1::Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: resource
  end

  def verify_signed_out_user
    head :unauthorized unless user_signed_in?
  end

  def respond_to_on_destroy
    head :ok
  end
end
