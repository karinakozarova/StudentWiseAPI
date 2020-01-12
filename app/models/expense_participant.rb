class ExpenseParticipant < ApplicationRecord
  belongs_to :expense
  belongs_to :participant, class_name: 'User'

  validates :participant_id, uniqueness: { scope: :expense_id, message: 'already participates in this expense' }
end
