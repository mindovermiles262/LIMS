class Project < ApplicationRecord
  validates :user, presence: true
  
  has_many :tests
  belongs_to :user
end
