require 'rails_helper'

RSpec.describe BatchesController, type: :controller do
  before :each do
    @batch = FactoryGirl.create(:batch)
  end

  it 'has a valid factory' do
    expect(@batch).to be_valid
  end

  describe 'before_actions' do
    it 'authenticates user' do
      sign_out :all
      get :index
      expect(response).to redirect_to new_user_session_path
    end
    it 'checks user is admin or analyst'
    it 'checks for cancel'
  end
end