require 'swagger_helper'

RSpec.describe 'Moves a User to Group', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user, :admin) }
  let(:group) { create(:group) }
  let(:auth_token) { user_auth_token(user) }

  path '/api/v1/groups/{id}/members' do
    put 'Moves a user to group' do
      tags 'Groups'
      security [Bearer: []]
      parameter name: :id,
        in: :path,
        type: :integer
      parameter name: :group_member,
        in: :body,
        required: true,
        schema: {
          type: :object,
          properties: {
            group_member: {
              type: :object,
              required: %i(member_id),
              properties: {
                member_id: { type: :integer }
              }
            }
          }
        }

      response '200', 'user moved to group' do
        let(:Authorization) { auth_token }
        let(:id) { group.id }
        let(:group_member) do
          {
            group_member: {
              member_id: user.id
            }
          }
        end

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'invalid' }
        let(:id) { group.id }
        let(:group_member) do
          {
            group_member: {
              member_id: user.id
            }
          }
        end

        run_test!
      end

      response '404', 'not found' do
        let(:Authorization) { auth_token }
        let(:id) { 0 }
        let(:group_member) do
          {
            group_member: {
              member_id: user.id
            }
          }
        end

        run_test!
      end
    end
  end
end
