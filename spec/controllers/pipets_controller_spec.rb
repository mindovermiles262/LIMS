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
    before :each { sign_in(FactoryGirl.create(:admin)) }
    context 'with valid params' do
        it 'saves pipet' do
        expect {
          post :create, :params => { pipet: @pipet.attributes }        
        }.to change(Pipet, :count).by(1)
      end
      it 'flashes success' do
        post :create, :params => { pipet: @pipet.attributes }
        expect(flash[:success]).to be_present
      end
      it 'redirects to index' do
        post :create, :params => { pipet: @pipet.attributes }
        expect(response).to redirect_to pipets_path        
      end
    end

    context 'with invalid params' do
      it 'does not save pipet' do
        @pipet.max_volume = nil
        expect {
          post :create, :params => { pipet: @pipet.attributes }        
        }.to change(Pipet, :count).by(0)
      end
      it 'flashes warning' do
        @pipet.max_volume = nil
        post :create, :params => { pipet: @pipet.attributes }
        expect(flash[:warning]).to be_present
      end
      it 'renders new template' do
        @pipet.max_volume = nil
        post :create, :params => { pipet: @pipet.attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe '#edit' do
    before :each { sign_in(FactoryGirl.create(:admin)) }
    it 'finds the pipet' do
      get :edit, :params => { id: @pipet.id }
      expect(assigns(:pipet)).to eql(@pipet)
    end
  end

  describe '#update' do
    before :each { sign_in(FactoryGirl.create(:admin)) }
    context 'with valid params' do
      it 'updates the pipet' do
        @pipet.max_volume = 500
        patch :update, :params => { id: @pipet.id, pipet: @pipet.attributes }
        @pipet.reload
        expect(@pipet.max_volume).to eql(500)
      end
      it 'flashes success' do
        @pipet.max_volume = 500
        patch :update, :params => { id: @pipet.id, pipet: @pipet.attributes }
        @pipet.reload
        expect(flash[:success]).to be_present
      end
      it 'redirects to the index' do
        @pipet.max_volume = 500
        patch :update, :params => { id: @pipet.id, pipet: @pipet.attributes }
        @pipet.reload
        expect(response).to redirect_to pipets_path
      end
    end

    context 'with invalid params' do
      it 'does not update pipet' do
        sign_in(FactoryGirl.create(:admin))
        volume = @pipet.max_volume
        @pipet.max_volume = nil
        patch :update, :params => { id: @pipet.id, pipet: @pipet.attributes }
        @pipet.reload
        expect(@pipet.max_volume).to eql(volume)
      end
    end
  end

  describe '#destroy' do
    before :each { sign_in(FactoryGirl.create(:admin)) }
    it 'destroys the pipet' do
      expect {
        delete :destroy, :params => { id: @pipet.id }                
      }.to change(Pipet, :count).by(-1)
    end
    it 'flashes success' do
      delete :destroy, :params => { id: @pipet.id }
      expect(flash[:success]).to be_present
    end
    it 'redirects to index' do
      delete :destroy, :params => { id: @pipet.id }
      expect(response).to redirect_to pipets_path
    end
  end

end