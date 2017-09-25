require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  it 'has a valid factory' do 
    @user = FactoryGirl.build(:user)
    @admin = FactoryGirl.build(:admin)
    expect(@user).to be_valid
    expect(@admin).to be_valid
  end

  describe 'before actions' do
    context 'authenticates user' do
      it 'redirects if not logged in' do
        # No user has been signed in
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context '#correct_user?' do
      it 'matches correct user' do
        @user = FactoryGirl.create(:user)
        sign_in(@user)
        get :show, params: { id: @user.id }
        expect(assigns(:user)).to eql(@user)
      end
      it 'redirects with invalid match' do
        @user = FactoryGirl.create(:user)
        @second_user = FactoryGirl.create(:user)
        sign_in(@user)
        get :show, params: { id: @second_user.id }
        expect(flash[:danger]).to be_present
        expect(response).to redirect_to root_path
      end
    end
    context '#admin_user?' do
      it 'requires admin user' do
        @admin = FactoryGirl.create(:admin)
        @user = FactoryGirl.create(:user)
        sign_in(@admin)
        get :show, :params => { id: @user.id }
        expect(response).to redirect_to user_path(@user.id)
      end
      it 'requires admin user except show'
    end
  end
end
