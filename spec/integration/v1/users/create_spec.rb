require 'swagger_helper'

RSpec.describe 'Create a User', swagger_doc: 'v1/swagger.json' do
  path '/api/v1/users' do
    post 'Creates a user' do
      tags 'Users'
      parameter name: :user,
        in: :body,
        required: true,
        schema: {
          type: :object,
          properties: {
            user: {
              type: :object,
              required: %i(email first_name last_name password),
              properties: {
                email: { type: :string },
                first_name: { type: :string },
                last_name: { type: :string },
                password: { type: :string }
              }
            }
          }
        }

      response '201', 'user created' do
        let(:user) do
          {
            user: attributes_for(:user)
          }
        end

        run_test! do |response|
          expect(response.header).to have_key('Authorization')
        end
      end

      response '422', 'invalid request' do
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
