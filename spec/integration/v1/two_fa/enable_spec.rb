require 'swagger_helper'

RSpec.describe 'Enable 2FA for a User', swagger_doc: 'v1/swagger.json' do
  let(:auth_token) { user_auth_token }

  path '/api/v1/two_fa/enable' do
    put 'Enables 2FA for a user' do
      tags '2FA'
      security [Bearer: []]

      response '200', '2FA enabled for authenticated user' do
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
