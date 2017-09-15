class TestsController < ApplicationController
  def destroy
    test = Test.find(params[:id]).destroy
    redirect_to project_path(test.project.id)
  end

  def update
    @test = Test.find(params[:id])
    if @test.update_attributes(test_params)
      # raise
      flash[:success] = "Test updated"
      redirect_to batches_path
    else
      flash.now[:warning] = "Unable to edit project"
    end
  end

  private

  def test_params
    params.require(:test).permit(:id, :result)
  end
end