class BatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_privledges

  def new
    @available_methods = Test.methods_not_batched
    @batch = Batch.new
  end
  
  def create
    @batch = Batch.new
    if @batch.save
      flash[:success] = "Batch created"
      redirect_to @batch
    else
      flash[:danger] = "Unable to create Batch"
      render :new
    end
  end

  private
  
  def check_user_privledges
    unless current_user && (current_user.admin? || current_user.analyst?)
      flash[:danger] = "Unauthorized"
      redirect_to root_path
    end
  end
end