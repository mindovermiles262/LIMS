class Project < ApplicationRecord
  belongs_to :user

  has_many :samples
  accepts_nested_attributes_for :samples, allow_destroy: true, :reject_if => lambda { |a| a[:description].blank? }

  validates :description, presence: true, length: { maximum: 200 }

  def batched?
    self.samples.each { |sample| return true if sample.batched? }
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