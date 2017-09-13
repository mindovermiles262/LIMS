class TestMethod < ApplicationRecord
  # Admin Only :new, :create, :edit, :destroy
  # Technician Only :index
  has_many :tests

  validates :name,              presence: true
  validates :target_organism,   presence: true
  validates :reference_method,  presence: true

  validates :turn_around_time,  presence: true, 
    numericality: { only_integer: true, greater_than: 0, less_than: 11 }

  validates :detection_limit,   presence: true,
    numericality: { only_integer: true, greater_than: 0 }
    
  validates :unit,              presence: true
end
