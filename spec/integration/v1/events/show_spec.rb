require 'swagger_helper'

RSpec.describe 'Show an Event', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/events/{id}' do
    get 'Shows an event' do
      tags 'Events'
      security [Bearer: []]
      parameter name: :id,
        in: :path,
        type: :integer

      response '200', 'event shown' do
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
    end
  end
end
