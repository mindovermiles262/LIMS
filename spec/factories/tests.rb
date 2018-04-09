FactoryBot.define do
  factory :test do
    association :test_method, factory: :test_method
    association :sample, factory: :sample

    factory :batched_test do
      batched true
    end

  end
end
