class TestMethodsController < ApplicationController
  def new
    @test_method = TestMethod.new
    @target_organisms = ["APC", "Y&M"]
    @reference_methods = ["AOAC", "FDA-BAM", "USP"]
    @units = ["CFU/g", "CFU/mL"]
  end

  def create
    @test_method = TestMethod.create(test_method_params)
  end

  def edit
  end

  def destroy
  end

  private

  def test_method_params
    params.require(:test_method).permit(:name, :target_organism, :reference_method,
                                        :turn_around_time, :detection_limit, :unit)
  end
end
