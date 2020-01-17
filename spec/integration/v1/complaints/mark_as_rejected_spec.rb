require 'swagger_helper'

RSpec.describe 'Mark a Complaint as rejected', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user, :admin) }
  let(:complaint) { create(:complaint) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/complaints/{id}/mark_as_rejected' do
    put 'Marks a complaint as rejected' do
      tags 'Complaints'
      security [Bearer: []]
      parameter name: :id,
        in: :path,
        type: :integer

      response '200', 'complaint marked as rejected' do
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
