require 'swagger_helper'

RSpec.describe 'Check 2FA challenge for a User', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user, :two_fa) }
  let(:valid_response) { valid_response_for(user) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/two_fa/challenge' do
    post 'Checks 2FA challenge for a user' do
      tags '2FA'
      parameter name: :challenge,
        in: :body,
        required: true,
        schema: {
          type: :object,
          properties: {
            challenge: {
              type: :object,
              required: %i(two_fa_challenge response),
              properties: {
                two_fa_challenge: { type: :string },
                response: { type: :string }
              }
            }
          }
        }

      response '200', '2FA challenge solved successfully' do
        let(:challenge) do
          {
            challenge: {
              two_fa_challenge: user.two_fa_challenge,
              response: valid_response
            }
          }
        end

        run_test! do |response|
          expect(response.header).to have_key('Authorization')
        end
      end

      response '401', 'unauthorized' do
        let(:challenge) do
          {
            challenge: {
              two_fa_challenge: user.two_fa_challenge,
              response: 'invalid'
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
