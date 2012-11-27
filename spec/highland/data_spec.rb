require File.join(File.dirname(__FILE__), "/../spec_helper" )

describe Highland do

  class DummyClass
  end
  
  before(:each) do
    @dummy_class = DummyClass.new
    @dummy_class.extend(Highland::DatabaseMethods)
    @dummy_shash = %q{ {  
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
    @dummy_vhash = eval(@dummy_shash)
    @dummy_vhelper = {  
                         "name" => {
                           "John" => [1],
                           "Merry" => [5],
                           "Rebecca" => [3],
                           "Bill" => [2]
                         },
                         "age" => {
                           20 => [1],
                           18 => [5],
                           21 => [3,2]
                         }
                      }

    @dummy_element = {  
                         100500 => {
                           "name" => {
                             "type" => "string",
                             "value" => "Dummy"
                           },
                           "age" => {
                             "type" => "integer",
                             "value" => 777
                           }
                         }
                      }
  end

  it "should load virtual hash" do
  	@dummy_class.instance_variables.include?("@vhash").should == false
    @dummy_class.load_vhash(@dummy_shash)
    @dummy_class.instance_variables.include?("@vhash").should == true
    @dummy_class.instance_variable_get("@vhash").class.should == Hash
    @dummy_class.instance_variable_get("@vhash").keys.sort.should == [1,2,3,5]
  end

  it "should load virtual helper" do
  	@dummy_class.load_vhash(@dummy_shash)
  	@dummy_class.instance_variables.include?("@vhelper").should == false
    @dummy_class.load_vhelper
    @dummy_class.instance_variables.include?("@vhelper").should == true
    @dummy_class.instance_variable_get("@vhelper").class.should == Hash
    @dummy_class.instance_variable_get("@vhelper").keys.sort.should == ["name", "age"].sort
    @dummy_class.instance_variable_get("@vhelper")["name"].keys.sort.should == ["John","Merry","Rebecca","Bill"].sort
    @dummy_class.instance_variable_get("@vhelper")["age"].keys.sort.should == [20,18,21].sort
    @dummy_class.instance_variable_get("@columns").sort.should == ["name","age"].sort
  end

  it "should get and update columns" do
    @dummy_class.load_vhash(@dummy_shash)
    @dummy_class.load_vhelper
    @dummy_class.update_columns
    @dummy_class.instance_variable_get("@columns").sort.should == ["name","age"].sort
  end

  it "should insert new element into virtual hash" do
  	@dummy_class.load_vhash(@dummy_shash)
  	@dummy_class.instance_variable_get("@vhash").keys.sort.should == [1,2,3,5]
    @dummy_class.insert_vhash(@dummy_element)
    @dummy_class.instance_variable_get("@vhash").keys.sort.should == [1,2,3,5,100500]
    @dummy_class.instance_variable_get("@vhash")[100500].class.should == Hash
    @dummy_class.instance_variable_get("@vhash")[100500].keys.sort.should == ["name","age"].sort
  end

  it "should insert new element into virtual helper" do
  	@dummy_class.load_vhash(@dummy_shash)
    @dummy_class.load_vhelper
    @dummy_class.instance_variable_get("@vhelper")["name"].keys.sort.should == ["John","Merry","Rebecca","Bill"].sort
    @dummy_class.instance_variable_get("@vhelper")["age"].keys.sort.should == [20,18,21].sort
    @dummy_class.insert_vhelper(@dummy_element)
    @dummy_class.instance_variable_get("@vhelper")["name"].keys.sort.should == ["John","Merry","Rebecca","Bill","Dummy"].sort
    @dummy_class.instance_variable_get("@vhelper")["age"].keys.sort.should == [20,18,21,777].sort
    @dummy_class.instance_variable_get("@columns").sort.should == ["name","age"].sort
  end

  it "should find element by key" do
  	@dummy_class.load_vhash(@dummy_shash)
    @dummy_class.load_vhelper
    @dummy_class.find(5).class.should == Hash
    @dummy_class.find(:name => "Merry").class.should == Hash
    @dummy_class.find(:name => "Merry", :age => 18).class.should == Hash
    @dummy_class.find(:age => 21).class.should == Hash
    @dummy_class.find(5)[5]["name"]["value"].should == "Merry"
    @dummy_class.find(:name => "Merry")[5]["age"]["value"].should == 18
    @dummy_class.find(:name => "Merry", :age => 18)[5]["name"]["type"].should == "string"
    @dummy_class.find(:age => 21).keys.sort.should == [3,2].sort
    @dummy_class.find(:age => 21)[3]["name"]["value"].should == "Rebecca"
    @dummy_class.find(:age => 21)[3]["age"]["value"].should == 21
    @dummy_class.find(:age => 21)[2]["name"]["type"].should == "string"
  end

  it "should insert new element into static hash" do
    @dummy_class.insert_shash(@dummy_element).should == "inserted element into static hash"
  end

  it "should clear collection" do
  	@dummy_class.load_vhash(@dummy_shash)
    @dummy_class.load_vhelper
    @dummy_class.instance_variable_get("@vhash").should_not == nil
    @dummy_class.instance_variable_get("@vhelper").should_not == nil
    @dummy_class.clear
    @dummy_class.instance_variable_get("@vhash").should == nil
    @dummy_class.instance_variable_get("@vhelper").should == nil
  end

end