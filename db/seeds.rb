User.delete_all# if Rails.env.development?
TestMethod.delete_all# if Rails.env.development?
Project.delete_all# if Rails.env.development?
Test.delete_all# if Rails.env.development?
Batch.delete_all# if Rails.env.development?

# Create Admin, Analyst, User

User.create!(
  first_name: Faker::Name.first_name,
  last_name: "Customer",
  email: "customer@example.com",
  company: "Pine Inc.",
  password: "foobar",
  password_confirmation: "foobar"
)
# Create Admin
User.create!(
  first_name: "Admin",
  last_name: "User",
  email: "admin@example.com",
  company: "Sequoia Inc.",
  password: "foobar",
  password_confirmation: "foobar",
  admin: true,
)
# Create Analyst
User.create!(
  first_name: "Analyst",
  last_name: "User",
  email: "analyst@example.com",
  company: "Sequoia Inc.",
  password: "foobar",
  password_confirmation: "foobar",
  analyst: true
)
# Seed fake users
25.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    company: Faker::Company.name,
    password: "foobar",
    password_confirmation: "foobar"
  )
end


# Create Test Methods
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


# Create Projects
5.times do
  Project.create!(
    user: User.find(rand(User.first.id..User.last.id)),
    lot: Faker::Code.isbn,
    description: Faker::Coffee.blend_name,
    samples_attributes: [
      { description: Faker::Coffee.notes.capitalize,
        tests_attributes: [
          { test_method_id: TestMethod.first.id },
          { test_method_id: TestMethod.second.id }
        ]
      },
      { description: Faker::Coffee.notes.capitalize,
        tests_attributes: [
          { test_method_id: TestMethod.first.id },
          { test_method_id: TestMethod.second.id }
        ]
      },
      { description: Faker::Coffee.notes.capitalize,
        tests_attributes: [
          { test_method_id: TestMethod.first.id },
          { test_method_id: TestMethod.second.id }
        ]
      },
    ]
  )
end
Project.create!(
  user: User.first,
  lot: Faker::Code.isbn,
  description: Faker::Coffee.blend_name,
  samples_attributes: [
    { description: Faker::Coffee.notes.capitalize,
      tests_attributes: [
        { test_method_id: TestMethod.first.id },
        { test_method_id: TestMethod.second.id }
      ]
    },
    { description: Faker::Coffee.notes.capitalize,
      tests_attributes: [
        { test_method_id: TestMethod.first.id },
        { test_method_id: TestMethod.second.id }
      ]
    },
    { description: Faker::Coffee.notes.capitalize,
      tests_attributes: [
        { test_method_id: TestMethod.first.id },
        { test_method_id: TestMethod.second.id }
      ]
    },
  ]
)


# Seed Batches
# Batch.create!(
#   test_method: TestMethod.first, 
#   tests: Test.where(test_method: TestMethod.first)
# )
# Batch.create!(
#   test_method: TestMethod.second, 
#   tests: Test.where(test_method: TestMethod.second)
# )