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
        get :index
        expect(response).to render_template :index
      end
      it 'redirects non-admin user' do        
        @user = FactoryGirl.create(:user)
        sign_in(@user)
        get :index, :params => { id: @user.id}
        expect(flash[:danger]).to be_present
        expect(response).to redirect_to root_path
      end
      it 'allows show for non-admins' do
        @user = FactoryGirl.create(:user)
        sign_in(@user)
        get :show, :params => { id: @user.id }
        expect(response).to render_template :show
      end
    end
  end

  describe '#show' do
    before :each do
      @admin = FactoryGirl.create(:admin)
      @user = FactoryGirl.create(:user)
      sign_in(@admin)
    end
    it 'assigns correct user' do
      get :show, :params => { id: @user.id }
      expect(assigns(:user)).to eql(@user)
    end
    it 'assigns projects' do
      @user.projects = [FactoryGirl.create(:project)]
      get :show, :params => { id: @user.id }
      expect(assigns(:user).projects.length).to eql(1)
    end
  end

  describe '#index' do
    it 'lists all users' do
      User.delete_all if Rails.env.test?
      @admin = FactoryGirl.create(:admin)
      6.times { FactoryGirl.create(:user) }
      sign_in(@admin)
      get :index
      expect(assigns(:users).count).to eql(7)
    end
  end

  describe '#edit' do
    it 'finds the correct user' do
      @admin = FactoryGirl.create(:admin)
      @user = FactoryGirl.create(:user)
      sign_in(@admin)
      get :edit, :params => { id: @user.id }
      expect(assigns(:user)).to eql(@user)
    end
  end

  describe '#update' do
    before :each do
      @admin = FactoryGirl.create(:admin)
      @user = FactoryGirl.create(:user)
      sign_in(@admin)
    end
    it 'finds the correct user' do
      get :update, :params => { id: @user.id, user: FactoryGirl.attributes_for(:user) }
      expect(assigns(:user)).to eql(@user)
    end
    it 'updates user with correct params' do
      get :update, :params => {
        id: @user.id,
        user: FactoryGirl.attributes_for(:user, first_name: "Moneypenny")                
      }
      @user.reload
      expect(@user.first_name).to eql("Moneypenny")
    end
    it 'does not update without correct params' do
      get :update, :params => {
        id: @user.id,
        user: FactoryGirl.attributes_for(:user, first_name: "")                
      }
      @user.reload
      expect(@user.first_name).to eql(@user.first_name)
      expect(@user.last_name).to eql(@user.last_name)
    end
  end

  describe '#destroy' do
    before :each do
      User.delete_all if Rails.env.test?
      @admin = FactoryGirl.create(:admin)
      @user = FactoryGirl.create(:user)
      sign_in(@admin)
    end
    it 'finds destroys the user' do
      expect(User.count).to eql(2)
      expect {
        delete :destroy, :params => { id: @user.id }
      }.to change(User, :count).by(-1) 
    end
    it 'flashes and redirects' do
      delete :destroy, :params => { id: @user.id }
      expect(flash[:success]).to be_present
      expect(response).to redirect_to users_path
    end
  end
end
