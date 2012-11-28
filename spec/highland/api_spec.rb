require File.join(File.dirname(__FILE__), "/../spec_helper" )
DB = File.join(File.dirname(__FILE__), "/dummy_dir" )

describe Highland do
  before(:each) do
    @collection = File.join(File.dirname(__FILE__), "/dummy_dir/db/dummyusers.hl" )
    DummyUsers.init_collection(@collection)
  end
  
  it "should create new classes" do
    DummyUsers.class.should == Class
  end
  
  it "should create" do
    DummyUsers.create(:age => 26, :name => 'Chris').should == "called create"
  end

  it "should provide querying" do
    DummyUsers.first(:name => 'John').should == "called first"
    DummyUsers.where(:name => 'John').should == "called where"
    DummyUsers.all(:name => 'John').should == "called all"
  end

  it "should be able to find" do
    DummyUsers.find('chris').should == "called find"
    DummyUsers.find('chris', 'steve').should == "called find"
    DummyUsers.find(['chris', 'steve']).should == "called find"
  end

  it "should be able to sort" do
    DummyUsers.sort(:age).should == "called sort"
    # DummyUsers.sort(:age.asc).should == "called sort"
    # DummyUsers.sort(:age.desc).should == "called sort"
  end

  it "should be able to count" do
    DummyUsers.count.should == "called count"
    DummyUsers.size.should == "called size"
  end

  it "should distinct" do
    DummyUsers.distinct(:age).should == "called distinct"
  end

  it "should select certain fields" do
    DummyUsers.fields(:age).should == "called fields"
    DummyUsers.only(:age).should == "called only"
    DummyUsers.ignore(:name).should == "called ignore"
  end

  # it "should have symbol operators" do
  #   DummyUsers.where(:age.gt => 28).should == "called where with gt"
  #   DummyUsers.where(:age.lt => 28).should == "called where with lt"
  #   DummyUsers.where(:age.in => [26, 28]).should == "called where with in"
  #   DummyUsers.where(:age.nin => [26, 28]).should == "called where with nin"
  # end

  it "should be able to remove" do
    DummyUsers.remove(:name => 'John').should == "called remove"
  end
  
end
