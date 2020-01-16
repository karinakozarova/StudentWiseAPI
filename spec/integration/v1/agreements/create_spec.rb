require 'swagger_helper'

RSpec.describe 'Create an Agreement', swagger_doc: 'v1/swagger.json' do
  let(:auth_token) { user_auth_token }

  path '/api/v1/agreements' do
    post 'Creates an agreement' do
      tags 'Agreements'
      security [Bearer: []]
      parameter name: :agreement,
        in: :body,
        required: true,
        schema: {
          type: :object,
          properties: {
            agreement: {
              type: :object,
              required: %i(title),
              properties: {
                title: { type: :string },
                description: { type: :string }
              }
            }
          }
        }

      response '201', 'agreement created' do
        let(:Authorization) { auth_token }
        let(:agreement) do
          {
            agreement: attributes_for(:agreement)
          }
        end

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:agreement) do
          {
            agreement: attributes_for(:agreement)
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { auth_token }
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
