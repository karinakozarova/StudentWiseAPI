require 'swagger_helper'

RSpec.describe 'Destroy an ExpenseParticipant', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:expense) { create(:expense, creator_id: user.id) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/expenses/{expense_id}/participants' do
    delete 'Removes an expense participant' do
      tags 'ExpenseParticipants'
      security [Bearer: []]
      parameter name: :expense_id,
        in: :path,
        type: :integer
      parameter name: :expense_participant,
        in: :body,
        required: true,
        schema: {
          type: :object,
          properties: {
            expense_participant: {
              type: :object,
              required: %i(participant_id),
              properties: {
                participant_id: { type: :integer }
              }
            }
          }
        }

      response '204', 'expense participant removed' do
        let(:Authorization) { auth_token }
        let(:expense_id) { expense.id }
        let(:expense_participant) do
          {
            expense_participant: {
              participant_id: user.id
            }
          }
        end

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:expense_id) { expense.id }
        let(:expense_participant) do
          {
            expense_participant: {
              participant_id: user.id
            }
          }
        end

        run_test!
      end

      response '404', 'not found' do
        let(:Authorization) { auth_token }
        let(:expense_id) { expense.id }
        let(:expense_participant) do
          {
            expense_participant: {
              participant_id: 0
            }
          }
        end

        run_test!
      end
    end
  end
end
