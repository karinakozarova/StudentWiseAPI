require 'swagger_helper'

RSpec.describe 'Destroy an EventParticipant', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:event) { create(:event, creator_id: user.id) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/events/{event_id}/participants' do
    delete 'Removes an event participant' do
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

      response '204', 'event participant removed' do
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
