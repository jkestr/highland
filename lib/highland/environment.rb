require 'yaml'

module Highland
  
  ##
  # Environment is the initial set of methods, which gets loaded
  # after you include highland in your file. It depends
  # on the set of static files inside highland_db folder. If you
  # write "require 'highland'" in your file and noothing works then
  # it means that you didn't initialize your database in the folder
  # of your application ($ highland init).
  module Environment
    self.extend Highland::Environment
    @@klasses = []
    @@stringklasses = []
    @@db_path = ""

    ##
    # Load initializes the class variable @@db_path and loads collections.
    # You shouldn't call this method. It's done automatically. If you want
    # to specify the path to your database - write custom path in DB_PATH
    # before "require 'highland'".
    def load
      @@db_path = find_root(Dir::pwd) if defined?(DB_PATH) == nil
      @@db_path = DB_PATH if defined?(DB_PATH) == "constant"
      load_collections
    end
    
    ##
    # Build is an alternative for load method. Allows you to redefine class
    # variable. It's not recommended to use this method.
    def build(file)
      @@db_path = find_root(expander(file)) if defined?(DB_PATH) == nil
      load_collections
    end

    ##
    # Gets the list of static collections, compares it with the manifesto.yml.
    # If manifesto.yml doesn't include some static collections - this collections
    # get deleted. If manifesto.yml has collections which do not exist then these
    # collections are automatically created. After this - virtual hashes are loaded.
    def load_collections   
      collections = get_collections
      static = get_static
      create_missing(collections, static)
      delete_unused(collections, static)
      classes = define_classes(collections)
      load_virtuals(classes)
    end

    ##
    # Gets names of collections from manifesto.yml.
    def get_collections
      return YAML.load_file(@@db_path + "manifesto.yml")["collections"]
    end

    ##
    # Gets all static hashes (collections) from the database folder.
    def get_static
      return Dir[@@db_path + "db/*.hl"].map do |file|
        File.basename(file,".hl").downcase
      end
    end

    ##
    # Creates all the missing static hashes, which are mentioned in manifesto.
    def create_missing(collections, static)
      collections.each do |c|
        File.open(@@db_path + "db/#{c.downcase}.hl", "w") if static.include?(c.downcase) == false
      end
    end

    ##
    # Deletes all static collections, which are not mentioned in the manifesto.
    def delete_unused(collections, static)
      static.each do |c|
        File.delete(@@db_path + "db/#{c.downcase}.hl") if collections.map(&:downcase).include?(c.downcase) == false
      end      
    end

    ##
    # Creates classes for relevant collections and provides them with API.
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

    ##
    # Loads virtual hash and virtual helper for each collection.
    def load_virtuals(classes)
      classes.each do |klass|
        target = klass.to_s.downcase
        klass.init_collection(@@db_path + "db/#{target}.hl")
      end
    end

    ##
    # Returns true if the input path is the application root.
    def root?(path)
      root_objects = ["gemfile", "procfile", "readme", "root"]  
      current_objects = Dir[path + "/*"].map do |file|
        File.basename(file).downcase
      end
      dir = ""
      current_objects.each do |co| 
         dir = (root_objects.include?(co) == true)? "ROOT" : "NOT ROOT"
         break if dir == "ROOT"
      end
      return true if dir == "ROOT"
      return false if dir == "NOT ROOT"  
    end

    ##
    # Expands the path of input file.
    def expander(file)
      return File.expand_path(File.dirname(file))
    end    
    
    ##
    # Recursive method, which tries to find the application root.
    def find_root(path)
      path = File.expand_path('..', path) if root?(path) == false
      find_root(path) if root?(path) == false
      return path + "/highland_db/" if root?(path) == true
    end
    
  end
end