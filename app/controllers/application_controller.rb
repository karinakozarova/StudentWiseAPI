class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    added_params = %i(first_name last_name)
    devise_parameter_sanitizer.permit(:sign_up, keys: added_params)
    devise_parameter_sanitizer.permit(:account_update, keys: added_params)
  end
end
