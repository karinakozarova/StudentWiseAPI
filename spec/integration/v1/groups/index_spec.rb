require 'swagger_helper'

RSpec.describe 'Show multiple Groups', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user) }
  let(:group1) { create(:group) }
  let(:group2) { create(:group) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/groups' do
    get 'Shows all groups' do
      tags 'Groups'
      security [Bearer: []]

      response '200', 'groups shown' do
        let(:Authorization) { auth_token }

        run_test!
      end
    end
  end
end
