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

  describe TestMethodsController do
    it "has valid creation"
    it "can be changed by admins only"
  end

end