class TestMethod < ApplicationRecord
  # Admin Only :new, :create, :edit, :destroy
  # Technician Only :index

  validates :name, :target_organism, :reference_method, 
            :turn_around_time, :detection_limit, :unit, 
              presence: true
  validates :turn_around_time, numericality: {  only_integer: true, 
                                                greater_than: 0, 
                                                less_than: 11 }
  validates :detection_limit, numericality: { only_integer: true,
                                              greater_than: 0 }
end
