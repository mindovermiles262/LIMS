require 'rails_helper'

RSpec.describe TestMethodsController, type: :controller do
  before do
    @customer = User.create(
      first_name: "Test",
      last_name: "User",
      company: "Sequoia",
      email: "user@example.com",
      password: "foobar",
      password_confirmation: "foobar"                                         
    )
  end

  it "has valid creation" do
    expect(@customer).to be_valid
  end

  it "can be changed by admins only" do
    expect(get test_methods_path).to redirect_to(root_path)
  end

end