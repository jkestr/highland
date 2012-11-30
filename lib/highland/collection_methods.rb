module Highland
  module CollectionMethods
    
    def init_collection(collection)
      init_file(collection)
      load_vhash(@file)
      load_vhelper
    end

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

    def where(*params)
      hash = find_db(*params)
      output = objectize(hash)
      return output
    end

    def first(*params)
      where(*params).first
    end

    def all(*params)
      return where(*params) if params[0].class == Hash
      return objectize(@vhash)
    end

    def find(*params)
      output = []
      if params[0].class == Hash
        params[0].each_key do |key|
          [params[0][key]].flatten.each {|el| output = output + all(key => el)}
        end          
      else
        params.each {|id| output += objectize(find_db(id))}
      end
      return output
    end

    def sort(*params)
      column = (params[0].class == Hash)?(params[0].keys.first):(params[0])
      sorted = if params[0].class == Hash and params[0][column] == "desc"
        distinct(column).sort{|x,y| y <=> x}
      else
        distinct(column).sort
      end
      output = []
      sorted.each {|s| @vhelper[column.to_s][s].each{|id| output += find(id)}}
      return output
    end

    def count(*params)
      return find_db(*params).keys.length if params[0].class == Hash
      return @vhash.keys.length
    end

    def size(*params)
      count(*params)
    end

    def distinct(column)
      return @vhelper[column.to_s].keys if column.to_s != "id"
      return @vhash.keys if column.to_s == "id"
    end

    def update(*params)
      update_db(*params)
    end 

    def remove(*params)
      delete(*params)
    end 

    def clear
      clear_virtual
      clear_static
    end

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