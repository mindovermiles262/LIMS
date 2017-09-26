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

  describe '#batched' do
    it 'returns false if project is not batched' do
      @project = FactoryGirl.create(:project)
      expect(@project.batched?).to eql(false)
    end
    it 'returns true if project is batched' do
      @test = FactoryGirl.create(:test, batched: true)
      @sample = FactoryGirl.create(:sample, tests: [@test])
      @project = FactoryGirl.create(:project, samples: [@sample])
      expect(@project.batched?).to eql(true)
    end
  end

  describe '#status' do
    it 'returns STARTED if received' do
      @project = FactoryGirl.build(:project, received: true)
      expect(@project.status).to eql("Started")
    end
    it 'returns STARTED if batched' do
      @test = FactoryGirl.create(:test, batched: true)
      @sample = FactoryGirl.create(:sample, tests: [@test])
      @project = FactoryGirl.create(:project, samples: [@sample])
      expect(@project.status).to eql("Started")
    end
    it 'returns COMPLETED if completed' do
      @project = FactoryGirl.build(:project, completed: true)
      expect(@project.status).to eql("Completed")
    end
    it 'returns REPORTED if reported' do
      @project = FactoryGirl.build(:project, reported: true)
      expect(@project.status).to eql("Reported")
    end
    it 'returns AWAITING RECEIPT otherwise' do
      @project = FactoryGirl.build(:project)
      expect(@project.status).to eql("Awaiting Receipt")
    end
  end
end
