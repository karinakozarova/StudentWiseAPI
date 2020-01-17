require 'swagger_helper'

RSpec.describe 'Show multiple Events', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:event1) { create(:event) }
  let(:event2) { create(:event) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/events' do
    get 'Shows all events' do
      tags 'Events'
      security [Bearer: []]

      response '200', 'events shown' do
        let(:Authorization) { auth_token }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }

        run_test!
      end
    end
  end
end
