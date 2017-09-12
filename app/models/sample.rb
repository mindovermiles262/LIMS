class Sample < ApplicationRecord
  belongs_to :project
  has_many :tests
  accepts_nested_attributes_for :tests, allow_destroy: true, :reject_if => lambda { |a| a[:test_method_id].blank? }
end