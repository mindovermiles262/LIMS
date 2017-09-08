class Project < ApplicationRecord
  validates :user, presence: true
  
  has_many :tests
  accepts_nested_attributes_for :tests, allow_destroy: true, :reject_if => lambda { |a| a[:test_method_id].blank? }
  
  belongs_to :user

  def received?
    self.tests.map do |t| 
      if t.received == true
        return true
      end
      return false
    end
  end
end
