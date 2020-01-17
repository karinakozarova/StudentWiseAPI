class Agreement < ApplicationRecord
  scope :with_creator, ->(user) do
    where(creator_id: user.id) unless user.admin?
  end

  belongs_to :creator, class_name: 'User'
  belongs_to :group

  validates :title, presence: true
end
