class User < ApplicationRecord
  scope :with_group_of, ->(user) do
    where(group_id: user.group.id) unless user.admin?
  end

  # Other devise modules available:
  # :recoverable, :rememberable, :confirmable,
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  belongs_to :group, optional: true

  has_many :agreements
  has_many :complaints
  has_many :event_participants, dependent: :destroy
  has_many :event_votes, dependent: :destroy
  has_many :events, through: :event_participants
  has_many :expense_participants, dependent: :destroy
  has_many :expenses, through: :expense_participants
  has_many :voted_for_events, through: :event_votes

  validates :first_name, presence: true
  validates :last_name, presence: true

  after_save :add_to_default_group, if: -> { group.nil? }
  after_create :add_to_default_group, if: -> { group.nil? }

  def add_to_default_group
    group = Group.find_by(name: Group::DEFAULT_GROUP_NAME)
    update!(group_id: group.id)
  end
end
