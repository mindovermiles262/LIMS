class Project < ApplicationRecord
  validates :user, presence: true
  # before_save validate :check_empty
  
  has_many :tests
  accepts_nested_attributes_for :tests, reject_if: lambda { |a| a[:test_method_id].blank? }, allow_destroy: true
  
  belongs_to :user

  private

  def check_empty
    errors.add(:test_method, "Project must have Test Method") unless tests.count > 0
  end
end
