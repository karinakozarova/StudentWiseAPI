require 'swagger_helper'

RSpec.describe 'Show all Users', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:user1) { create(:user, group_id: user.group.id) }
  let(:user2) { create(:user, group_id: user.group.id) }
  let(:auth_token) { user_auth_token }

  path '/api/v1/users' do
    get 'Shows all users in your group' do
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
