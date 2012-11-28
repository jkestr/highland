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
      output = []
      object = Object.const_set("HighlandObject", Class.new)
      object_instances, i = [], 0
      find_db(*params).each_key do |id|        
        object_instances[i] = object.new
        object_instances[i].class.send(:define_method, :id) { id }
        params[0].each_key do |key|
          method = key
          value = params[0][key]          
          object_instances[i].class.send(:define_method, key) { value }          
        end        
        output << object_instances[i]
        i += 1
      end
      return output
    end

    # Users.first(:name => 'John')
    def first(*params)
      where(*params).first
    end

    # Users.all(:name => 'John')
    def all(*params)
      where(*params)
    end

    # Users.find('chris')
    # Users.find('chris', 'steve')
    # Users.find(['chris', 'steve'])
    def find(*params)
      "called find"
    end

    # Users.sort(:age).all
    # Users.sort(:age.asc).all
    # Users.sort(:age.desc).all
    # Users.sort(:age).last
    def sort(*params)
      "called sort"
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

  end
end

# # Symbol Operators
# Users.where(:age.gt => 28).count       # 1 (steve)
# Users.where(:age.lt => 28).count       # 1 (chris)
# Users.where(:age.in => [26, 28]).to_a  # [chris, john]
# Users.where(:age.nin => [26, 28]).to_a  # [steve]