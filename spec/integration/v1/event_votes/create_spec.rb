require 'swagger_helper'

RSpec.describe 'Create an EventVote', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:event) { create(:event, :pending_review) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/events/{event_id}/votes' do
    post 'Creates an event vote' do
      tags 'EventVotes'
      security [ Bearer: [] ]
      parameter name: :event_id,
        in: :path,
        type: :integer
      parameter name: :event_vote,
        in: :body,
        required: true,
        schema: {
          type: :object,
          properties: {
            event_vote: {
              type: :object,
              required: %i(finished),
              properties: {
                finished: { type: :boolean }
              }
            }
          }
        }

      response '201', 'event vote created' do
        let(:Authorization) { auth_token }
        let(:event_id) { event.id }
        let(:event_vote) do
          {
            event_vote: {
              finished: true
            }
          }
        end

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:event_id) { event.id }
        let(:event_vote) do
          {
            event_vote: {
              finished: true
            }
          }
        end

        run_test!
      end

      response '404', 'not found' do
        let(:Authorization) { auth_token }
        let(:event_id) { 0 }
        let(:event_vote) do
          {
            event_vote: {
              finished: true
            }
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { auth_token }
        let(:event_id) { event.id }
        let(:event_vote) do
          {
            event_vote: {
              invalid: true
            }
          }
        end

        run_test!
      end
    end
  end
end
