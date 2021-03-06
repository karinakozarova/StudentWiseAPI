require 'swagger_helper'

RSpec.describe 'Create an EventParticipant', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:auth_token) { user_auth_token(event.creator) }

  path '/api/v1/events/{event_id}/participants' do
    post 'Creates an event participant' do
      tags 'EventParticipants'
      security [Bearer: []]
      parameter name: :event_id,
        in: :path,
        type: :integer
      parameter name: :event_participant,
        in: :body,
        required: true,
        schema: {
          type: :object,
          properties: {
            event_participant: {
              type: :object,
              required: %i(participant_id),
              properties: {
                participant_id: { type: :integer }
              }
            }
          }
        }

      response '201', 'event participant created' do
        let(:Authorization) { auth_token }
        let(:event_id) { event.id }
        let(:event_participant) do
          {
            event_participant: {
              participant_id: user.id
            }
          }
        end

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:event_id) { event.id }
        let(:event_participant) do
          {
            event_participant: {
              participant_id: user.id
            }
          }
        end

        run_test!
      end

      response '404', 'not found' do
        let(:Authorization) { auth_token }
        let(:event_id) { 0 }
        let(:event_participant) do
          {
            event_participant: {
              participant_id: user.id
            }
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { auth_token }
        let(:event_id) { event.id }
        let(:event_participant) do
          {
            event_participant: {
              participant_id: 0
            }
          }
        end

        run_test!
      end
    end
  end
end
