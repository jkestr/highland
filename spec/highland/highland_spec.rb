require File.join(File.dirname(__FILE__), "/../spec_helper" )

describe Highland do

  class DummyClass
  end
  
  before(:each) do
    @dummy_class = DummyClass.new
    @dummy_class.extend(Highland::CollectionMethods)
  end
  
  it "should create" do
    @dummy_class.create(:age => 26, :name => 'Chris').should == "called create"
  end

  it "should provide querying" do
    @dummy_class.first(:name => 'John').should == "called first"
    @dummy_class.where(:name => 'John').should == "called where"
    @dummy_class.all(:name => 'John').should == "called all"
  end

  it "should be able to find" do
    @dummy_class.find('chris').should == "called find"
    @dummy_class.find('chris', 'steve').should == "called find"
    @dummy_class.find(['chris', 'steve']).should == "called find"
  end

  it "should be able to sort" do
    @dummy_class.sort(:age).should == "called sort"
    # @dummy_class.sort(:age.asc).should == "called sort"
    # @dummy_class.sort(:age.desc).should == "called sort"
  end

  it "should be able to count" do
    @dummy_class.count.should == "called count"
    @dummy_class.size.should == "called size"
  end

  it "should distinct" do
    @dummy_class.distinct(:age).should == "called distinct"
  end

  it "should select certain fields" do
    @dummy_class.fields(:age).should == "called fields"
    @dummy_class.only(:age).should == "called only"
    @dummy_class.ignore(:name).should == "called ignore"
  end

  # it "should have symbol operators" do
  #   @dummy_class.where(:age.gt => 28).should == "called where with gt"
  #   @dummy_class.where(:age.lt => 28).should == "called where with lt"
  #   @dummy_class.where(:age.in => [26, 28]).should == "called where with in"
  #   @dummy_class.where(:age.nin => [26, 28]).should == "called where with nin"
  # end

  it "should be able to remove" do
    @dummy_class.remove(:name => 'John').should == "called remove"
  end
  
end
