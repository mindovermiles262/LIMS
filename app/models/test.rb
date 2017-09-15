class Test < ApplicationRecord
  belongs_to :sample
  belongs_to :test_method
  has_many :batches

  def Test.methods_not_batched
    select(:test_method_id).distinct.where(batched: false)
  end
  
  def Test.available_for_batching(*method_id)
    if method_id.present?
      where(batch_id: nil, :test_method_id => method_id)
    else
      where(batch_id: nil)
    end
  end
end
