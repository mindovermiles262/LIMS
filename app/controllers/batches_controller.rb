class BatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_privledges

  after_create :update_batched_attribute
  after_update :update_batched_attribute

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

  def put_test
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  end

  def batch_params
    params.require(:batch).permit(:tests, :test_method)
  end

  def update_batched_attribute
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    tests.update_all(batched: true)
  end
  
  def check_user_privledges
    unless current_user && (current_user.admin? || current_user.analyst?)
      flash[:danger] = "Unauthorized"
      redirect_to root_path
    end
  end
end