class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, if: :json_request?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def home
  end

  private

  def json_request?
    request.format.json?
  end

  def configure_permitted_parameters
    added_params = %i(first_name last_name)
    devise_parameter_sanitizer.permit(:sign_up, keys: added_params)
    devise_parameter_sanitizer.permit(:account_update, keys: added_params)
  end

  def unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors }, status: :unprocessable_entity
  end

  def not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def unauthorized_response(message = 'Unauthorized')
    render json: { error: message }, status: :unauthorized
  end
end
