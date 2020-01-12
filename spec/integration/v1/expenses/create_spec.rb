require 'swagger_helper'

RSpec.describe 'Create an Expense', swagger_doc: 'v1/swagger.json' do
  let(:auth_token) { user_auth_token }

  path '/api/v1/expenses' do
    post 'Creates an expense' do
      tags 'Expenses'
      security [ Bearer: [] ]
      parameter name: :expense,
        in: :body,
        required: true,
        schema: {
          type: :object,
          properties: {
            expense: {
              type: :object,
              required: %i(name price amount),
              properties: {
                name: { type: :string },
                notes: { type: :string },
                price: { type: :number },
                amount: { type: :integer }
              }
            }
          }
        }

      response '201', 'expense created' do
        let(:Authorization) { auth_token }
        let(:expense) do
          {
            expense: attributes_for(:expense)
          }
        end

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:expense) do
          {
            expense: attributes_for(:expense)
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { auth_token }
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
