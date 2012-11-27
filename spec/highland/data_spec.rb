require File.join(File.dirname(__FILE__), "/../spec_helper" )

describe Highland do

  class DummyClass
  end
  
  before(:each) do
    @dummy_class = DummyClass.new
    @dummy_class.extend(Highland::DatabaseMethods)
    @dummy_vhash = %q{ {  
                         1 => {
                           "name" => {
                             "type" => "string",
                             "value" => "John"
                           },
                           "age" => {
                             "type" => "integer",
                             "value" => 20
                           }
                         },

                         5 => {
                           "name" => {
                             "type" => "string",
                             "value" => "Merry"
                           },
                           "age" => {
                             "type" => "integer",
                             "value" => 18
                           }
                         },           

                         3 => {
                           "name" => {
                             "type" => "string",
                             "value" => "Rebecca"
                           },
                           "age" => {
                             "type" => "integer",
                             "value" => 21
                           }
                         },

                         2 => {
                           "name" => {
                             "type" => "string",
                             "value" => "Bill"
                           },
                           "age" => {
                             "type" => "integer",
                             "value" => 21
                           }
                         }
                      }}
  end

  it "should load virtual hash" do
    @dummy_class.load_vhash.should == "loaded virtual hash"
  end

  it "should load virtual helpers" do
    @dummy_class.load_vhelpers.should == "loaded virtual helpers"
  end

  it "should insert new element into virtual hash" do
    @dummy_class.insert_vhash.should == "inserted element into virtual hash"
  end

  it "should insert new element into virtual helpers" do
    @dummy_class.insert_vhelpers.should == "inserted element into virtual helpers"
  end

  it "should find element by key" do
    @dummy_class.find.should == "found element by key"
  end

  it "should insert new element into static hash" do
    @dummy_class.insert_shash.should == "inserted element into static hash"
  end

  it "should clear collection" do
    @dummy_class.clear.should == "cleared all data from collection"
  end

end