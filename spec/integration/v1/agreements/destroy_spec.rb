require 'swagger_helper'

RSpec.describe 'Destroy an Agreement', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:agreement) { create(:agreement, creator_id: user.id, group_id: user.group.id) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/agreements/{id}' do
    delete 'Removes an agreement' do
      tags 'Agreements'
      security [Bearer: []]
      parameter name: :id,
        in: :path,
        type: :integer

      response '204', 'agreement removed' do
        let(:Authorization) { auth_token }
        let(:id) { agreement.id }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:id) { agreement.id }

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
