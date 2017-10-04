class Test < ApplicationRecord
  
  belongs_to :sample
  has_one :project, through: :sample
  belongs_to :test_method
  belongs_to :batch, optional: true
  
  def Test.available_for_batching(*method_id)
    if method_id.present?
      where(batch_id: nil, :test_method_id => method_id)
    else
      where(batch_id: nil)
    end
  end

  def status
    if self.result == nil && self.batched == false
      "Not Started"
    elsif self.result == nil && self.batched == true
      "In Progresss"
    elsif self.result != nil
      "#{result} #{self.test_method.unit}"
    end
  end

  def Test.unbatched(test_method_id)
    Test.where('batched=?', false)
      .or(Test.where('batch_id=?', 0))
      .where('test_method_id=?', test_method_id)
      .sort{ |a,b| a.id <=> b.id }
  end

  def remove
    self.update_attributes(batch_id: nil)
  end
end
