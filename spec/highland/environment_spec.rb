require File.join(File.dirname(__FILE__), "/highland_config")
require File.join(File.dirname(__FILE__), "/../spec_helper" )

describe Highland do

  it "should have defined inputs" do
    defined?(DB_PATH).should == "constant"
  end

  it "should read manifesto" do
    collections = ["Dummy", "DummyUsers", "Empty"].sort
    Highland::HighlandEnvironment.get_collections.sort.should == collections
  end

  it "should create classes" do
    Dummy.new.class.should == Dummy
    DummyUsers.new.class.should == DummyUsers
    Empty.new.class.should == Empty
  end

  it "should clean db folder from unused collections" do
    static = ["Qwerty", "Asdfg", "Zxcv"]
    collections = ["Dummy", "DummyUsers", "Empty"]
    static.each{|c| File.open(DB_PATH + "db/#{c.downcase}.hl", "w")}
    Highland::HighlandEnvironment.delete_unused(collections,static)
    inside = Dir[DB_PATH + "db/*.hl"].map do |file|
      File.basename(file,".hl").downcase
    end
    inside.sort.should == collections.map(&:downcase).sort
  end

  it "should add static files for new collections" do
    static = ["Dummy", "DummyUsers", "Empty"]
    collections = ["Qwerty", "Asdfg", "Zxcv"]
    Highland::HighlandEnvironment.create_missing(collections, static)
    inside = Dir[DB_PATH + "db/*.hl"].map do |file|
      File.basename(file,".hl").downcase
    end
    inside.sort.should == (collections+static).map(&:downcase).sort
    collections.each do |c|
      File.delete(DB_PATH + "db/#{c.downcase}.hl")
    end
  end

  it "should build virtual hash and helper for each collection" do
    Dummy.instance_variable_defined?(:@vhash).should == true
    DummyUsers.instance_variable_defined?(:@vhash).should == true
    Empty.instance_variable_defined?(:@vhash).should == true
    Dummy.instance_variable_defined?(:@vhelper).should == true
    DummyUsers.instance_variable_defined?(:@vhelper).should == true
    Empty.instance_variable_defined?(:@vhelper).should == true
  end

end
