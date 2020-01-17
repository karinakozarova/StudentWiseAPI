class ApiController < ApplicationController
  include ActionController::MimeResponds
  respond_to :json

  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  private

  def require_admin!
    unauthorized_response('You must be an admin to perform this action') unless current_user.admin?
  end

  def require_group!
    unauthorized_response('You must be in a group to perform this action') if current_user.group.nil?
  end
end
