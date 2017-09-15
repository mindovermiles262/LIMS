class Batch < ApplicationRecord
  has_many :tests
  has_one :test_method
end
