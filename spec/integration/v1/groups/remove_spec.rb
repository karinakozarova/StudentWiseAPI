require 'swagger_helper'

RSpec.describe 'Removes a User from Group', swagger_doc: 'v1/swagger.json' do
  let(:user) { create(:user, :admin) }
  let(:auth_token) { user_auth_token(user) }

  before do
    create(:group, name: Group::DEFAULT_GROUP_NAME)
  end

  path '/api/v1/groups/{id}/members' do
    delete 'Removes a user from group' do
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

      response '200', 'user removed from group' do
        let(:Authorization) { auth_token }
        let(:id) { user.group.id }
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
        let(:id) { user.group.id }
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
