require 'swagger_helper'

RSpec.describe 'Unarchives an Expense', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:expense) { create(:expense, :archived, creator_id: user.id) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/expenses/{id}/unarchive' do
    put 'Unarchives an expense' do
      tags 'Expenses'
      security [Bearer: []]
      parameter name: :id,
        in: :path,
        type: :integer

      response '200', 'expense unarchived' do
        let(:Authorization) { auth_token }
        let(:id) { expense.id }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:id) { expense.id }

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
