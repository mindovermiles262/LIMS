class Project < ApplicationRecord
  belongs_to :user
  
  has_many :samples
  accepts_nested_attributes_for :samples, allow_destroy: true, :reject_if => lambda { |a| a[:description].blank? }
  has_many :tests, through: :samples

  validates :description, presence: true, length: { maximum: 200 }
  validates :lot, presence: true, length: { maximum: 100 }

  def batched?
    self.samples.each do |sample|
      sample.tests.each do |test|
        if test.batched?
          return true
        end
      end
    end
    return false
  end

  def status
    if self.received? || self.batched?
      "Started"
    elsif self.completed?
      "Completed"
    elsif self.reported?
      "Reported"
    else
      "Awaiting Receipt"
    end
  end

end