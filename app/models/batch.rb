class Batch < ApplicationRecord
  has_many :tests
  has_one :test_method

  after_create :update_batched_status

  private

  def update_batched_status
    tests.update_all(batched: true)
  end

end
