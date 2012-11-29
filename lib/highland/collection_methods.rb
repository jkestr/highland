module Highland
  module CollectionMethods
    
    def init_collection(collection)
      init_file(collection)
      load_vhash(@file)
      load_vhelper
    end

  	# Users.create(:age => 26, :name => 'Chris')
    def create(*params)
      id = rand(999999999999999999)     
      rec = {}
      params[0].each_key do |key|
        rec[key.to_s] ||= {}
        rec[key.to_s]["type"] = params[0][key].class.to_s.downcase
        rec[key.to_s]["value"] = params[0][key]
      end
      element = {id => rec}
      insert_vhash(element)
      insert_vhelper(element)
      insert_shash(element)
      return element
    end

    # Users.where(:name => 'John')
    def where(*params)
      hash = find_db(*params)
      #puts "#{hash.keys}"
      output = objectize(hash)

      return output
    end

    # Users.first(:name => 'John')
    def first(*params)
      where(*params).first
    end

    # Users.all(:name => 'John')
    def all(*params)
      return where(*params) if params[0].class == Hash
      return objectize(@vhash)
    end

    def find(*params)
      if params[0].class == Array
        output = []
        params[0].each do |id|
          output += objectize(find_db(id))
        end
        return output
      end
      if params[0].class == Hash
        params[0].each_key do |key|
          inp = [params[0][key]] if params[0][key].class != Array
          inp = params[0][key] if params[0][key].class == Array
          output = []
          inp.each do |el|
            output = output + all(key => el)
          end
        end       
        return output
      end
    end
    # DummyUsers.find(fake_ids)
    # DummyUsers.find(:age => [20,21,22]).class.should == Array
    # DummyUsers.find(:age => [20,21,22]).first.class.should == HighlandObject
    # DummyUsers.find(:age => [20,21,22]).length.should == 3
    # DummyUsers.find(:age => [20,21,22,28]).class.should == Array
    # DummyUsers.find(:age => [20,21,22,28]).first.class.should == HighlandObject
    # DummyUsers.find(:age => [20,21,22,28]).length.should == 3
    # DummyUsers.find(:age => [28]).class.should == Array
    # DummyUsers.find(:age => [28]).first.should == nil
    # DummyUsers.find(:age => 20).class.should == Array
    # DummyUsers.find(:age => 20).length.should == 1
    # DummyUsers.find(:age => 20)

    # Users.sort(:age).all
    # Users.sort(:age.asc).all
    # Users.sort(:age.desc).all
    # Users.sort(:age).last
    def sort(*params)
      
    end

    # Users.count # 3
    # Users.count(:name => 'John')       # 1
    # Users.where(:name => 'John').count # 1
    def count(*params)
      "called count"
    end

    # Users.size # 3
    # Users.where(:name => 'John').size  # 1
    def size(*params)
      "called size"
    end

    # Users.distinct(:age) => [26, 29, 28]
    def distinct(*params)
      "called distinct"
    end

    # Users.fields(:age).find('chris') => {"_id"=>"chris", "age"=>26}
    def fields(*params)
      "called fields"
    end 

    # Users.only(:age).find('chris') => {"_id"=>"chris", "age"=>26}
    def only(*params)
      "called only"
    end 

    # Users.ignore(:name).find('chris') => {"_id"=>"chris", "age"=>26}
    def ignore(*params)
      "called ignore"
    end 

    # Users.remove(:name => 'John')
    # Users.where(:name => 'Chris').remove
    # Users.remove
    def remove(*params)
      "called remove"
    end 

   # private

    def objectize(hash)
      output = []
      Object.const_set("HighlandObject", Class.new) unless defined?(HighlandObject)
      object_instances, i = [], 0
      hash.each_key do |id|        
        object_instances[i] = HighlandObject.new
        object_instances[i].instance_variable_set(:@id, id)        
        object_instances[i].class.send(:define_method, :id) { @id }        
        hash[id].each_key do |key|
          instance = "@#{key}"
          value = hash[id][key]["value"]
          object_instances[i].instance_variable_set(instance.to_sym, value)                  
          object_instances[i].singleton_class.send(:define_method, key) { eval(instance) }          
        end
        output << object_instances[i]
        i += 1
      end
      return output
    end

  end
end

# # Symbol Operators
# Users.where(:age.gt => 28).count       # 1 (steve)
# Users.where(:age.lt => 28).count       # 1 (chris)
# Users.where(:age.in => [26, 28]).to_a  # [chris, john]
# Users.where(:age.nin => [26, 28]).to_a  # [steve]