# Appert

The worlds first open source laboratory information management system

## Sample Workflow

One-time Admin Setup:
1. Create Test Methods (APC Pour Plate, Y&M Spread Plate, etc.)

Customer Use:
1. Customer creates new project, logs in sample, applies specific tests to sample.
2. Sample is marked as "received" when sample arrives at laboratory
3. All samples (from various customers) are grouped together by Test Methods into Batches
4. Batch results are entered upon test completion
5. Notification email is sent to customer with results
6. Customer is also able to log in to see results of previous projects.

## Built with
* Ruby v. 2.4
* Rails v. 5.1

## Getting Started
1. Clone the repository
2. Run `bundle install`
3. Migrate the database, `rails db:migrate`
4. `rails s` to start server
5. Navigate to `localhost:3000`

Note: You may add first Admin User by using `rails console` and entering information. This Admin may then set permissions for all other users.

## System dependencies
To Visualize Relationships with `rails-erd` gem, `graphviz` must be installed.
  (`sudo apt-get install graphviz` or `brew install graphviz`)

## Testing
Features of Appert are covered by an RSpec testing suite. Run `bundle exec rspec` to test.

SimpleCov gem installed in test environment to provide coverage information

## Contributing

Please follow a "Fork-and-Pull" when contributing
1. Fork the repository into your own account
2. Run program locally and make any changes
3. Be sure to include any RSpec testing to cover your additions.
4. Create a pull request to merge changes