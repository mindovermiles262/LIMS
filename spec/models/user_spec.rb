require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryGirl.build(:user)
  end

  context "factory" do
    it 'is valid' do
      expect(@user).to be_valid
    end
  end

  context 'validation for presence' do
    it 'is invalid without a first name' do
      @user.first_name = nil
      expect(@user).to_not be_valid
    end
    it 'is invalid without a last name' do
      @user.last_name = nil
      expect(@user).to_not be_valid
    end
    it 'is invalid without an email' do
      @user.email = nil
      expect(@user).to_not be_valid
    end
    it 'is invalid without a password' do
      @user.password = nil
      @user.password_confirmation = nil
      expect(@user).to_not be_valid
    end
  end

  context 'method' do
    it 'returns valid initials' do
      @user.first_name = "Example"
      @user.last_name = "User"
      expect(@user.initials).to eql("EU")
    end
    it 'returns valid #full_name' do
      @user.first_name = "hank"
      @user.last_name = "aAron"
      expect(@user.full_name).to eql("Hank Aaron")
    end
  end
end
