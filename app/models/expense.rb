class Expense < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  scope :with_creator, ->(user) { where(creator_id: user.id) }

  has_many :expense_participants, dependent: :destroy
  has_many :participants, through: :expense_participants

  validates :name, presence: true
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{1,2})?\z/ },
                    numericality: { greater_than: 0 }
  validates :amount, presence: true, numericality: { greater_than: 0, only_integer: true }

  after_create :add_creator_to_participants

  def add_creator_to_participants
    expense_participants.create(participant_id: creator_id)
  end
end