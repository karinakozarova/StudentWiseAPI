class User < ApplicationRecord
  # Other devise modules available:
  # :recoverable, :rememberable, :confirmable,
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  validates :first_name, presence: true
  validates :last_name, presence: true
end
