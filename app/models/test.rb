class Test < ApplicationRecord
  belongs_to :test_method
  # has_many :analysts
  belongs_to :project
  has_one :user, through: :project
end
