require 'rails_helper'

RSpec.describe Analyst, type: :model do
  before(:each) do
    @analyst = FactoryGirl.build(:analyst)
  end

  it 'has a valid factory' do
    expect(@analyst).to be_valid
  end

  context 'validation for presence' do
    it 'is invalid without an email' do
      @analyst.email = nil
      expect(@analyst).to_not be_valid
    end
    it 'is invalid without a password' do
      @analyst.password = nil
      @analyst.password_confirmation = nil
      expect(@analyst).to_not be_valid
    end
  end
end
