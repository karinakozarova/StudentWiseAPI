require 'swagger_helper'

RSpec.describe 'Show a Group', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/groups/{id}' do
    get 'Shows a group' do
      tags 'Groups'
      parameter name: :id,
        in: :path,
        type: :integer

      response '200', 'group shown' do
        let(:Authorization) { auth_token }
        let(:id) { group.id }

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
