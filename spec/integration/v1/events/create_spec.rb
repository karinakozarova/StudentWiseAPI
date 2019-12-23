require 'swagger_helper'

RSpec.describe 'Create an Event', swagger_doc: 'v1/swagger.json' do
  let(:auth_token) { user_auth_token }

  path '/api/v1/events' do
    post 'Creates an event' do
      tags 'Events'
      security [ Bearer: [] ]
      parameter name: :event,
        in: :body,
        required: true,
        schema: {
          type: :object,
          properties: {
            event: {
              type: :object,
              required: %i(title),
              properties: {
                title: { type: :string },
                description: { type: :string },
                starts_at: { type: :string },
                finishes_at: { type: :string }
              }
            }
          }
        }

      response '201', 'event created' do
        let(:Authorization) { auth_token }
        let(:event) do
          {
            event: attributes_for(:event)
          }
        end

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:event) do
          {
            event: attributes_for(:event)
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { auth_token }
        let(:event) do
          {
            event: {
              title: ''
            }
          }
        end

        run_test!
      end
    end
  end
end
