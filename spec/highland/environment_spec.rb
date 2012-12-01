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

  # it "should load configuration" do
  #   Highland::HighlandEnvironment.load_config.should == true
  # end

  # it "should get list of collections" do
  #   Highland::HighlandEnvironment.get_collections.should == true    
  # end

  # it "should initialize collections" do
  #   Highland::HighlandEnvironment.init_collections.should == true
  # end

  # it "should create virtual hash and helper" do
  # 	Highland::HighlandEnvironment.return_vhashes.should == true
  #   Highland::HighlandEnvironment.return_vhelpers.should == true
  # end

  # it "should provide each collection with api" do
  #   Highland::HighlandEnvironment.return_api.should == true
  # end

end
