require 'rails_helper'

feature 'User Logs In' do
  given!(:user){ FactoryGirl.create(:user) }

  scenario 'with valid inputs' do
    visit '/'
    click_button "Log In"
    expect(current_path).to eql(new_user_session_path)
    expect(page).to have_css("h2", text: "Log in")
    
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button 'Sign in'
    expect(page).to_not have_css("h2", text: "Log in")
    expect(page).to have_content 'Signed in successfully.'
  end
end