class Pipet < ApplicationRecord
  has_and_belongs_to_many :batches

  validates :calibration_date, presence: true
  validates :calibration_due, presence: true
  validates :max_volume, presence: true, numericality: { only_integer: true }
  validates :min_volume, presence: true, numericality: { only_integer: true }
  validates :adjustable, inclusion: { in: [true, false]}
end
