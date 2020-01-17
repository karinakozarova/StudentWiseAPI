class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  respond_to :json

  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors }, status: :unprocessable_entity
  end

  def not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def unauthorized_response(message = 'Unauthorized')
    render json: { error: message }, status: :unauthorized
  end

  def configure_permitted_parameters
    added_params = %i(first_name last_name)
    devise_parameter_sanitizer.permit(:sign_up, keys: added_params)
    devise_parameter_sanitizer.permit(:account_update, keys: added_params)
  end

  def require_admin!
    unauthorized_response unless current_user.admin?
  end

  def require_group!
    unauthorized_response('You must be in a group to perform this action') if current_user.group.nil?
  end
end
