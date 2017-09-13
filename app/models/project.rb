class Project < ApplicationRecord
  has_many :samples
  accepts_nested_attributes_for :samples, allow_destroy: true, :reject_if => lambda { |a| a[:description].blank? }
  belongs_to :user
end