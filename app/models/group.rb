class Group < ApplicationRecord
  DEFAULT_GROUP_NAME = 'default'.freeze

  has_many :agreements
  has_many :complaints
  has_many :events
  has_many :expenses
  has_many :members, class_name: 'User'

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def is_default?
    name == DEFAULT_GROUP_NAME
  end
end
