class TestsController < ApplicationController
  def destroy
    test = Test.find(params[:id]).destroy
    redirect_to project_path(test.project.id)
  end
end