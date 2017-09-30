require 'rails_helper'

RSpec.describe Pipet, type: :model do
  before :each do
    @pipet = FactoryGirl.build(:pipet)
  end

  it 'has a valid factory' do
    expect(@pipet).to be_valid
  end

  describe 'validatons' do
    it 'is invalid without calibration date' do
      @pipet.calibration_date = nil
      expect(@pipet).to be_invalid
    end
    it 'is invalid without calibration due date' do
      @pipet.calibration_due = nil
      expect(@pipet).to be_invalid
    end
    it 'is invalid without a min volume' do
      @pipet.min_volume = ""
      expect(@pipet).to be_invalid
    end
    it 'is invalid if min volume is not an integer' do
      @pipet.min_volume = 1.5
      expect(@pipet).to be_invalid
      @pipet.min_volume = "foo"
      expect(@pipet).to be_invalid
    end
    it 'is invalid without a max volume' do
      @pipet.max_volume = ""
      expect(@pipet).to be_invalid
    end
    it 'is invalid if max volume is not an integer' do
      @pipet.max_volume = 1.5
      expect(@pipet).to be_invalid
      @pipet.max_volume = "foo"
      expect(@pipet).to be_invalid
    end
    it 'is invalid without a adjustable flag' do
      @pipet.adjustable = ""
      expect(@pipet).to be_invalid
    end
  end
end
