FactoryGirl.define do
  factory :project do
    association :user, factory: :user
    description "rspec"
    lot "rspec lot"
    factory :project_with_tests do
      after(:build) do |project|
        create(:test, project: project)
      end
    end

    factory :project_with_received_test do
      received true
      after(:build) do |project|
        create(:test, project: project)
      end
    end
    factory :invalid_project do
      lot ""
    end
  end
end