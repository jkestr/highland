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
  
  it "should objectize" do
    DummyUsers.init_collection(@collection)
    DummyUsers.clear_static
    i = 20
    15.times do
      DummyUsers.create(:age => i, :name => "Fake#{i}")
      i += 1
    end
    vhash = DummyUsers.return_vhash
    a = vhash.keys
    b = []
    DummyUsers.objectize(vhash).each {|el| b << el.id }
    b.sort.should == a.sort    
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
    DummyUsers.where(:name => 'Fake').first.age.should == 20
    DummyUsers.where(:name => 'Fake').last.age.should == 24
    DummyUsers.where(:name => 'Fake').class.should == Array
    DummyUsers.where(:name => 'Fake').length.should == 5
    DummyUsers.where(:name => 'Fake').last.class.should == HighlandObject
    DummyUsers.where(:name => 'Fake').last.name.should == 'Fake'
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
    DummyUsers.init_collection(@collection)
    DummyUsers.clear_static
    i = 20
    5.times do
      DummyUsers.create(:age => i, :name => "Fake")
      i += 1
    end
    i = 30
    5.times do
      DummyUsers.create(:age => i, :name => "Fooo")
      i += 1
    end
    DummyUsers.all(:name => 'Fake').class.should == Array
    DummyUsers.all(:name => 'Fake').length.should == 5
    DummyUsers.all(:name => 'Fake', :age => 20).class.should == Array
    DummyUsers.all(:name => 'Fake', :age => 20).length.should == 1
    DummyUsers.all(:name => 'Fake').first.class.should == HighlandObject
    DummyUsers.all(:name => 'Fake').first.name.should == 'Fake'
    DummyUsers.all(:name => 'Fake', :age => 20).first.age.should == 20
    DummyUsers.all.first.name.should_not == DummyUsers.all.last.name.should_not
    DummyUsers.all.first.age.should_not == DummyUsers.all.last.age.should_not
    DummyUsers.all.class.should == Array
    DummyUsers.all.length.should == 10
    DummyUsers.all.last.class.should == HighlandObject
    DummyUsers.all.last.name.should == 'Fooo'
    DummyUsers.clear_static
    DummyUsers.clear_virtual
  end

  it "should be able to find" do
    DummyUsers.init_collection(@collection)
    DummyUsers.clear_static    
    i = 20
    5.times do
      DummyUsers.create(:age => i, :name => "FinderFake")
      i += 1
    end
    fake_ids = DummyUsers.distinct(:id)    
    fake_ids.should_not == []
    fake_ids.first.should_not == fake_ids.last
    fake_ids.length.should == 5
    DummyUsers.find(*fake_ids).class.should == Array
    DummyUsers.find(*fake_ids).first.class.should == HighlandObject
    DummyUsers.find(*fake_ids).first.name.should == "FinderFake"
    DummyUsers.find(*fake_ids).first.age.should == 20
    DummyUsers.find(*fake_ids).length.should == 5
    DummyUsers.find(:age => [20,21,22]).class.should == Array
    DummyUsers.find(:age => [20,21,22]).first.class.should == HighlandObject
    DummyUsers.find(:age => [20,21,22]).length.should == 3
    DummyUsers.find(:age => [20,21,22,28]).class.should == Array
    DummyUsers.find(:age => [20,21,22,28]).first.class.should == HighlandObject
    DummyUsers.find(:age => [20,21,22,28]).length.should == 3
    DummyUsers.find(:age => [28]).class.should == Array
    DummyUsers.find(:age => [28]).first.should == nil
    DummyUsers.find(:age => 20).class.should == Array
    DummyUsers.find(:age => 20).length.should == 1
    DummyUsers.find(:age => 20).first.class.should == HighlandObject
    DummyUsers.clear_static
    DummyUsers.clear_virtual
  end

  it "should have vhelper" do
    DummyUsers.init_collection(@collection)
    DummyUsers.clear_static
    DummyUsers.clear_virtual
    DummyUsers.init_collection(@collection)
    i = 20
    5.times do
      DummyUsers.create(:age => i, :name => "Fake")
      i += 1
    end
    DummyUsers.return_vhelper["age"].keys.sort.should == [20,21,22,23,24]
    DummyUsers.return_vhelper["name"].keys.sort.should == ["Fake"]
    DummyUsers.clear_static
    DummyUsers.clear_virtual
  end


  it "should be able to sort" do
    DummyUsers.init_collection(@collection)
    DummyUsers.clear_static
    i = 20
    5.times do
      DummyUsers.create(:age => i, :name => "Fake")
      i += 1
    end
    DummyUsers.sort(:age => "asc").class.should == Array
    DummyUsers.sort(:age => "desc").class.should == Array
    DummyUsers.sort(:age).class.should == Array        
    DummyUsers.sort(:age => "asc").first.class.should == HighlandObject
    DummyUsers.sort(:age => "desc").first.class.should == HighlandObject
    DummyUsers.sort(:age).first.class.should == HighlandObject
    els_asc_t = [20,21,22,23,24]
    els_asc = []
    DummyUsers.sort(:age => "asc").each {|el| els_asc << el.age}
    els_desc_t = [24,23,22,21,20]    
    els_desc = []
    DummyUsers.sort(:age => "desc").each {|el| els_desc << el.age}
    els_t = [20,21,22,23,24]    
    els = []
    DummyUsers.sort(:age).each {|el| els << el.age}
    els.should == els_t
    els_asc.should == els_asc_t
    els_desc.should == els_desc_t
    DummyUsers.clear_static
    DummyUsers.clear_virtual
  end

  it "should be able to count" do
    DummyUsers.init_collection(@collection)
    DummyUsers.clear_virtual    
    DummyUsers.clear_static
    DummyUsers.init_collection(@collection)    
    i = 20
    5.times do
      DummyUsers.create(:age => i, :name => "Fake")
      i += 1
    end
    DummyUsers.count(:name => 'Fake', :age => 20).should == 1
    DummyUsers.count(:name => 'Fake').should == 5
    DummyUsers.count(:age => 21).should == 1
    DummyUsers.count.should == 5
    DummyUsers.size(:name => 'Fake', :age => 20).should == 1
    DummyUsers.size(:name => 'Fake').should == 5
    DummyUsers.size(:age => 21).should == 1
    DummyUsers.count.should == 5    
    DummyUsers.clear_static
    DummyUsers.clear_virtual
  end

  it "should distinct" do
    DummyUsers.init_collection(@collection)
    DummyUsers.clear_static
    i = 20
    5.times do
      DummyUsers.create(:age => i, :name => "Fake")
      i += 1
    end
    DummyUsers.distinct(:name).should == ["Fake"]
    DummyUsers.distinct(:age).sort.should == [20,21,22,23,24].sort
    DummyUsers.distinct(:id).length.should == 5
    DummyUsers.clear_static
    DummyUsers.clear_virtual
  end

  it "should update" do
    DummyUsers.init_collection(@collection)
    DummyUsers.clear_static
    i = 20
    15.times do
      a = DummyUsers.create(:age => i, :name => "Fake#{i}").values
      DummyUsers.clear_virtual
      DummyUsers.init_collection(@collection)
      b = DummyUsers.find_db(:age => i, :name => "Fake#{i}").values
      a.should == b
      kid = DummyUsers.first(:age => i, :name => "Fake#{i}").id
      before = DummyUsers.count
      DummyUsers.distinct(:name).include?("Fake#{i}").should == true
      DummyUsers.distinct(:name).include?("OldFake#{i}").should == false
      DummyUsers.update(:id => kid,:age => i+100, :name => "OldFake#{i}")
      DummyUsers.distinct(:name).include?("Fake#{i}").should == false
      DummyUsers.distinct(:name).include?("OldFake#{i}").should == true      
      after = DummyUsers.count
      after.should == before
      i += 1
    end
    DummyUsers.clear_static
    DummyUsers.clear_virtual
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
