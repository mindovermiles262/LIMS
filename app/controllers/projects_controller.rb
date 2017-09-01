class ProjectsController < ApplicationController
  before_action :authenticate_user!

  # TODO: Limit #index by User
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
    @methods = TestMethod.all.map { |m| [m.name, m] }
    3.times { @project.tests.build }
  end

  def create
    @project = Project.new(project_params)
    if @project.save!
      # raise
      flash[:success] = "Project Created"
      redirect_to projects_path
    else
      flash[:danger] = "Unable to create Project"
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  private

  def project_params
    params.require(:project).permit(:user_id, :tests_attributes => [:test_method_id])
  end

end

=begin
Parameters: {
  "utf8"=>"✓", "authenticity_token"=>"", "project"=>{
    "test_method"=>{
      "test_method"=>"#<TestMethod:0x007f841f4588c8>"
    }, 
    "user_id"=>"3"
  }, 
  "commit"=>"Submit"
}
=end