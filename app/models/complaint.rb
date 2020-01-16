class Complaint < ApplicationRecord
  STATUSES = %i(in_progress received rejected resolved sent).freeze

  scope :with_creator, ->(user) do
    where(creator_id: user.id) unless user.admin?
  end

  belongs_to :creator, class_name: 'User'

  validates :status, inclusion: { in: Complaint::STATUSES.map(&:to_s) }
  validates :title, presence: true
end
