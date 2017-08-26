class TestMethod < ApplicationRecord
  # Admin Only :new, :create, :edit, :destroy
  # Technician Only :index

  validates :name, :target_organism, :reference_method, 
            :turn_around_time, :detection_limit, :unit, 
              presence: true
end
