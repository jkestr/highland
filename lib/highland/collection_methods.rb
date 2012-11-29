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
      if params[0].class != Hash
        output = []
        params.each do |id|
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

    def sort(*params)
      column = params[0].keys.first if params[0].class == Hash
      column = params[0] if params[0].class == Symbol
      sequence = "asc"
      sequence = "desc" if params[0].class == Hash and params[0][column] == "desc"
      sorted = @vhelper[column.to_s].keys.sort{|x,y| x <=> y} if sequence == "asc"
      sorted = @vhelper[column.to_s].keys.sort{|x,y| y <=> x} if sequence == "desc"
      output = []
      sorted.each do |s|
        @vhelper[column.to_s][s].each do |id|
          output += find(id)
        end
      end
      return output
    end

    def count(*params)
      return find_db(*params).keys.length if params[0].class == Hash
      return @vhash.keys.length
    end

    def size(*params)
      count(*params)
    end

    # Users.distinct(:age) => [26, 29, 28]
    def distinct(column)
      @vhelper[column.to_s].keys
    end

    def update(*params)
      update_db(*params)
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