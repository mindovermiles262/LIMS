class Project < ApplicationRecord
  validates :user, presence: true
  
  has_many :tests
  accepts_nested_attributes_for :tests, reject_if: lambda { |a| a[:test_method_id].blank? }, allow_destroy: true
  
  belongs_to :user
end
