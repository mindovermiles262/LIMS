require 'rails_helper'

RSpec.describe Project, type: :model do
  before(:each) do
    @project = FactoryGirl.create(:project)
    @project_with_tests = FactoryGirl.create(:project_with_samples)
  end

  it 'has a valid factory' do
    expect(@project).to be_valid
    expect(@project_with_tests).to be_valid
  end

  it 'is invalid without a user' do
    @project.user = nil
    expect(@project).to_not be_valid
  end
end
