class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user?, except: [:index]
  before_action :admin_user?, only: [:index]

  def show
    @user = User.find(params[:id])
    @projects = @user.projects
    @tests = @user.all_tests
  end

  def index
    @users = User.all
  end

  private

  def correct_user?
    unless current_user == User.find(params[:id])
      flash[:danger] = "Unauthroized"
      redirect_to root_path
    end
  end

  def admin_user?
    unless current_user.admin?
      flash[:danger] = "Unauthroized"
      redirect_to root_path
    end
  end
end
