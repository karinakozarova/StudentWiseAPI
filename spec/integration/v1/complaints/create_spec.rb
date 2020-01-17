require 'swagger_helper'

RSpec.describe 'Create a Complaint', swagger_doc: 'v1/swagger.json' do
  let(:auth_token) { user_auth_token }

  path '/api/v1/complaints' do
    post 'Creates a complaint' do
      tags 'Complaints'
      security [Bearer: []]
      parameter name: :complaint,
        in: :body,
        required: true,
        schema: {
          type: :object,
          properties: {
            complaint: {
              type: :object,
              required: %i(title),
              properties: {
                title: { type: :string },
                description: { type: :string }
              }
            }
          }
        }

      response '201', 'complaint created' do
        let(:Authorization) { auth_token }
        let(:complaint) do
          {
            complaint: attributes_for(:complaint)
          }
        end

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:complaint) do
          {
            complaint: attributes_for(:complaint)
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { auth_token }
        let(:complaint) do
          {
            complaint: {
              title: ''
            }
          }
        end

        run_test!
      end
    end
  end
end
