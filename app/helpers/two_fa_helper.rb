module TwoFaHelper
  TWO_FA_HASH_LENGTH = 40.freeze
  TWO_FA_CHALLENGE_LENGTH = 20.freeze
  TWO_FA_SECRET_LENGTH = 20.freeze

  def generate_two_fa_secret
    SecureRandom.hex(TWO_FA_SECRET_LENGTH / 2)
  end

  def generate_two_fa_challenge
    SecureRandom.hex(TWO_FA_CHALLENGE_LENGTH / 2)
  end

  def validate_response_for(user, response)
    return false unless response =~ /[0-9a-f]{#{TWO_FA_HASH_LENGTH}}/i
    response == valid_response_for(user)
  end

  def valid_response_for(user)
    Digest::SHA1.hexdigest(user.two_fa_secret + user.two_fa_challenge)
  end
end
