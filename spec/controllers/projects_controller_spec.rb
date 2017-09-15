require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  before :each do
    sign_in FactoryGirl.create(:admin)
    @projects = Array.new
    3.times { @projects << FactoryGirl.create(:project_with_samples) }
  end

  context 'factories' do
    it 'has a valid factory' do
      expect(FactoryGirl.build(:project)).to be_valid
    end
    it 'has valid factory with tests' do
      expect(FactoryGirl.build(:project_with_samples)).to be_valid
    end
    it 'has valid factory with recieved project' do
      expect(FactoryGirl.build(:project_with_received_sample)).to be_valid
    end
    it 'has an invalid factory' do
      expect(FactoryGirl.build(:invalid_project)).to_not be_valid
    end
  end

  describe "#before_action methods" do
    it 'authenticates users' do
      sign_out :admin
      sign_out :user
      get :index
      expect(response).to redirect_to new_user_session_path
    end
    context "current_user matches project user" do
      it 'shows index'
      it 'shows new'
      it 'shows create'
    end
    context "current_user does not match" do
      it 'flashes danger'
      it 'redirects to root'
    end
    it 'disallows project after testing started'
  end

  describe 'GET #index' do
    it 'renders index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'assigns all projects if Admin or Analyst' do
      get :index
      expect(assigns(:projects).count).to eql(3)
    end

    it 'assigns customer projects for customer' do
      sign_out :admin
      sign_in FactoryGirl.create(:user)
      get :index
      expect(assigns(:projects).count).to eql(0)
    end
  end

  describe 'GET #new' do
    before :each do
      get :new
    end
    it 'renders new template' do
      expect(response).to render_template :new
    end
    it 'assigns new Project to @project' do
      expect(assigns(:project)).to be_a_new(Project)
    end
    it 'assigns methods to @methods' do
      expect(assigns(:methods)).to be_kind_of(Array)
    end
    it 'builds new samples' do
      project = FactoryGirl.create(:project_with_samples)
      expect(project.samples.count).to eql(1)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves Project to DB' do
        expect{
          post :create, params: { 
            project: FactoryGirl.attributes_for(:project_with_samples)
          }          
        }.to change{Project.count}.by(1)
      end
      it 'flashes success' do
        post :create, params: {project: FactoryGirl.attributes_for(:project_with_samples)}
        expect(flash[:success]).to be_present
      end
      it 'redirects to project' do
       post :create, params: {
          project: FactoryGirl.attributes_for(:project_with_samples)
        }
        expect(response).to redirect_to project_path(assigns(:project))
      end
    end

    context 'with invalid attributes' do
      it 'does not save to database' do
        expect {
          post :create, params: {project: FactoryGirl.attributes_for(:invalid_project)}
        }.to_not change(Project, :count)
      end
      it 'flashes warning' do
        post :create, params: { project: FactoryGirl.attributes_for(:invalid_project) }
        expect(flash[:warning]).to be_present
      end
      it 'renders new template' do
        post :create, params: { project: FactoryGirl.attributes_for(:invalid_project) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #show' do
    before :each do
      @project = FactoryGirl.create(:project)
      sign_in @project.user
      get :show, params: { id: @project }
    end
    it 'finds project' do
      expect(assigns(:project)).to eql(@project)
    end
    it 'renders the show template' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do
    before :each do
      @project = FactoryGirl.create(:project)
      sign_in @project.user
      get :edit, params: { id: @project }
    end
    it 'finds project' do
      expect(assigns(:project)).to eql(@project)
    end
    it 'builds @methods' do
      expect(assigns(:methods)).to be_kind_of(Array)
    end
    it 'renders the edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before :each do
        @project = FactoryGirl.create(:project_with_samples)
        sign_in @project.user
      end
      it 'updates project in database' do
        get :update, params: { id: @project, project: FactoryGirl.attributes_for(:project, lot: "Changed"), description: "changed" }
        @project.reload
        expect(@project.lot).to eql("Changed")
        expect(@project.description).to_not eql("changed")
      end
      it 'flashes success' do
        get :update, params: { id: @project, project: FactoryGirl.attributes_for(:project)}
        expect(flash[:success]).to be_present
      end
      it 'redirects to project' do
        get :update, params: { id: @project, project: FactoryGirl.attributes_for(:project)}
        expect(response).to redirect_to project_path(assigns(:project))
      end
    end

    context 'with invalid attributes' do
      before :each do
        @project = FactoryGirl.create(:project_with_samples)
        sign_in @project.user
      end
      it 'does not save changes to database' do 
        get :update, params: { id: @project, project: FactoryGirl.attributes_for(:project, lot: ""), description: "" }
        @project.reload
        expect(@project.lot).to eql("rspec lot")
        expect(@project.description).to_not eql("")
      end
      it 'flashes warning' do
        get :update, params: { id: @project, project: FactoryGirl.attributes_for(:project, lot: "") }
        expect(flash[:warning]).to be_present
      end
      it 'renders edit template' do
        get :update, params: { id: @project, project: FactoryGirl.attributes_for(:project, lot: "") }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @project = FactoryGirl.create(:project_with_samples)
      sign_in @project.user
    end
    it 'destroys project' do
      expect {
        delete :destroy, params: { id: @project }
      }.to change(Project, :count).by(-1)
    end
    it 'redirects to project index' do
      delete :destroy, params: { id: @project }
      expect(response).to redirect_to projects_path
    end
  end

  describe 'private methods' do
    context 'project_started?' do
      before :each do
        @project = FactoryGirl.create(:project_with_received_sample)
      end
      it 'flashes danger if project started' do
        sign_out :admin
        sign_in @project.user
        delete :destroy, params: { id: @project }
        expect(flash[:danger]).to be_present
      end
      it 'does not allow user deletion' do
        sign_out :admin
        sign_in @project.user
        expect {
          delete :destroy, params: { id: @project }
        }.to_not change(Project, :count)
      end
      it 'allows admin delete' do
        expect {
          delete :destroy, params: { id: @project }
        }.to change(Project, :count).by(-1)
      end
      it 'allows analyst delete' do
        sign_out :admin
        sign_in FactoryGirl.create(:analyst)
        expect {
          delete :destroy, params: { id: @project }
        }.to change(Project, :count).by(-1)
      end
    end
  end

end