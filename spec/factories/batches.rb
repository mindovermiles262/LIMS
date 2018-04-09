FactoryBot.define do
  factory :batch do
    association :test_method, factory: :test_method
    after(:build){ |b| b.tests << FactoryGirl.create(:test, test_method: b.test_method) }
    after(:build){ |b| b.pipets << FactoryGirl.create(:pipet, batches: [b])}
  end
end
