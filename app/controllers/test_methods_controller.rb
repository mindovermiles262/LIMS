class TestMethodsController < ApplicationController
  before_action :check_for_cancel, only: [:create, :update]
  before_action :user_admin?

  def new
    @test_method = TestMethod.new
    @target_organisms = [["APC", "APC"], ["Y&M", "Y&M"]]
    @reference_methods = [["AOAC", "AOAC"], ["FDA-BAM", "FDA-BAM"], ["USP", "USP"]]
    @units = [["CFU/g", "CFU/g"], ["CFU/mL", "CFU/mL"]]
  end

  def create
    @test_method = TestMethod.new(test_method_params)
    if @test_method.save
      flash[:info] = "Method Created"
      redirect_to test_methods_path
    else
      render 'new'
    end
  end

  def index
    @test_methods = TestMethod.all
  end

  def edit
    @test_method = TestMethod.find(params[:id])
    @target_organisms = [["APC", "APC"], ["Y&M", "Y&M"]]
    @reference_methods = [["AOAC", "AOAC"], ["FDA-BAM", "FDA-BAM"], ["USP", "USP"]]
    @units = [["CFU/g", "CFU/g"], ["CFU/mL", "CFU/mL"]]
  end

  def update
    @test_method = TestMethod.find(params[:id])
    if @test_method.update_attributes(test_method_params)
      flash[:success] = "Test Method Updated!"
      redirect_to test_methods_path
    else
      render 'edit'
    end
  end

  def destroy
    TestMethod.find(params[:id]).destroy
    flash[:success] = "Method Deleted"
    redirect_to test_methods_path
  end

  private

  def test_method_params
    params.require(:test_method).permit(:name, :target_organism, :reference_method,
                                        :turn_around_time, :detection_limit, :unit)
  end

  def check_for_cancel
    if params[:commit] == "Cancel"
      redirect_to test_methods_path
    end
  end

  def user_admin?
    unless current_user && current_user.admin?
      flash[:danger] = "Unauthorized Access"
      redirect_to root_path
    end
  end
end
