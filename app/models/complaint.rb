class Complaint < ApplicationRecord
  STATUSES = %i(in_progress received rejected resolved sent).freeze

  scope :with_creator, ->(user) { where(creator_id: user.id) }

  belongs_to :creator, class_name: 'User'

  validates :status, inclusion: { in: Complaint::STATUSES.map(&:to_s) }
  validates :title, presence: true
end
