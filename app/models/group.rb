class Group < ApplicationRecord
  has_many :agreements
  has_many :complaints
  has_many :events
  has_many :expenses
  has_many :users

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
