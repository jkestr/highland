require 'rio'

module Highland
  module DatabaseMethods
  	
  	def init_file(shash)
  	  @file = shash
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

    def find(*query)
      if query[0].class == Fixnum
        id = query[0]
        output ={}
        output[id] = @vhash[id]
        return output
      end
      if query[0].class == Hash
      	q = query[0]
        ids = []
        q.each_key do |column|
          ids << @vhelper[column.to_s][q[column]]
        end
        res = ids.inject(ids.first){ |sim,cur| sim & cur }
        output = {}
        res.each {|id| output[id] = @vhash[id]}
        return output
      end
    end

    def insert_shash(element)
      empty = true if rio(@file)[0...10] == []
      empty = false if rio(@file)[0...10] != []
      File.open(@file, 'a') do |file|
        element.each_key do |id|
          file.puts ", #{id} => #{element[id]}" if empty == false
          file.puts "#{id} => #{element[id]}" if empty == true
        end        
      end
    end

    def clear
      @vhash, @vhelper = nil, nil
    end

  end
end