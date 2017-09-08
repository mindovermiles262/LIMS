FactoryGirl.define do
  factory :test do
    association :test_method {FactoryGirl.build(:test_method)}
    association :project { FactoryGirl.build(:project) }
  
    factory :received_test do
      received true
    end

    factory :reported_test do
      result 10
      received true
      started true
      completed true
      reported true
      PA false
    end
  end
end
