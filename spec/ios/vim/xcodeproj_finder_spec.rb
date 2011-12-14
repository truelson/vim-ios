require 'ios/vim'

RSpec::Matchers.define :find_project_with_path do |expected|
  match do |actual|
    actual.find.path.should == expected
  end
end

describe IOS::Vim::XcodeProjectFinder do

  def empty_lister
    double :current_directory => '/Foo/bar', :list => []
  end

  context "when it can't find a project folder" do
    subject {IOS::Vim::XcodeProjectFinder.new empty_lister}

    it "returns nil" do
      subject.find.should be_nil
    end
  end

  context "when there's a .xcodeproj in the current directory" do

    let!(:directory_lister) do
      lister = double(:current_directory => '/Foo/bar/baz')
      lister.stub(:list).with('/Foo/bar/baz').and_return(['Foo.xcodeproj'])
      lister
    end
    subject {IOS::Vim::XcodeProjectFinder.new directory_lister}

    it "returns an XcodeProject with the correct path" do
      subject.should find_project_with_path("/Foo/bar/baz/Foo.xcodeproj")
    end

  end

  context "when there's a .xcodeproj in a parent directory" do
    
    let!(:directory_lister) do
      lister = double(:current_directory => '/Foo/bar/baz')
      lister.stub(:list).with('/Foo/bar/baz').and_return([])
      lister.stub(:list).with('/Foo/bar').and_return(['Foo.xcodeproj'])
      lister
    end
    subject {IOS::Vim::XcodeProjectFinder.new directory_lister}

    it "returns an XcodeProject with the correct path" do
      subject.should find_project_with_path("/Foo/bar/Foo.xcodeproj")
    end

  end
  
end