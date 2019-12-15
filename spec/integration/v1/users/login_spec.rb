require 'swagger_helper'

RSpec.describe 'Login a User', swagger_doc: 'v1/swagger.json' do
  path '/api/v1/users/login' do
    post 'Authenticates a user' do
      tags 'Users'
      parameter name: :user,
        in: :body,
        required: true,
        schema: {
          type: :object,
          properties: {
            user: {
              type: :object,
              required: %i(email password),
              properties: {
                email: { type: :string },
                password: { type: :string }
              }
            }
          }
        }

      response '200', 'user authenticated' do
        let(:valid_user) { create(:user) }
        let(:user) do
          {
            user: {
              email: valid_user.email,
              password: valid_user.password
            }
          }
        end

        run_test! do |response|
          expect(response.header).to have_key('Authorization')
        end
      end

      response '401', 'unauthorized' do
        let(:user) do
          {
            user: {
              email: 'invalid'
            }
          }
        end

        run_test! do |response|
          expect(response.header).to_not have_key('Authorization')
        end
      end
    end
  end
end
