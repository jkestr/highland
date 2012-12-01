require 'yaml'
COLLECTIONS = ["DummyUsers"]

module Highland

  def self.included(klass)
    puts "Included #{self} into #{klass}"
    klass.extend CollectionMethods
  end

  module HighlandEnvironment
    self.extend Highland::HighlandEnvironment

    def load
      load_collections
    end
    
    def load_collections   
      collections = get_collections
      static = get_static
      create_missing(collections, static)
      delete_unused(collections, static)
      define_classes(collections)
    end

    def get_collections
      return YAML.load_file(DB_PATH + "manifesto.yml")["collections"]
    end

    def get_static
      return Dir[DB_PATH + "db/*.hl"].map do |file|
        File.basename(file,".hl").downcase
      end
    end

    def create_missing(collections, static)
      collections.each do |c|
        File.open(DB_PATH + "db/#{c.downcase}.hl", "w") if static.include?(c.downcase) == false
      end
    end

    def delete_unused(collections, static)
      static.each do |c|
        File.delete(DB_PATH + "db/#{c.downcase}.hl") if collections.map(&:downcase).include?(c.downcase) == false
      end      
    end

    def define_classes(collections)
      collections.each do |collection|
        new_collection = Object.const_set(collection, Class.new)
        new_collection.extend Highland::CollectionMethods
        new_collection.extend Highland::DatabaseMethods
      end           
    end

  end
end
# Dir["*.hl"].each {|file| puts File.basename(file,".hl")}
      # config = YAML.load_file("#{DIR}/config.yml")
      # collections = config.keys