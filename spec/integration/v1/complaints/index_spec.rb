require 'swagger_helper'

RSpec.describe 'Show multiple Complaints', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:complaint1) { create(:complaint, creator_id: user.id) }
  let(:complaint2) { create(:complaint, creator_id: user.id) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/complaints' do
    get 'Shows complaints which you created in your group' do
      tags 'Complaints'
      security [Bearer: []]

      response '200', 'complaints shown' do
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
