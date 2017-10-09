FactoryGirl.define do
  factory :batch do
    association :test_method, factory: :test_method
    
  end
end
