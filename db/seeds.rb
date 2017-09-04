# Create Admin, Analyst, User
Admin.delete_all if Rails.env.development?
Analyst.delete_all if Rails.env.development?
User.delete_all if Rails.env.development?

Admin.create!(
  first_name: "Admin",
  last_name: "User",
  email: "admin@example.com",
  password: "foobar",
  password_confirmation: "foobar",
  admin: true,
)
Analyst.create!(
  first_name: "Analyst",
  last_name: "User",
  email: "analyst@example.com",
  password: "foobar",
  password_confirmation: "foobar",
  analyst: true
)
User.create!(
  first_name: "Customer",
  last_name: "User",
  email: "customer@example.com",
  password: "foobar",
  password_confirmation: "foobar"
)

# Seed fake data

Admin.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  password: "foobar",
  password_confirmation: "foobar",
  admin: true
)
10.times do
  Analyst.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "foobar",
    password_confirmation: "foobar",
    analyst: true
  )
end
50.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "foobar",
    password_confirmation: "foobar"
  )
end


# Create Test Methods
TestMethod.delete_all if Rails.env.development?
test_methods = [ ["APC PF", "APC", "AOAC", 2, 10, "CFU/g"], 
                 ["RY&M PF", "Y&M", "AOAC", 2, 10, "CFU/g"] ]

test_methods.each do |set|
  TestMethod.create!(
    name: set[0],
    target_organism: set[1],
    reference_method: set[2],
    turn_around_time: set[3],
    detection_limit: set[4],
    unit: set[5])
end

# # Create Project
Project.delete_all if Rails.env.development?
Project.create(
    user: User.second,
    description: "Second User Project Description",
    lot: "123ABC",
    tests: [Test.first, Test.second]
)
