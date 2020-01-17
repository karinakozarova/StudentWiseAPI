require 'swagger_helper'

RSpec.describe 'Update an Agreement', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:old_agreement) { create(:agreement, creator_id: user.id, group_id: user.group.id) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/agreements/{id}' do
    put 'Updates an agreement' do
      tags 'Agreements'
      security [Bearer: []]
      parameter name: :id,
        in: :path,
        type: :integer
      parameter name: :agreement,
        in: :body,
        required: true,
        schema: {
          type: :object,
          properties: {
            agreement: {
              type: :object,
              properties: {
                title: { type: :string },
                description: { type: :string }
              }
            }
          }
        }

      response '200', 'agreement updated' do
        let(:Authorization) { auth_token }
        let(:id) { old_agreement.id }
        let(:agreement) do
          {
            agreement: {
              title: 'New Title'
            }
          }
        end

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:id) { old_agreement.id }
        let(:agreement) do
          {
            agreement: {
              title: 'New Title'
            }
          }
        end

        run_test!
      end

      response '404', 'not found' do
        let(:Authorization) { auth_token }
        let(:id) { 0 }
        let(:agreement) do
          {
            agreement: {
              title: 'New Title'
            }
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { auth_token }
        let(:id) { old_agreement.id }
        let(:agreement) do
          {
            agreement: {
              title: ''
            }
          }
        end

        run_test!
      end
    end
  end
end
