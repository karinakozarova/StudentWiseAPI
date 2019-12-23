require 'devise/jwt/test_helpers'

module Helpers
  module Authorization
    def user_auth_token(user = nil)
      user ||= create(:user)
      Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization']
    end
  end
end
