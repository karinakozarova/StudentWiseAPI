require 'devise/jwt/test_helpers'

module Helpers
  module TwoFa
    def generate_two_fa_secret
      SecureRandom.hex(TwoFaHelper::TWO_FA_SECRET_LENGTH / 2)
    end

    def generate_two_fa_challenge
      SecureRandom.hex(TwoFaHelper::TWO_FA_CHALLENGE_LENGTH / 2)
    end

    def valid_response_for(user)
      Digest::SHA1.hexdigest(user.two_fa_secret + user.two_fa_challenge)
    end
  end
end
