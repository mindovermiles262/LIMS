require 'rails_helper'

feature 'user logs out' do
  given!(:user){ FactoryGirl.create(:user) }

  scenario 'as user' do
    login_as(user, :scope => :user)
    visit '/'
    # Verify sign_in
    expect(page).to have_css("div.navbar-item", text: "#{user.first_name}")

    click_button "Log Out"
    expect(page).to have_css('div.is-notice')
    expect(page).to have_content("Signed out successfully.")
    expect(page).to have_content("Log In")
  end
end