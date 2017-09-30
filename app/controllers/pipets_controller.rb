class PipetsController < ApplicationController
  before_action :admin_only
  
  def index
    @pipets = Pipet.all
  end
  
  def show
    @pipet = Pipet.find(params[:id])
  end

  def new
    @pipet = Pipet.new
  end

  def create
    @pipet = Pipet.create(pipet_params)
  end

  def edit
    @pipet = Pipet.find(params[:id])
  end

  def update
    @pipet = Pipet.update_attributes(pipet_params)
  end

  def destroy
    Pipet.find(params[:id]).destroy
    flash[:success] = "Pipet Destroyed"
    redirect_to pipets_path
  end
  
  private

  def pipet_params
    params.require(:pipet).permit(:calibration_date, :calibration_due,
                                  :min_volume, :max_volume, :adjustable)
  end

  def admin_only
    unless current_user && current_user.admin?
      flash[:danger] = "Unauthorized Access"
      redirect_to root_path
    end
  end
end