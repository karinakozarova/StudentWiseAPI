class Complaint < ApplicationRecord
  STATUSES = %i(in_progress received rejected resolved sent).freeze

  belongs_to :creator, class_name: 'User'

  validates :status, inclusion: { in: Complaint::STATUSES.map(&:to_s) }
  validates :title, presence: true
end
