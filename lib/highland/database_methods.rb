require 'rio'
require File.join(File.dirname(__FILE__), "core_extensions" )

module Highland

  ##
  # DatabaseMethods are not the part of the user API. These methods
  # are the fundamentals of the one. They work with static hashes and
  # manage virtual ones. It's not recommended to work with these
  # methods directly.
  module DatabaseMethods

    ##
    # Defines @file instance variable.
  	def init_file(shash)
  	  @file = shash
      generate_hl if File.exists?(@file) == false
  	end

    ##
    # Creates static hash in the database folder.
    def generate_hl
      File.new(@file, "w")
    end

    ##
    # Loads virtual hash.
    def load_vhash(shash)
      init_file(shash)
      data = "{#{rio(@file).contents}}"
      @vhash = eval(data)
    end

    ##
    # Assigns the latest information about columns the @columns.
    def update_columns
      @columns = @vhelper.keys
    end
  
    ##
    # Loads virtual helper.
    def load_vhelper
      @vhelper = {}
      @vhash.each_key do |id|
        @vhash[id].each_key do |column|
          @vhelper[column] ||= {}
          item = @vhash[id][column]["value"]
          @vhelper[column][item] ||= []
          @vhelper[column][item] << id
        end
      end
      update_columns
    end

    ##
    # Inserts hash element into the virtual hash.
    def insert_vhash(element)
      element.each_key do |key|
        @vhash[key] = element[key]
      end
    end

    ##
    # Inserts hash element into the virtual helper.
    def insert_vhelper(element)
      element.each_key do |id|
        element[id].each_key do |column|
          @vhelper[column] ||= {}
          item = element[id][column]["value"]
          @vhelper[column][item] ||= []
          @vhelper[column][item] << id
        end
      end
      update_columns
    end

    ##
    # Finds hash elements according to the query.
    def find_db(*query)
      if query[0].class == Fixnum
        id = query[0]
        output = {}
        output[id] = @vhash[id] if @vhash[id] != nil
        return output
      end
      if query[0].class == Hash
      	q = query[0]
        ids = []
        q.each_key do |column|
          ids << @vhelper[column.to_s][q[column]]
        end
        res = ids.inject(ids.first){ |sim,cur| sim & cur }
        return {} if res.class != Array or res == []
        output = {}
        res.each do |id|
          next if @vhash[id] == nil
          output[id] = @vhash[id]
        end
        return output
      end
    end

    ##
    # Inserts hash element into the static hash.
    def insert_shash(element)
      File.open(@file, 'a') do |file|
        element.each_key do |id|
          file.puts "#{id} => #{element[id]},"
        end        
      end
    end

    ##
    # Clears virtual hash and virtual helper.
    def clear_virtual
      @vhash, @vhelper = {}, {}
    end

    ##
    # Reloads virtual hash and virtual helper.
    def reload_virtual
      clear_virtual
      load_vhash(@file)
      load_vhelper
    end

    ##
    # Clears static hash (collection).
    def clear_static
      File.truncate(@file, 0)
    end

    ##
    # Deletes element from collection.
    def delete(*query)
      find_db(*query).each_key do |id|
        @vhash.remove!(id)
      end
      load_vhelper
      clear_static
      insert_shash(@vhash)
      return true
    end

    ##
    # Updates element.
    def update_db(*query)
      id = query[0][:id]
      query[0].each_key do |key|
        next if key == :id
        @vhash[id][key.to_s]["value"] = query[0][key] if @vhash[id].has_key?(key.to_s)
      end
      load_vhelper
      clear_static
      insert_shash(@vhash)
      return true      
    end

    ##
    # Returns virtual hash.
    def return_vhash
      @vhash
    end
    
    ##
    # Returns virtual helper.
    def return_vhelper
      @vhelper
    end
  end
end