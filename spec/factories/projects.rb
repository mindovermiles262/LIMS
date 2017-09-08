FactoryGirl.define do
  factory :project do
    association :user do
      FactoryGirl.build(:user)
    end
  end
end