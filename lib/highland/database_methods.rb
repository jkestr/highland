require 'rio'
require File.join(File.dirname(__FILE__), "core_extensions" )

module Highland
  module DatabaseMethods

  	def init_file(shash)
  	  @file = shash
      generate_hl if File.exists?(@file) == false
  	end

    def generate_hl
      File.new(@file, "w")
    end

    def load_vhash(shash)
      init_file(shash)
      data = "{#{rio(@file).contents}}"
      @vhash = eval(data)
    end

    def update_columns
      @columns = @vhelper.keys
    end
  
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

    def insert_vhash(element)
      element.each_key do |key|
        @vhash[key] = element[key]
      end
    end

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

    def insert_shash(element)
      File.open(@file, 'a') do |file|
        element.each_key do |id|
          file.puts "#{id} => #{element[id]},"
        end        
      end
    end

    def clear_virtual
      @vhash, @vhelper = nil, nil
    end

    def clear_static
      File.truncate(@file, 0)
    end

    def delete(*query)
      find_db(*query).each_key do |id|
        @vhash.remove!(id)
      end
      load_vhelper
      clear_static
      insert_shash(@vhash)
    end

    def update(*query)
      id = query[0][:id]
      query[0].each_key do |key|
        next if key == :id
        @vhash[id][key.to_s]["value"] = query[0][key] if @vhash[id].has_key?(key.to_s)
      end
      load_vhelper
      clear_static
      insert_shash(@vhash)
    end

    def return_vhash
      @vhash
    end

  end
end