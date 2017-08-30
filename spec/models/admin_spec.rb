require 'rails_helper'

RSpec.describe Admin, type: :model do
  before(:each) do
    @admin = FactoryGirl.build(:analyst)
  end

  it 'has a valid factory' do
    expect(@admin).to be_valid
  end

  context 'validation for presence' do
    it 'is invalid without an email' do
      @admin.email = nil
      expect(@admin).to_not be_valid
    end
    it 'is invalid without a password' do
      @admin.password = nil
      @admin.password_confirmation = nil
      expect(@admin).to_not be_valid
    end
  end
end
