require 'swagger_helper'

RSpec.describe 'Destroy an EventVote', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:event) { create(:event, :pending_review) }
  let(:ev) { create(:event_vote, event_id: event.id, voter_id: user.id) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/events/{event_id}/votes' do
    delete 'Removes an event vote' do
      tags 'EventVotes'
      security [ Bearer: [] ]
      parameter name: :event_id,
        in: :path,
        type: :integer

      response '204', 'event vote removed' do
        let(:Authorization) { auth_token }
        let(:event_id) { ev.event_id }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:event_id) { ev.event_id }

        run_test!
      end

      response '404', 'not found' do
        let(:Authorization) { auth_token }
        let(:event_id) { 0 }

        run_test!
      end
    end
  end
end
