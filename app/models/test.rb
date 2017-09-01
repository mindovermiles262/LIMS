class Test < ApplicationRecord
  has_one :test_method
  has_many :analysts
  belongs_to :project
  has_one :user, through: :project
end
