require 'swagger_helper'

RSpec.describe 'Update a Complaint', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:old_complaint) { create(:complaint, creator_id: user.id, group_id: user.group.id) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/complaints/{id}' do
    put 'Updates a complaint' do
      tags 'Complaints'
      security [Bearer: []]
      parameter name: :id,
        in: :path,
        type: :integer
      parameter name: :complaint,
        in: :body,
        required: true,
        schema: {
          type: :object,
          properties: {
            complaint: {
              type: :object,
              properties: {
                title: { type: :string },
                description: { type: :string }
              }
            }
          }
        }

      response '200', 'complaint updated' do
        let(:Authorization) { auth_token }
        let(:id) { old_complaint.id }
        let(:complaint) do
          {
            complaint: {
              title: 'New Title'
            }
          }
        end

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:id) { old_complaint.id }
        let(:complaint) do
          {
            complaint: {
              title: 'New Title'
            }
          }
        end

        run_test!
      end

      response '404', 'not found' do
        let(:Authorization) { auth_token }
        let(:id) { 0 }
        let(:complaint) do
          {
            complaint: {
              title: 'New Title'
            }
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { auth_token }
        let(:id) { old_complaint.id }
        let(:complaint) do
          {
            complaint: {
              title: ''
            }
          }
        end

        run_test!
      end
    end
  end
end
