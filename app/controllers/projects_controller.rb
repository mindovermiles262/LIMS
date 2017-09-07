class ProjectsController < ApplicationController
  before_action :authenticate_user!

  # TODO: Limit #index by User
  def index
    @projects = Project.where(user_id: current_user.id)
  end

  def new
    @project = Project.new
    @methods = TestMethod.all.map { |m| [m.name, m.id] }
    @project.tests.build
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = "Project Created"
      redirect_to @project
    else
      flash[:warning] = "Unable to create project"
      render :new
    end
  end
  
  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
    @methods = TestMethod.all.map { |m| [m.name, m.id] }
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:success] = "Project updated"
      redirect_to @project
    else
      flash[:warning] = "Unable to edit project"
      render :edit
    end
  end

  def destroy
    Project.find(params[:id]).destroy
    redirect_to projects_path
  end

  def add_form_field
  end

  private

  def project_params
    params.require(:project).permit(:user_id, :description, :lot, :tests_attributes => [:test_method_id, :id, :_destroy])
  end

end