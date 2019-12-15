require 'swagger_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Logout a User', swagger_doc: 'v1/swagger.json' do
  path '/api/v1/users/logout' do
    delete 'Revokes user authentication' do
      tags 'Users'
      security [ Bearer: [] ]

      response '200', 'user logged out' do
        let(:user) { create(:user) }
        let(:headers) { Devise::JWT::TestHelpers.auth_headers({}, user) }
        let(:Authorization) { headers['Authorization'] }

        run_test!
      end
    end
  end
end
