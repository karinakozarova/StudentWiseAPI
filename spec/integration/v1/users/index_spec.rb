require 'swagger_helper'

RSpec.describe 'Show all Users', swagger_doc: 'v1/swagger.json' do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:auth_token) { user_auth_token }

  path '/api/v1/users' do
    get 'Shows all users' do
      tags 'Users'
      security [Bearer: []]

      response '200', 'users shown' do
        let(:Authorization) { auth_token }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }

        run_test!
      end
    end
  end
end
