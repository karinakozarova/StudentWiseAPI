require 'swagger_helper'

RSpec.describe 'Update an Expense', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:old_expense) { create(:expense, creator_id: user.id, group_id: user.group.id) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/expenses/{id}' do
    put 'Updates an expense' do
      tags 'Expenses'
      security [Bearer: []]
      parameter name: :id,
        in: :path,
        type: :integer
      parameter name: :expense,
        in: :body,
        required: true,
        schema: {
          type: :object,
          properties: {
            expense: {
              type: :object,
              properties: {
                name: { type: :string },
                notes: { type: :string },
                price: { type: :number },
                quantity: { type: :integer }
              }
            }
          }
        }

      response '200', 'expense updated' do
        let(:Authorization) { auth_token }
        let(:id) { old_expense.id }
        let(:expense) do
          {
            expense: {
              name: 'New Name'
            }
          }
        end

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:id) { old_expense.id }
        let(:expense) do
          {
            expense: {
              name: 'New Name'
            }
          }
        end

        run_test!
      end

      response '404', 'not found' do
        let(:Authorization) { auth_token }
        let(:id) { 0 }
        let(:expense) do
          {
            expense: {
              name: 'New Name'
            }
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { auth_token }
        let(:id) { old_expense.id }
        let(:expense) do
          {
            expense: {
              name: ''
            }
          }
        end

        run_test!
      end
    end
  end
end
