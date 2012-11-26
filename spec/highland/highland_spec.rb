require File.join(File.dirname(__FILE__), "/../spec_helper" )

describe Highland do

  class DummyClass
  end
  
  before(:each) do
    @dummy_class = DummyClass.new
    @dummy_class.extend(Highland)
  end
  
  it "should create" do
    @dummy_class.create(:age => 26, :name => 'Chris').should == "called creation method"
  end

  it "should provide querying" do
    @dummy_class.where(:name => 'John').first.should == "called where + first chain"
    @dummy_class.first(:name => 'John').should == "called first"
    @dummy_class.where(:name => 'John').all.should == "called where + all chain"
    @dummy_class.all(:name => 'John').should == "called all method"
  end

  it "should be able to find" do
    @dummy_class.find('chris').should == "called find by one id"
    @dummy_class.find('chris', 'steve').should == "called find by several ids"
    @dummy_class.find(['chris', 'steve']).should == "called find by array of ids"
  end

  it "should be able to sort" do
    @dummy_class.sort(:age).all.should == "called sort + all chain"
    @dummy_class.sort(:age.asc).all.should == "called sort + all chain with asc attribute"
    @dummy_class.sort(:age.desc).all.should == "called sort + all chain with desc attribute"
    @dummy_class.sort(:age).last.should == "called sort + last chain"
  end

  it "should be able to count" do
    @dummy_class.count.should == "called count"
    @dummy_class.size.should == "called size"
    @dummy_class.count(:name => 'John').should == "called count"
    @dummy_class.where(:name => 'John').count.should == "called chain where + count"
    @dummy_class.where(:name => 'John').size.should == "called chain where + size"
  end

  it "should distinct" do
    @dummy_class.distinct(:age).should == "called distinct"
  end

  it "should select certain fields" do
    @dummy_class.fields(:age).find('chris').should == "called fields with find"
    @dummy_class.only(:age).find('chris').should == "called only with find"
    @dummy_class.ignore(:name).find('chris').should == "called ignore with find"
  end

  it "should have symbol operators" do
    @dummy_class.where(:age.gt => 28).count.should == "called where with gt and count"
    @dummy_class.where(:age.lt => 28).count.should == "called where with lt and count"
    @dummy_class.where(:age.in => [26, 28]).count.should == "called where with in and count"
    @dummy_class.where(:age.nin => [26, 28]).count.should == "called where with nin and count"
  end

  it "should be able to remove" do
    @dummy_class.remove(:name => 'John').should == "called removed method"
    @dummy_class.where(:name => 'Chris').remove.should == "called where + remove chain"
    @dummy_class.remove.should == "removed everything"
  end
end
