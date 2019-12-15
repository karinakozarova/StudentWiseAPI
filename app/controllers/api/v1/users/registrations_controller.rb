class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
end
