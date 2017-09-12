class Test < ApplicationRecord
  belongs_to :test_method
  belongs_to :sample
  has_one :project, through: :sample
end
