require File.join(File.dirname(__FILE__), "/../spec_helper" )

describe Highland do

  class PseudoCollection
  end
  
  before(:each) do
    @pseudo_collection = PseudoCollection.new
    @pseudo_collection.extend(Highland::CollectionMethods)
  end
  
  it "should create" do
    @pseudo_collection.create(:age => 26, :name => 'Chris').should == "called create"
  end

  it "should provide querying" do
    @pseudo_collection.first(:name => 'John').should == "called first"
    @pseudo_collection.where(:name => 'John').should == "called where"
    @pseudo_collection.all(:name => 'John').should == "called all"
  end

  it "should be able to find" do
    @pseudo_collection.find('chris').should == "called find"
    @pseudo_collection.find('chris', 'steve').should == "called find"
    @pseudo_collection.find(['chris', 'steve']).should == "called find"
  end

  it "should be able to sort" do
    @pseudo_collection.sort(:age).should == "called sort"
    # @pseudo_collection.sort(:age.asc).should == "called sort"
    # @pseudo_collection.sort(:age.desc).should == "called sort"
  end

  it "should be able to count" do
    @pseudo_collection.count.should == "called count"
    @pseudo_collection.size.should == "called size"
  end

  it "should distinct" do
    @pseudo_collection.distinct(:age).should == "called distinct"
  end

  it "should select certain fields" do
    @pseudo_collection.fields(:age).should == "called fields"
    @pseudo_collection.only(:age).should == "called only"
    @pseudo_collection.ignore(:name).should == "called ignore"
  end

  # it "should have symbol operators" do
  #   @pseudo_collection.where(:age.gt => 28).should == "called where with gt"
  #   @pseudo_collection.where(:age.lt => 28).should == "called where with lt"
  #   @pseudo_collection.where(:age.in => [26, 28]).should == "called where with in"
  #   @pseudo_collection.where(:age.nin => [26, 28]).should == "called where with nin"
  # end

  it "should be able to remove" do
    @pseudo_collection.remove(:name => 'John').should == "called remove"
  end
  
end
