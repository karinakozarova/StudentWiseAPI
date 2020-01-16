require 'swagger_helper'

RSpec.describe 'Show an Agreement', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:agreement) { create(:agreement) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/agreements/{id}' do
    get 'Shows an agreement' do
      tags 'Agreements'
      security [ Bearer: [] ]
      parameter name: :id,
        in: :path,
        type: :integer

      response '200', 'agreement shown' do
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
