require 'rails_helper'

RSpec.describe TestMethod, type: :model do
  it "is valid with all fields"
  it "is invalid without a name"
  it "is invalid without a target organism"
  it "is invalid without a reference method"
  it "is invalid without a turn around time"
  it "is invalid without a detection limit"
  it "is invalid without a unit"
end