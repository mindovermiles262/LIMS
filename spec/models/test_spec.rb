require 'rails_helper'

RSpec.describe Test, type: :model do
  before(:each) do
    @test = FactoryGirl.build(:test)
  end

  context 'validations' do
    it 'has a valid factory' do
      expect(@test).to be_valid
    end

    it 'is invalid without TestMethod' do
      @test.test_method = nil
      expect(@test).to_not be_valid
    end

    it 'is invalid without Sample' do
      @test.sample = nil
      expect(@test).to_not be_valid
    end
  end

  describe '#available_for_batching' do
    it 'finds tests with method_id if present' do
      @test = FactoryGirl.create(:test)
      @second_test = FactoryGirl.create(:test)
      expect(Test.available_for_batching(@test.test_method_id)).to match([@test])
    end
    it 'finds tests without a batch if no method id given' do
      @test = FactoryGirl.create(:test)
      @second_test = FactoryGirl.create(:test, batch_id: 1)
      expect(Test.available_for_batching).to match([@test])
    end
  end

  describe '#unbatched' do
    it 'sorts on Test ID' do
      @test = FactoryGirl.create(:test, id: 2, test_method_id: 1)
      @second_test = FactoryGirl.create(:test, id: 1, test_method_id: 1)
      @third_test = FactoryGirl.create(:test, id: 3, test_method_id: 1)
      expect(Test.unbatched(1)).to match([@second_test, @test, @third_test])
    end
  end

  describe '#remove' do
    it 'sets batch_id to nil on removal' do
      @test = FactoryGirl.create(:test, batch_id: 1)
      @test.remove
      expect(@test.batch_id).to eql(nil)
    end
  end

end
