require 'swagger_helper'

RSpec.describe 'Show multiple Expenses', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:expense1) { create(:expense) }
  let(:expense2) { create(:expense) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/expenses' do
    get 'Shows all expenses' do
      tags 'Expenses'
      security [Bearer: []]

      response '200', 'expenses shown' do
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
