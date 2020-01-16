require 'swagger_helper'

RSpec.describe 'Mark an Complaint as in progress', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user, :admin) }
  let(:complaint) { create(:complaint) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/complaints/{id}/mark_as_in_progress' do
    put 'Marks an complaint as in progress' do
      tags 'Complaints'
      security [ Bearer: [] ]
      parameter name: :id,
        in: :path,
        type: :integer

      response '200', 'complaint marked as in progress' do
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
