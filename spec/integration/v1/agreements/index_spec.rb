require 'swagger_helper'

RSpec.describe 'Show multiple Agreements', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:agreement1) { create(:agreement) }
  let(:agreement2) { create(:agreement) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/agreements' do
    get 'Shows all agreements' do
      tags 'Agreements'
      security [ Bearer: [] ]

      response '200', 'agreements shown' do
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
