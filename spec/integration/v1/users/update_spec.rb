require 'swagger_helper'

RSpec.describe 'Update a User', swagger_doc: 'v1/swagger.json' do
  let(:old_user) { create(:user) }
  let(:auth_token) { user_auth_token(old_user) }

  path '/api/v1/users' do
    put 'Updates the authenticated user' do
      tags 'Users'
      security [Bearer: []]
      parameter name: :user,
        in: :body,
        required: true,
        schema: {
          type: :object,
          properties: {
            user: {
              type: :object,
              required: %i(current_password),
              properties: {
                email: { type: :string },
                first_name: { type: :string },
                last_name: { type: :string },
                password: { type: :string },
                current_password: { type: :string }
              }
            }
          }
        }

      response '204', 'user updated' do
        let(:Authorization) { auth_token }
        let(:user) do
          {
            user: {
              first_name: 'New Name',
              current_password: old_user.password
            }
          }
        end

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:user) do
          {
            user: {
              first_name: 'New Name',
              current_password: old_user.password
            }
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:Authorization) { auth_token }
        let(:user) do
          {
            user: {
              first_name: '',
              current_password: old_user.password
            }
          }
        end

        run_test!
      end
    end
  end
end
