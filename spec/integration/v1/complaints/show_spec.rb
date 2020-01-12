require 'swagger_helper'

RSpec.describe 'Show a Complaint', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:complaint) { create(:complaint, creator_id: user.id) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/complaints/{id}' do
    get 'Shows a complaint' do
      tags 'Complaints'
      security [ Bearer: [] ]
      parameter name: :id,
        in: :path,
        type: :integer

      response '200', 'complaint shown' do
        let(:Authorization) { auth_token }
        let(:id) { complaint.id }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:id) { complaint.id }

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
