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

    # def create_missing(collections, static)
    #   collections.each do |c|
    #     File.open(DB_PATH + "db/#{c.downcase}.hl", "w") if static.include?(c.downcase) == false
    #   end
    # end

    # def delete_unused(collections, static)
    #   static.each do |c|
    #     File.delete(DB_PATH + "db/#{c.downcase}.hl") if collections.map(&:downcase).include?(c.downcase) == false
    #   end      
    # end

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
