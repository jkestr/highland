require File.join(File.dirname(__FILE__), "/../spec_helper" )
DB = File.join(File.dirname(__FILE__), "/dummy_dir" )

describe Highland do
  before(:each) do
    @collection = File.join(File.dirname(__FILE__), "/dummy_dir/db/dummyusers.hl" )
  end
  
  it "should create new classes" do
    DummyUsers.class.should == Class
  end
  
  it "should create one element" do
    DummyUsers.init_collection(@collection)
    a = DummyUsers.create(:age => 26, :name => 'Chris').values
    b = DummyUsers.find_db(:age => 26, :name => 'Chris').values
    a.should == b
    DummyUsers.clear_virtual
    DummyUsers.init_collection(@collection)
    c = DummyUsers.find_db(:age => 26, :name => 'Chris').values
    a.should == c
    DummyUsers.clear_static
  end

  it "should create many elements" do
    DummyUsers.init_collection(@collection)
    DummyUsers.clear_static
    i = 20
    15.times do
      a = DummyUsers.create(:age => i, :name => "Fake#{i}").values
      DummyUsers.clear_virtual
      DummyUsers.init_collection(@collection)
      b = DummyUsers.find_db(:age => i, :name => "Fake#{i}").values
      a.should == b
      i += 1
    end
    DummyUsers.clear_static
    DummyUsers.clear_virtual
  end

  it "should provide querying with where" do
    DummyUsers.init_collection(@collection)
    DummyUsers.clear_static
    i = 20
    5.times do
      DummyUsers.create(:age => i, :name => "Fake")
      i += 1
    end
    DummyUsers.where(:name => 'Fake').class.should == Array
    DummyUsers.where(:name => 'Fake').length.should == 5
    DummyUsers.where(:name => 'Fake', :age => 20).class.should == Array
    DummyUsers.where(:name => 'Fake', :age => 20).length.should == 1
    DummyUsers.where(:name => 'Fake').first.class.should == HighlandObject
    DummyUsers.where(:name => 'Fake').first.name.should == 'Fake'
    DummyUsers.where(:name => 'Fake', :age => 20).first.age.should == 20
    DummyUsers.clear_static
    DummyUsers.clear_virtual
  end

  it "should provide querying with first" do
    DummyUsers.init_collection(@collection)
    DummyUsers.clear_static
    DummyUsers.create(:age => 20, :name => "Fake")
    DummyUsers.first(:name => 'Fake').class.should == HighlandObject
    DummyUsers.first(:name => 'Fake', :age => 20).class.should == HighlandObject
    DummyUsers.first(:name => 'Fake').name.should == 'Fake'
    DummyUsers.first(:name => 'Fake', :age => 20).age.should == 20
    DummyUsers.clear_static
    DummyUsers.clear_virtual
  end

  it "should provide querying with all" do
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
