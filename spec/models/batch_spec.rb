require 'rails_helper'

RSpec.describe Batch, type: :model do
  describe 'callback hooks' do
    it 'sets batched to true after update' do
      @test = FactoryGirl.create(:test)
      @batch = FactoryGirl.create(:batch, test_method: @test.test_method)
      expect(@test.batched).to eql(false)
      @batch.update_attributes(tests: [@test])
      @test.reload
      expect(@test.batched).to eql(true)
    end
    it 'deletes the batch if no tests after update' do
      @test = FactoryGirl.create(:test)
      @batch = FactoryGirl.create(:batch, test_method: @test.test_method)
      expect(Batch.count).to eql(1)
      @batch.update_attributes(tests: [])
      expect(Batch.count).to eql(0)
    end
  end

  describe '#available_methods' do
    it 'selects test method ID when batched is false' do
      @test = FactoryGirl.create(:test, batched: false, batch_id: nil)
      expect(Batch.available_methods).to match([[@test.test_method.name, @test.test_method_id]])
    end
    it 'returns correct array when batch_id is 0' do
      @test = FactoryGirl.create(:test, batched: nil, batch_id: 0)
      expect(Batch.available_methods).to match([[@test.test_method.name, @test.test_method_id]])
    end
  end

  describe '#completed?' do
    it 'returns false if test result is nil' do
      @test = FactoryGirl.create(:test)
      @batch = FactoryGirl.create(:batch, test_method: @test.test_method, tests: [@test])
      expect(@batch.completed?).to eql(false)  
    end
    it 'returns false if one test result is nil' do
      @test = FactoryGirl.create(:test)
      @second_test = FactoryGirl.create(:test, test_method: @test.test_method, result: 10)
      @batch = FactoryGirl.create(:batch, test_method: @test.test_method, tests: [@test, @second_test])
      expect(@batch.completed?).to eql(false) 
    end
    it 'returns true if all tests have results' do
      @test = FactoryGirl.create(:test, result: 20)
      @second_test = FactoryGirl.create(:test, test_method: @test.test_method, result: 10)
      @batch = FactoryGirl.create(:batch, test_method: @test.test_method, tests: [@test, @second_test])
      expect(@batch.completed?).to eql(true) 
    end
  end
end
