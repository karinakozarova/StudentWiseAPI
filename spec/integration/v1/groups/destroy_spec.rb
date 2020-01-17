require 'swagger_helper'

RSpec.describe 'Destroy a Group', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user, :admin) }
  let(:group) { create(:group) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/groups/{id}' do
    delete 'Removes a group' do
      tags 'Groups'
      security [Bearer: []]
      parameter name: :id,
        in: :path,
        type: :integer

      response '204', 'group removed' do
        let(:Authorization) { auth_token }
        let(:id) { group.id }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
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
