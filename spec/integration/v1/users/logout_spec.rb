require 'swagger_helper'

RSpec.describe 'Logout a User', swagger_doc: 'v1/swagger.json' do
  path '/api/v1/users/logout' do
    delete 'Revokes user authentication' do
      tags 'Users'
      security [ Bearer: [] ]

      response '200', 'user logged out' do
        let(:Authorization) { user_auth_token }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }

        run_test!
      end
    end
  end
end
