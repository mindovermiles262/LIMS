FactoryGirl.define do
  factory :user do
    first_name  { Faker::Name.first_name }
    last_name   { Faker::Name.last_name }
    company     { Faker::Company.name }
    email       { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    factory :analyst do
      analyst true
    end
    factory :admin do
      admin true
    end
  end
end
