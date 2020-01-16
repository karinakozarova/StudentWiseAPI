require 'swagger_helper'

RSpec.describe 'Show a User', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:auth_token) { user_auth_token }

  path '/api/v1/users/{id}' do
    get 'Shows a user' do
      tags 'Users'
      security [Bearer: []]
      parameter name: :id,
        in: :path,
        type: :integer

      response '200', 'user shown' do
        let(:Authorization) { auth_token }
        let(:id) { user.id }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:id) { user.id }

        run_test!
      end

      response '404', 'not found' do
        let(:Authorization) { auth_token }
        let(:id) { 0 }

        run_test!
      end
    end
  end
end
