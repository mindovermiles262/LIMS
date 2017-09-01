class Project < ApplicationRecord
  validates :user, presence: true
  
  has_many :tests
  accepts_nested_attributes_for :tests
  
  belongs_to :user
end
