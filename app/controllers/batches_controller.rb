class BatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_or_analyst
  before_action :check_for_cancel, :only => [:create, :update]
  
  def index
    @batches = Batch.all
  end
  
  def show
    @batch = Batch.find(params[:id])
    @pipets = Pipet.all.collect{ |p| [p.id, p.id] }
  end

  def new
    @available_methods = Batch.available_methods
    @batch = Batch.new
    @batch.tests.build
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

  def add
    @test = Test.find(params[:id])
    @batch = Batch.find(params[:batch_id])
    if @test.test_method_id == @batch.test_method_id
      @batch.tests << @test
    else
      flash[:danger] = "Test method and Batch method do not match"
      redirect_to edit_batch_path(@batch)
    end
  end

  def edit
    @batch = Batch.find(params[:id])
    @batch.batch_pipets.build(batch_id: @batch.id)
    @pipets = Pipet.available_for_batches
    if @batch.tests.count > 0
      # Batch has been made, populate Unbatched table
      @batch.tests
      @tests_available_to_add = Test.unbatched(@batch.test_method_id)
    else
      # New Batch, fill with all unbatched tests with same test_method_id
      @batch.tests << Test.unbatched(@batch.test_method_id)
    end
  end

  def results
    @batch = Batch.find(params[:batch_id])
  end

  def update
    @batch = Batch.find(params[:id])
    if @batch.update_attributes(new_batch_params)
      flash[:success] = "Batch Updated"
      redirect_to @batch
    end
  end

  def destroy
    Batch.find(params[:id]).destroy
    flash[:success] = "Batch Deleted"
    redirect_to batches_path
  end

  private

  def new_batch_params
    params.require(:batch).permit(
      :test_method_id, 
      :tests_attributes => [:id, :batch_id, :result],
      :batch_pipets_attributes => [:pipet_id, :batch_id]
    )
  end

  def check_for_cancel
    if ["Back", "Cancel", "back", "cancel"].include? params[:commit]
      redirect_to batches_path
    end
  end
end