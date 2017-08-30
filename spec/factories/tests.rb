FactoryGirl.define do
  factory :test do
    result 10
    received true
    started true
    completed true
    reported true
    PA false
    association :test_method { FactoryGirl.build(:test_method) }
    association :project { FactoryGirl.build(:project) }
    # association :user { FactoryGirl.build(:user) }
    # association :analysts { [FactoryGirl.build(:analyst)] }
  end
end
