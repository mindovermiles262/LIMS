FactoryGirl.define do
  factory :batch do
    association :test_method, factory: :test_method
    after(:create){ |b| b.tests << FactoryGirl.create(:test, test_method: b.test_method) }
    after(:create){ |b| b.pipets << FactoryGirl.create(:pipet, batches: [b])}
  end
end
