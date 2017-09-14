class Project < ApplicationRecord
  has_many :samples
  accepts_nested_attributes_for :samples, allow_destroy: true, :reject_if => lambda { |a| a[:description].blank? }
  
  has_many :tests, through: :samples
  belongs_to :user

  validates :description, presence: true, length: { maximum: 200 }
  validates :lot, presence: true, length: { maximum: 100 }

end