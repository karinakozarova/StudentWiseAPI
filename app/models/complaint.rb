class Complaint < ApplicationRecord
  STATUSES = %i(in_progress received rejected resolved sent).freeze

  scope :with_creator, ->(user) do
    where(creator_id: user.id) unless user.admin?
  end

  belongs_to :creator, class_name: 'User'

  validates :status, inclusion: { in: STATUSES.map(&:to_s) }
  validates :title, presence: true

  STATUSES.each do |available_status|
    define_method :"#{available_status}?" do
      status.to_sym == available_status
    end
  end

  def locked?(status_to_check = nil)
    locked_types = %i(in_progress rejected resolved)
    status_to_check ||= status.to_sym

    locked_types.each do |status|
      return true if status_to_check == status
    end
    return false
  end

  def change_sent_to_received!
    update!(status: :received) if sent?
  end
end
