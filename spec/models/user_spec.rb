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

  context 'administrative rights' do
    it 'is initially set to customer privileges' do
      expect(@user.admin).to eql(false)
      expect(@user.analyst).to eql(false)
    end
  end

  context 'method' do
    it 'returns valid initials' do
      @user.first_name = "Example"
      @user.last_name = "User"
      expect(@user.initials).to eql("EU")
    end
  end
end
