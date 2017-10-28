require 'rails_helper'

RSpec.describe PipetsController, type: :controller do
  before :each do
    @pipet = FactoryGirl.create(:pipet)
  end

  it 'has a valid factory' do
    expect(@pipet).to be_valid
  end

  describe 'before actions' do
    context '#authenticate_user!' do
      it 'authenticates user' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end

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

    context '#check_for_cancel' do
      it 'checks cancel on create' do
        sign_in(FactoryGirl.create(:admin))
        expect {
          post :create, params: { pipet: @pipet.attributes, commit: "Cancel" } 
        }.to change(Pipet, :count).by(0)
      end
      it 'checks cancel on update' do
        sign_in(FactoryGirl.create(:admin))
        starting_volume = @pipet.min_volume
        patch :update, params: { id: @pipet.id, pipet: {min_volume: 1}, commit: "Cancel"}
        @pipet.reload
        expect(@pipet.min_volume).to eql(starting_volume)
      end
    end
  end

  describe '#index' do
    before :each do
      sign_in(FactoryGirl.create(:admin))
      3.times { FactoryGirl.create(:pipet) }
      get :index
    end
    it 'renders :index' do
      expect(response).to render_template :index
    end
    it 'finds all pipets' do
      expect(assigns(:pipets).count).to eql(4)
    end
  end

  describe '#new' do
    before :each do
      sign_in(FactoryGirl.create(:admin))
      get :new
    end
    it 'makes new pipet object' do
      expect(assigns(:pipet)).to be_a_new(Pipet)
    end
    it 'renders :new' do
      expect(response).to render_template :new
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'saves pipet'
      it 'flashes success'
      it 'redirects to index'
    end

    context 'with invalid params' do
      it 'does not save pipet'
      it 'flashes warning'
      it 'renders new template'
    end
  end

  describe '#edit' do
    it 'finds the pipet'
  end

  describe '#update' do
    context 'with valid params' do
      it 'updates the pipet'
      it 'flashes success' 
      it 'redirects to the index'
    end

    context 'with invalid params' do
      it 'does not update pipet'
    end
  end

  describe '#destroy' do
    it 'destroys the pipet'
    it 'flashes success'
    it 'redirects to index'
  end

end