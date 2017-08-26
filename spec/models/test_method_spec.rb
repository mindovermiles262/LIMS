require 'rails_helper'
RSpec.describe TestMethod, type: :model do
  before do
    @method = TestMethod.create(
      name: "RSpec Name",
      target_organism: "APC",
      reference_method: "RSpec",
      turn_around_time: 2,
      detection_limit:  10,
      unit: "CFU/g"                          
    )
  end

  it "is valid with all fields" do
    expect(@method).to be_valid
  end

  it "is invalid without a name" do
    @method.name = " "
    expect(@method).to be_invalid
  end

  it "is invalid without a target organism" do
    @method.target_organism = nil
    expect(@method).to be_invalid
  end

  it "is invalid without a reference method" do
    @method.reference_method = ""
    expect(@method).to be_invalid
  end

  it "is invalid without a turn around time" do
    @method.turn_around_time = nil
    expect(@method).to be_invalid
  end

  it "is invalid with non-integer turn around times" do
    @method.turn_around_time = [10]
    expect(@method).to be_invalid
    @method.turn_around_time = { "limit" => 10 }
    expect(@method).to be_invalid
    @method.turn_around_time = "String"
    expect(@method).to be_invalid
    @method.turn_around_time = 1.2
    expect(@method).to be_invalid
  end

  it "is invalid with negative turn around times" do
    @method.turn_around_time = 0
    expect(@method).to be_invalid
  end

  it "is invalid with too large of turn around times" do
    @method.turn_around_time = 11
    expect(@method).to be_invalid
  end

  it "is invalid without a detection limit" do
    @method.detection_limit = " "
    expect(@method).to be_invalid
  end

  it "is invalid with negative detection limit" do
    @method.detection_limit = 0
    expect(@method).to be_invalid
  end

  it "is invalid with a non-integer detection limit" do
    @method.detection_limit = [10]
    expect(@method).to be_invalid
    @method.detection_limit = { "limit" => 10 }
    expect(@method).to be_invalid
    @method.detection_limit = "String"
    expect(@method).to be_invalid
    @method.detection_limit = 1.2
    expect(@method).to be_invalid
  end

  it "is invalid without a unit" do
    @method.unit = nil
    expect(@method).to be_invalid
  end
end