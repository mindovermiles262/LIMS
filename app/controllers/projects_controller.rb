class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :project_started?, only: [:edit, :update, :destroy]

  # TODO: Limit #index by User
  def index
    if current_user.admin? || current_user.analyst?
      @projects = Project.all
    elsif current_user
      @projects = Project.where(user_id: current_user.id)
    end
  end

  def new
    @project = Project.new
    @project.samples.build
    @methods = TestMethod.all.map { |m| [m.name, m.id] }
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id if current_user
    if @project.save
      # raise
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
      respond_to do |format|
        format.js
        format.html{
          flash[:success] = "Project updated"
          redirect_to @project
        }
      end
    else
      flash[:warning] = "Unable to edit project"
      render :edit
    end
  end

  def destroy
    Project.find(params[:id]).destroy
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:description, :lot, :samples_attributes => [:description, :samples_id, :_destroy])
  end

  def project_started?
    if current_user && !(current_user.admin? || current_user.analyst?)
      if Project.find(params[:id]).received?
        flash[:danger] = "Project has been started. Please contact the lab at (555) 510-5555 to change testing"
        redirect_to projects_path
      end
    end
  end

end