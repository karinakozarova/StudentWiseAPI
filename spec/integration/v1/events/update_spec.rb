require 'swagger_helper'

RSpec.describe 'Update an Event', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:old_event) { create(:event, creator_id: user.id) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/events/{id}' do
    put 'Updates an event' do
      tags 'Events'
      security [ Bearer: [] ]
      parameter name: :id,
        in: :path,
        type: :integer
      parameter name: :event,
        in: :body,
        required: true,
        schema: {
          type: :object,
          properties: {
            event: {
              type: :object,
              properties: {
                event_type: { type: :string },
                title: { type: :string },
                description: { type: :string },
                starts_at: { type: :string },
                finishes_at: { type: :string }
              }
            }
          }
        }

      response '200', 'event updated' do
        let(:Authorization) { auth_token }
        let(:id) { old_event.id }
        let(:event) do
          {
            event: {
              title: 'New Title'
            }
          }
        end

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:id) { old_event.id }
        let(:event) do
          {
            event: {
              title: 'New Title'
            }
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { auth_token }
        let(:id) { old_event.id }
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
