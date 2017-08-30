FactoryGirl.define do
  factory :project do
    association :user do
      build(:user)
    end
  end
end