require 'rails_helper'

RSpec.describe TestMethodsController, type: :controller do
  # Sign in as Administator for all tests
  before(:each) do 
    request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in FactoryGirl.create(:admin)
  end

  
  it 'has a valid factory' do
    expect(FactoryGirl.build(:test_method)).to be_valid
  end


  describe 'GET #new' do
    it 'assigns new TestMethod to @test_method' do
      get :new
      expect(assigns(:test_method)).to be_a_new(TestMethod)
    end
    it 'assigns all TestMethod.target_organisms to @target_organisms' do
      get :new
      expect(assigns(:target_organisms)).to be_kind_of(Array)
    end
    it 'assigns all TestMethod.reference_methods to @reference_methods' do
      get :new
      expect(assigns(:reference_methods)).to be_kind_of(Array)
    end
    it 'assigns all TestMethod.units to @units' do
      get :new
      expect(assigns(:units)).to be_kind_of(Array)
    end
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end


  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves TestMethod to database' do
        expect{
          post :create, params: { test_method: FactoryGirl.attributes_for(:test_method) }          
        }.to change{TestMethod.count}.by(1)
      end
      it 'flashes confirmation message' do
        post :create, params: { test_method: FactoryGirl.attributes_for(:test_method) }
        expect(flash[:info]).to be_present
      end
      it 'redirects to :index' do
        post :create, params: { test_method: FactoryGirl.attributes_for(:test_method) }
        expect(response).to redirect_to test_methods_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save TestMethod in database' do
        expect{
          post :create, params: { test_method: FactoryGirl.attributes_for(:invalid_test_method) }          
        }.to change{TestMethod.count}.by(0)
      end
      it 'flashes danger message' do
        post :create, params: { test_method: FactoryGirl.attributes_for(:invalid_test_method) }
        expect(flash[:danger]).to be_present
      end
      it 'renders the :new template' do
        post :create, params: { test_method: FactoryGirl.attributes_for(:invalid_test_method) }
        expect(response).to render_template :new
      end
    end
  end


  describe 'GET #index' do
    it 'lists all test methods'
    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #edit' do
    it 'assigns TestMethod to @test_method' do
      method = FactoryGirl.create(:test_method)
      get :edit, params: { id: method.id }
      expect(assigns(:test_method)).to eq method
    end
    it 'assigns target_organisms to @target_organisms'
    it 'assigns reference_methods to @reference_methods'
    it 'assigns units to @units'
    it 'renders the :edit template'
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      it 'updates Test Method in database'
      it 'flashes success message'
      it 'redirects to :index'
    end
    context 'with invalid parameters' do
      it 'does not update Test method in database'
      it 'renders the :edit template'
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes Test Method'
    it 'flashes success message'
    it 'redirects to :index'
  end

  describe 'Private Methods' do
    describe 'check for cancel in params' do
      it 'redirects to :index'
    end

    describe 'admin user' do
      context 'as non-administrator' do
        it 'flashes danger message'
        it 'redirects to :root path'
      end
    end
  end
end