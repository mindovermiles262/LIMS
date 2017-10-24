require 'rails_helper'

RSpec.describe BatchesController, type: :controller do
  before :each do
    @batch = FactoryGirl.create(:batch)
  end

  it 'has a valid factory' do
    expect(@batch).to be_valid
    expect(FactoryGirl.create(:test)).to be_valid
    expect(FactoryGirl.create(:alternate_test_method)).to be_valid
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
      @test = FactoryGirl.create(:test)
      @test2 = FactoryGirl.create(:test)
      @test3 = FactoryGirl.create(:test, test_method_id: @test.test_method_id)
      get :new
      expect(assigns(:available_methods)).to eql([
        [@test.test_method.name, @test.test_method_id], [@test2.test_method.name, @test2.test_method_id]
      ])
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
    before :each do
      sign_in(FactoryGirl.create(:analyst))
    end
    context 'with valid parameters' do
      it 'creates new batch' do
        expect {
          post :create, params: { batch: @batch.attributes }
        }.to change { Batch.count }.by(1)
      end
      it 'renders flash' do
        post :create, params: { batch: @batch.attributes }
        expect(flash[:info]).to be_present
      end
      it 'redirects to edit batch' do
        post :create, params: { batch: @batch.attributes }
        expect(response).to redirect_to edit_batch_path(assigns(:batch))
      end
    end

    context 'with invalid parameters' do
      before :each do
        @invalid_batch = Batch.create()
      end
      it 'does not save new batch' do
        expect {
          post :create, params: { batch: @invalid_batch.attributes }
        }.to change{ Batch.count }.by(0)
      end
      it 'flashes danger' do
        post :create, params: { batch: @invalid_batch.attributes }
        expect(flash[:danger]).to be_present
      end
      it 'renders new template' do
        post :create, params: { batch: @invalid_batch.attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe '#add' do
    before :each do
      sign_in(FactoryGirl.create(:analyst))
      @batch = FactoryGirl.create(:batch)
      @test = FactoryGirl.create(:test, batch: @batch)
    end
    it 'finds the test' do
      get :add, :params => {batch_id: @batch.id, id: @test.id}
      expect(assigns(:test)).to eql(@test)
    end
    it 'finds the batch' do
      get :add, :params => {batch_id: @batch.id, id: @test.id}
      expect(assigns(:batch)).to eql(@batch)
    end
    it 'add test with valid parameters' do
      test = Test.create!(test_method: @batch.test_method, sample: Sample.first)
      expect {
        post :add, :params =>{batch_id: @batch.id, id: test.id}
      }.to change { @batch.tests.count }.by(1)
    end
    it 'flashes danger with invalid params' do
      alt_test_method = FactoryGirl.create(:alternate_test_method)
      test = Test.create!(test_method: alt_test_method, sample: Sample.first)
      post :add, :params => { batch_id: @batch.id, id: test.id }

      expect(flash[:danger]).to be_present
    end
    it 'redirects with invalid params' do
      alt_test_method = FactoryGirl.create(:alternate_test_method)
      test = Test.create!(test_method: alt_test_method, sample: Sample.first)
      post :add, :params => { batch_id: @batch.id, id: test.id }

      expect(response).to redirect_to edit_batch_path(@batch)
    end
  end

  describe "#edit" do
    it 'finish the batches_controller_spec'
  end

  describe "#results" do
  end

  describe "#update" do
  end

  describe "#destroy" do
  end

end