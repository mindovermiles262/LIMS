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
    it 'passing params' do
      @parameters = {
        name: "Aerobic Plate Count",
        target_organism: "APC",
        reference_method: "AOAC",
        turn_around_time: 2,
        detection_limit: 10,
        unit: 'CFU/g'
      }
      expect{
        post :create, params: { test_method: @parameters }
      }.to change{ TestMethod.count }.by(1)
      @parameters[:name] = "HARRY"
      post :create, params: { test_method: @parameters }
      expect(TestMethod.last.name).to eql("HARRY")            
    end
  end


  describe 'GET #index' do
    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end
    it 'lists all created test methods' do
      method = FactoryGirl.create(:test_method)
      get :index
      expect(assigns(:test_methods)).to match_array([method])
    end
  end

  describe 'GET #show' do
    before :each do
      @method = FactoryGirl.create(:test_method)
    end
    it 'finds test method' do
      get :show, params: { id: @method }
      expect(assigns(:test_method)).to eql(@method)
    end
    it 'renders the show template' do
      get :show, params: { id: @method }
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do
    it 'assigns TestMethod to @test_method' do
      method = FactoryGirl.create(:test_method)
      get :edit, params: { id: method.id }
      expect(assigns(:test_method)).to eq method
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
    it 'renders the :edit template' do
      get :new
      expect(response).to render_template :new
    end
  end


  describe 'PUT #update' do
    before(:each) do
      @method = FactoryGirl.create( :test_method,
        name: "Rspec Testing",
        target_organism: "RSpec"
      )
    end

    it 'has a valid creation' do
      expect(@method).to be_valid
    end

    context 'with valid parameters' do
      it 'locates the correct Test Method' do
        patch :update, params: { id: @method, test_method: FactoryGirl.attributes_for(:test_method) }
        expect(assigns(:test_method)).to eql(@method)
      end
      it 'updates the Test Method' do
        patch :update, params: { id: @method, test_method: FactoryGirl.attributes_for(:test_method,
          name: "Should Update", target_organism: "Water") }
        @method.reload
        expect(@method.name).to eql("Should Update")
        expect(@method.target_organism).to eql("Water")
      end
      it 'flashes success message' do
        patch :update, params: { id: @method, test_method: FactoryGirl.attributes_for(:test_method) }
        expect(flash[:success]).to be_present
      end
      it 'redirects to :index' do
        patch :update, params: { id: @method, test_method: FactoryGirl.attributes_for(:test_method) }
        expect(response).to redirect_to test_methods_path
      end
    end

    context 'with invalid parameters' do
      it 'does not update the Test method' do
        patch :update, params: { id: @method, test_method: FactoryGirl.attributes_for(:test_method,
          name: "", target_organism: "Earth" )}
        @method.reload
        expect(@method.name).to eql("Rspec Testing")
        expect(@method.target_organism).to_not eql("Earth")
      end
      it 'renders the :edit template' do
        patch :update, params: { id: @method, test_method: FactoryGirl.attributes_for(:test_method,
          name: "", target_organism: "Earth") }
        expect(response).to render_template :edit
      end
    end
  end


  describe 'DELETE #destroy' do
    before(:each) do
      @method = FactoryGirl.create(:test_method)
    end

    it 'has a valid @method' do
      expect(@method).to be_valid
    end
    it 'deletes Test Method' do
      expect { 
        delete :destroy, params: { id: @method }
      }.to change(TestMethod, :count).by(-1)
    end
    it 'flashes success message' do
      delete :destroy, params: { id: @method }
      expect(flash[:success]).to be_present
    end
    it 'redirects to :index' do
      delete :destroy, params: { id: @method }
      expect(response).to redirect_to test_methods_path
    end
  end


  describe 'Private Methods' do
    describe 'check for cancel in params' do
      it 'redirects to :index on #create' do
        post :create, params: { commit: "Cancel" }
        expect(response).to redirect_to test_methods_path
      end

    end

    describe 'admin user' do
      before(:each) do 
        sign_out :admin
        request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in FactoryGirl.create(:analyst)
      end
      context 'as non-administrator' do
        it 'flashes danger message' do
          get :new
          expect(flash[:danger]).to be_present
        end
        it 'redirects to root path' do
          get :new
          expect(response).to redirect_to root_path
        end
      end
    end
  end
end