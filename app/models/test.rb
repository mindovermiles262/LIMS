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
end
