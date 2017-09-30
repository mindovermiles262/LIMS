class Batch < ApplicationRecord
  has_many :tests
  belongs_to :test_method
  accepts_nested_attributes_for :tests, :allow_destroy => true
  has_many :pipets

  after_update { self.tests.update_all(batched: true) }
  after_update { self.destroy if self.tests.count < 1 }

  after_destroy { |record| record.tests.update_all(batched: false)}

  
  def Batch.available_methods
    available = Array.new
    Test.select(:test_method_id).distinct.where('batched=? OR batch_id=?', false, '0').map do |method|
      available << [TestMethod.find_by(id: method.test_method_id).name, method.test_method_id]
    end
    available
  end

  def completed?
    self.tests.each do |test|
      test.result == nil ? (return false) : next
    end
    return true
  end

end
