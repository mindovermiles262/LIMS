class BatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_privledges

  def index
    @batches = Batch.all
  end

  def new
    @available_methods = Test.methods_not_batched
    @batch = Batch.new
  end
  
  def create
    @batch = Batch.new(batch_params)
    if @batch.save
      flash[:success] = "Batch created"
      redirect_to @batch
    else
      flash[:danger] = "Unable to create Batch"
      render :new
    end
  end

  def show
    @batch = Batch.find(params[:id])
  end

  private

  def batch_params
    params.require(:batch).permit(:tests, :test_method)
  end
  
  def check_user_privledges
    unless current_user && (current_user.admin? || current_user.analyst?)
      flash[:danger] = "Unauthorized"
      redirect_to root_path
    end
  end
end