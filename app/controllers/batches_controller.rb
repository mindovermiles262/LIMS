class BatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_privledges

  def index
    @batches = Batch.all
  end

  def new
    @available_methods = Batch.available_methods
    @batch = Batch.new
  end
  
  def create
    @batch = Batch.new(new_batch_params)
    if @batch.save
      flash[:info] = "Select Tests"
      redirect_to edit_batch_path(@batch)
    else
      flash[:danger] = "Unable to create Batch"
      render :new
    end
  end

  def edit
    @batch = Batch.find(params[:id])
    @batch.tests << Test.where(test_method_id: params[:test_method])
  end

  def update

  end

  def show
    @batch = Batch.find(params[:id])
  end

  private

  def new_batch_params
    params.require(:batch).permit(:test_method)
  end
  
  def check_user_privledges
    unless current_user && (current_user.admin? || current_user.analyst?)
      flash[:danger] = "Unauthorized"
      redirect_to root_path
    end
  end
end