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
    it 'checks user is admin or analyst' do
      sign_out :all
      sign_in(FactoryGirl.create(:user))
      get :index
      expect(response).to redirect_to root_path
      sign_out :user
      sign_in(FactoryGirl.create(:analyst))
      get :index
      expect(response).to render_template :index
      sign_out :analyst
      sign_in(FactoryGirl.create(:admin))
      get :index
      expect(response).to render_template :index
    end
    it 'checks for cancel' do
      sign_in(FactoryGirl.create(:analyst))
      post :create, params: { test_method: TestMethod.first, commit: "Cancel" }
      expect(response).to redirect_to batches_path
      expect{response}.to change{Batch.count}.by (0)
    end
  end

  describe '#index' do
    it 'finds all batches' do
      sign_in(FactoryGirl.create(:analyst))
      get :index
      expect(assigns(:batches).count).to eql(1) 
    end
  end

  describe '#show' do
    before :each do
      sign_in(FactoryGirl.create(:analyst))
    end
    it 'finds the batch' do
      get :show, params: { id: @batch.id }
      expect(assigns(:batch)).to eql(@batch)
    end
    it 'populates the pipets' do
      @pipet = FactoryGirl.create(:pipet)
      @batch.pipets = [@pipet]
      get :show, params: { id: @batch.id }
      expect(assigns(:pipets)).to eql("P#{@pipet.id}")
    end
  end

  describe '#new' do
    before :each do
      sign_in(FactoryGirl.create(:analyst))
    end
    it 'sets available methods' do
      get :new
      expect(assigns(:available_methods)).to eql(
        [[@batch.tests.first.test_method.name, @batch.tests.first.test_method_id]]
      )
    end
    it 'sets batch' do
      get :new
      expect(assigns(:batch)).to be_a_new(Batch)
    end
    it 'builds batch with tests' do
      @test = FactoryGirl.create(:test)
      @batch.tests = [@test]
      expect(@batch.tests.count).to eql(1)
    end
  end

  describe '#create' do
    context 'with valid parameters' do
      it 'creates new batch' do
        sign_in(FactoryGirl.build(:analyst))
        expect {
          post :create, params: { batch: FactoryGirl.attributes_for(:batch) }
        }.to change { Batch.count }.by(1)
      end
      it 'renders flash' do
        post :create, params: { batch: FactoryGirl.attributes_for(:batch) }
        expect(flash[:info]).to be_present
      end
      it 'redirects to edit batch'
    end
    context 'with invalid parameters' do
      it 'does not save new batch'
      it 'flashes danger'
      it 'renders new template'
    end
  end

  describe '#add' do
    it 'finds the test' 
    it 'finds the batch'
    it 'add test with valid parameters'
    it 'flashes danger with invalid params'
    it 'redirects with invalid params'
  end
end