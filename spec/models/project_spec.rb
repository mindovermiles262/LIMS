require 'rails_helper'

RSpec.describe Project, type: :model do
  before(:each) do
    @project = FactoryGirl.create(:project)
    @project_with_tests = FactoryGirl.create(:project_with_tests)
  end

  it 'has a valid factory' do
    expect(@project).to be_valid
    expect(@project_with_tests).to be_valid
  end

  it 'is invalid without a user' do
    @project.user = nil
    expect(@project).to_not be_valid
  end

  it 'updates received with test received' do
    expect(@project_with_tests.received?).to eql(false)
    @project_with_tests.tests.first.received = true
    expect(@project_with_tests.received?).to eql(true)
  end
end
