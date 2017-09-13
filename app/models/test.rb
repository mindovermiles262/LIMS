class Test < ApplicationRecord
  belongs_to :sample
  has_one :test_method
end
