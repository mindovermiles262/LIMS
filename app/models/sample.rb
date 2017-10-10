class Sample < ApplicationRecord
  belongs_to :project
  has_one :user, through: :project
  belongs_to :test_method
  belongs_to :batch, optional: true
end