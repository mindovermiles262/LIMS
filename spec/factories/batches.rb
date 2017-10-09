FactoryGirl.define do
  factory :batch do
    association :test_method, factory: :test_method
    after(:create) { |b| b.tests << FactoryGirl.create(:test) }
  end
end
