class User < ApplicationRecord
  # Other devise modules available:
  # :recoverable, :rememberable, :confirmable,
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  has_many :event_participants, dependent: :destroy
  has_many :events, through: :event_participants

  validates :first_name, presence: true
  validates :last_name, presence: true
end
