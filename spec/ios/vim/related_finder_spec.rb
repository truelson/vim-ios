require 'ios/vim'

describe IOS::Vim::RelatedFinder do

  before do
    File.stub(:exists?).and_return false
  end

  describe '#spec' do

    context 'when given BarSpec.m' do

      it 'returns BarSpec.m' do
        IOS::Vim::RelatedFinder.new('BarSpec.m').spec.should == 'BarSpec.m'
      end

    end

    context 'when given Foo.m' do

      it 'returns FooSpec.m' do
        IOS::Vim::RelatedFinder.new('Foo.m').spec.should == 'FooSpec.m'
      end

      context 'when FooTest.m exists' do

        before do
          File.stub(:exists?).with('FooTest.m').and_return true
        end

        it 'should return FooTest.m' do
          IOS::Vim::RelatedFinder.new('Foo.m').spec.should == 'FooTest.m'
        end

      end

    end

  end

end