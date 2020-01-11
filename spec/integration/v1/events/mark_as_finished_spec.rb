require 'swagger_helper'

RSpec.describe 'Mark an Event as finished', swagger_doc: 'v1/swagger.json' do
  let(:event) { create(:event, :with_participants) }
  let(:auth_token) { user_auth_token(event.participants.first) }

  path '/api/v1/events/{id}/mark_as_finished' do
    put 'Marks an event as finished' do
      tags 'Events'
      security [ Bearer: [] ]
      parameter name: :id,
        in: :path,
        type: :integer

      response '204', 'event marked as finished' do
        let(:Authorization) { auth_token }
        let(:id) { event.id }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:id) { event.id }

        run_test!
      end

      response '404', 'not found' do
        let(:Authorization) { auth_token }
        let(:id) { 0 }

        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { auth_token }
        let(:id) { event.id }

        before do
          event.update!(event_status: :finished)
        end

        run_test!
      end
    end
  end
end
