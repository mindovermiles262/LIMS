require 'rails_helper'

RSpec.describe Test, type: :model do
  before(:each) do
    @test = FactoryGirl.build(:test)
  end

  it 'has a valid factory' do
    expect(@test).to be_valid
  end

  it 'is invalid without TestMethod' do
    @test.test_method = nil
    expect(@test).to_not be_valid
  end

  it 'is invalid without Project' do
    @test.project = nil
    expect(@test).to_not be_valid
  end

end
