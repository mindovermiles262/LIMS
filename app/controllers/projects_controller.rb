class ProjectsController < ApplicationController
  before_action :authenticate_user!

  # TODO: Limit #index by User
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    @methods = TestMethod.all.map { |m| [m.name, m.id] }
    3.times { @project.tests.build }
  end

  def create
    @project = Project.new(project_params)
    if @project.save!
      # raise
      flash[:success] = "Project Created"
      redirect_to @project
    else
      flash[:danger] = "Unable to create Project"
      render :new
    end
  end
  
  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
    @methods = TestMethod.all.map { |m| [m.name, m.id] }
    (1 - @project.tests.count).times { @project.tests.build }
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:success] = "Project updated"
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    Project.find(params[:id]).destroy
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:user_id, :description, :lot, :tests_attributes => [:test_method_id, :id])
  end

end