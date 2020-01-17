require 'swagger_helper'

RSpec.describe 'Update a Group', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user, :admin) }
  let(:old_group) { create(:group) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/groups/{id}' do
    put 'Updates a group' do
      tags 'Groups'
      security [Bearer: []]
      parameter name: :id,
        in: :path,
        type: :integer
      parameter name: :group,
        in: :body,
        required: true,
        schema: {
          type: :object,
          properties: {
            group: {
              type: :object,
              properties: {
                name: { type: :string },
                description: { type: :string },
                rules: { type: :string }
              }
            }
          }
        }

      response '200', 'group updated' do
        let(:Authorization) { auth_token }
        let(:id) { old_group.id }
        let(:group) do
          {
            group: {
              name: 'New Title'
            }
          }
        end

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:id) { old_group.id }
        let(:group) do
          {
            group: {
              name: 'New Title'
            }
          }
        end

        run_test!
      end

      response '404', 'not found' do
        let(:Authorization) { auth_token }
        let(:id) { 0 }
        let(:group) do
          {
            group: {
              name: 'New Title'
            }
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { auth_token }
        let(:id) { old_group.id }
        let(:group) do
          {
            group: {
              name: ''
            }
          }
        end

        run_test!
      end
    end
  end
end
