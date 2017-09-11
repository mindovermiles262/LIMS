FactoryGirl.define do
  factory :test do
    association :test_method, factory: :test_method
    association :project, factory: :project

    factory :reported_test do
      result 10
    end
  end
end
