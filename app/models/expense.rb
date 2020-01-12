class Expense < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  scope :with_creator, ->(user) { where(creator_id: user.id) }

  validates :name, presence: true
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{1,2})?\z/ },
                    numericality: { greater_than: 0 }
  validates :amount, presence: true, numericality: { greater_than: 0, only_integer: true }
end
