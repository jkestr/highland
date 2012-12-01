require 'yaml'
COLLECTIONS = ["DummyUsers"]

module Highland

  module HighlandEnvironment
    self.extend Highland::HighlandEnvironment
    @@klasses = []
    @@stringklasses = []
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
      collections.each do |collection|
        if @@klasses.include?(collection) == false
          new_class = Object.const_set(collection, Class.new)
          new_class.extend Highland::CollectionMethods
          new_class.extend Highland::DatabaseMethods
          @@stringklasses << new_class
          @@klasses << collection
        end
      end
      return @@stringklasses           
    end

    def load_virtuals(classes)
      classes.each do |klass|
        target = klass.to_s.downcase
        klass.init_collection(DB_PATH + "db/#{target}.hl")
      end
    end

  end
end