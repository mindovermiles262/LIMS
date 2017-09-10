require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  before(:each) do
    request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in FactoryGirl.create(:admin)
    @projects = Array.new
    3.times { @projects << FactoryGirl.create(:project_with_tests) }
  end

  it 'has a valid facotory' do
    expect(FactoryGirl.build(:project)).to be_valid
    expect(FactoryGirl.build(:project_with_tests)).to be_valid
    expect(FactoryGirl.build(:project_with_received_test)).to be_valid
    expect(FactoryGirl.build(:invalid_project)).to_not be_valid
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
    it 'renders new template' do
      get :new
      expect(response).to render_template :new
    end
    it 'assigns new Project to @project' do
      get :new
      expect(assigns(:project)).to be_a_new(Project)
    end
    it 'assigns methods to @methods' do
      get :new
      expect(assigns(:methods)).to be_kind_of(Array)
    end
    it 'builds new tests' do
      get :new
      project = FactoryGirl.create(:project)
      project.tests = [FactoryGirl.create(:test)]
      expect(project.tests.count).to eql(1)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves Project to DB' do
        expect{
          post :create, params: { 
            project: FactoryGirl.attributes_for(:project_with_tests)
          }          
        }.to change{Project.count}.by(1)
      end
      it 'flashes success' do
        post :create, params: {project: FactoryGirl.attributes_for(:project_with_tests)}
        expect(flash[:success]).to be_present
      end
      it 'redirects to project' do
       post :create, params: {
          project: FactoryGirl.attributes_for(:project_with_tests)
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
    it 'finds project' do
      project = FactoryGirl.create(:project_with_tests)
      get :show, params: { id: project }
      expect(assigns(:project)).to eql(project)
    end
    it 'renders the show template' do
      project = FactoryGirl.create(:project)
      get :show, params: { id: project }
      expect(response).to render_template :show
    end
  end

  describe 'GET #edit' do
    it 'finds project' do
      project = FactoryGirl.create(:project_with_tests)
      get :edit, params: { id: project }
      expect(assigns(:project)).to eql(project)
    end
    it 'builds @methods' do
      project = FactoryGirl.create(:project)
      get :edit, params: { id: project }
      expect(assigns(:methods)).to be_kind_of(Array)
    end
    it 'renders the edit template' do
      project = FactoryGirl.create(:project)
      get :edit, params: { id: project }
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before :each do
        @project = FactoryGirl.create(:project_with_tests)
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
      before do
        @project = FactoryGirl.create(:project_with_tests)
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
      @project = FactoryGirl.create(:project_with_tests)
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
        @project = FactoryGirl.create(:project_with_received_test)
      end
      it 'flashes danger if project started' do
        sign_out :admin
        sign_in FactoryGirl.create(:user)
        delete :destroy, params: { id: @project }
        expect(flash[:danger]).to be_present
      end
      it 'does not allow user deletion' do
        sign_out :admin
        sign_in FactoryGirl.create(:user)
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