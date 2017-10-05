class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user?
  before_action :admin_only, except: [:show]

  def show
    @user = User.find(params[:id])
    @projects = @user.projects
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User Updated"
      redirect_to edit_user_path
    else
      flash[:warning] = "Unable to update User"
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Deleted"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :company, :admin, :analyst)
  end

  def correct_user?
    if !(current_user && current_user.admin?)
      unless current_user == User.find(params[:id])
        flash[:danger] = "Unauthroized"
        redirect_to root_path
      end
    end
  end

end
