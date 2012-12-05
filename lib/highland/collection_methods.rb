module Highland

  ##
  # CollectionMethods are mostly the API of Highland. Methods marked
  # with "API:" are the ones, which are recommended to use day by day.
  module CollectionMethods
    
    ##
    # Initializes collection (loads virtual hash and helper).
    def init_collection(collection)
      init_file(collection)
      load_vhash(@file)
      load_vhelper
    end

    ##
    # API: Creates new element in collection. 
    # [example: your code] Users.create(:age => 26, :name => 'Chris')
    # [example: what happens] Creates user in Users collection.
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

    ##
    # API: Returns array of elements according to the query.
    # [example: your code #1] Users.where(:name => 'Helen', :age => 20)
    # [example: your code #2] Users.where(:age => 20)
    # [example: what happens] Will return Array of HighlandObjects, which
    #                         fit the query constraints.
    def where(*params)
      hash = find_db(*params)
      output = objectize(hash)
      return output
    end

    ##
    # API: Returns the first element according to the query.
    # [example: your code #1] Users.first(:name => 'Bill', :age => 80)
    # [example: your code #2] Users.first(:age => 80)
    # [example: what happens] Will return the first HighlandObject, which
    #                         fits the query constraints.
    def first(*params)
      where(*params).first
    end

    ##
    # API: Returns all elements from the collection, you can also specify
    # details of your request. Look at examples below
    # [example: your code #1] Users.all(:name => 'Fake', :age => 20)
    # [example: your code #2] Users.all(:age => 20)
    # [example: your code #3] Users.all
    # [example: what happens] Will return all HighlandObjects of collection
    #                         or some of them according to the query.
    def all(*params)
      return where(*params) if params[0].class == Hash
      return objectize(@vhash)
    end

    ##
    # API: Allows you to find elements in collection. It's more powerful
    # than "where" if you want to find several elements by id or by other keys.
    # [example: your code #1] Users.find([id,id,...,id])
    # [example: your code #2] Users.find(:age => [20,21,22])
    # [example: your code #3] Users.find(:age => [28])
    # [example: your code #4] Users.find(:age => 20)
    # [example: what happens] Will return HighlandObjects
    #                         according to the query.
    def find(*params)
      output = []
      if params[0].class == Hash
        params[0].each_key do |key|
          [params[0][key]].flatten.each {|el| output = output + all(key => el)}
        end          
      else
        params.each {|id| output += where(id)}
      end
      return output
    end

    ##
    # API: Define the key and it will return all elements from collection.
    # If the order is not specified - it's ascending. Look at examples
    # of possible syntax.
    # [example: your code #1] Users.sort(:age)
    # [example: your code #2] Users.sort(:age => "asc")
    # [example: your code #3] Users.sort(:age => "desc")
    # [example: what happens] Will return HighlandObjects
    #                         according to the defined order.
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

    
    
    
    

    ##
    # API: Define keys and it will return all elements from collection.
    # If the order is not specified - it's ascending. Look at examples
    # of possible syntax.
    # [example: your code #1] Users.count(:name => 'Fake', :age => 20)
    # [example: your code #2] Users.count(:name => 'Fake')
    # [example: your code #3] Users.count(:age => 21)
    # [example: your code #4] Users.count
    # [example: what happens] Will return quantity of files
    #                         according to the defined query.
    def count(*params)
      return find_db(*params).keys.length if params[0].class == Hash
      return @vhash.keys.length
    end

    ##
    # API: is a synonim for "count".
    def size(*params)
      count(*params)
    end

    ##
    # API: Allows to get all values of a specified key inside collection.
    # It's a good way to get all ids as well.
    # [example: your code #1] Users.distinct(:name)
    # [example: your code #2] Users.distinct(:id)
    # [example: what happens] Will return all values of a specified key.
    def distinct(column)
      return @vhelper[column.to_s].keys if column.to_s != "id"
      return @vhash.keys if column.to_s == "id"
    end

    ##
    # API: Updates the element of collection.
    # [example: your code] Users.update(:id => some_id,:age => 40, :name => "Kate")
    # [example: what happens] Will update relative values for element with id equal "some_id".    
    def update(*params)
      update_db(*params)
    end 

    ##
    # API: Removes the element of collection.
    # [example: your code] Users.remove(:age => 25, :name => "Bob")
    # [example: what happens] Removes the element from table according to the query.
    def remove(*params)
      delete(*params)
    end 

    ##
    # API: Clears the collection. Static and virtual hashes get empty.
    # [example: your code] Users.clear
    # [example: what happens] Now Users collection is empty.
    def clear
      clear_virtual
      clear_static
      reload_virtual
    end

    ##
    # It's one of core methods, which works as a factory for HighlandObjects.
    def objectize(hash)
      output = []      
      build_object
      hash.each_key do |id|        
        o = HighlandObject.new
        o.instance_variable_set(:@id, id)        
        o.singleton_class.send(:define_method, :id) { @id }        
        hash[id].each_key do |key|
          instance = "@#{key}"
          o.instance_variable_set(instance.to_sym, hash[id][key]["value"])                  
          o.singleton_class.send(:define_method, key) { eval(instance) }          
        end
        output << o
      end
      return output
    end

    ##
    # Objectize method helper.
    def build_object
      Object.const_set("HighlandObject", Class.new) unless defined?(HighlandObject)
    end

  end
end