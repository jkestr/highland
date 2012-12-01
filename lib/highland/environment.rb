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
      classes = define_classes(collections)
      load_virtuals(classes)
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
      classes = []
      collections.each do |collection|
        new_classes = Object.const_set(collection, Class.new)
        new_classes.extend Highland::CollectionMethods
        new_classes.extend Highland::DatabaseMethods
        classes << new_classes
      end
      return classes           
    end

    def load_virtuals(classes)
      classes.each do |klass|
        target = klass.to_s.downcase
        klass.init_collection(DB_PATH + "db/#{target}.hl")
      end
    end

  end
end