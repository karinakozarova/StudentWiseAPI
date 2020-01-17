require 'swagger_helper'

RSpec.describe 'Create a Group', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user, :admin) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/groups' do
    post 'Creates a group' do
      tags 'Groups'
      security [Bearer: []]
      parameter name: :group,
        in: :body,
        required: true,
        schema: {
          type: :object,
          properties: {
            group: {
              type: :object,
              required: %i(name),
              properties: {
                name: { type: :string },
                description: { type: :string },
                rules: { type: :string }
              }
            }
          }
        }

      response '201', 'group created' do
        let(:Authorization) { auth_token }
        let(:group) do
          {
            group: attributes_for(:group)
          }
        end

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:group) do
          {
            group: attributes_for(:group)
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { auth_token }
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
