class Project < ApplicationRecord
  validates :user, presence: true
  validates :lot, presence: true
  validates :description, presence: true
  
  has_many :samples
  accepts_nested_attributes_for :samples, allow_destroy: true, :reject_if => lambda { |a| a[:test_method_id].blank? }
  
  belongs_to :user
end