class PipetsController < ApplicationController
  before_action :authenticate_user!
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
    if @pipet.save
      flash[:success] = "Pipet Created"
      redirect_to pipets_path
    else
      flash[:warning] = "Unable to create new pipet"
      render :new
    end
  end

  def edit
    @pipet = Pipet.find(params[:id])
  end

  def update
    @pipet = Pipet.find(params[:id])
    if @pipet.update_attributes(pipet_params)
      flash[:success] = "Pipet Updated"
      redirect_to pipets_path
    end
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
end