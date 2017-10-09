require 'rails_helper'

RSpec.describe PipetsController, type: :controller do
  before :each do
    @pipet = FactoryGirl.build(:pipet)
  end

  it 'has a valid factory' do
    expect(@pipet).to be_valid
  end

  describe 'before actions' do
    context '#admin_only' do
      it 'does not allow non-logged in people to see' do
        get :index
        expect(flash[:alert]).to be_present
        expect(response).to_not render_template :index
      end
      it 'does not allow customers to see index' do
        sign_in(FactoryGirl.create(:user))
        get :index
        expect(flash[:danger]).to be_present
        expect(response).to_not render_template :index
      end
      it 'does not allow analysts to see index' do
        sign_in(FactoryGirl.create(:analyst))
        get :index
        expect(flash[:danger]).to be_present
        expect(response).to_not render_template :index
      end
      it 'allows administrators access' do
        sign_in(FactoryGirl.create(:admin))
        get :index
        expect(response).to render_template :index
      end
    end
  end

  it 'finishes the tests'

end