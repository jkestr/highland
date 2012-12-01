require 'yaml'
COLLECTIONS = ["DummyUsers"]

module Highland

  def self.included(klass)
    puts "Included #{self} into #{klass}"
    klass.extend CollectionMethods
  end

  module HighlandEnvironment

    def self.load
      self.load_collections
    end
    
    def self.load_collections   
      collections = self.get_collections
      static = Dir[DB_PATH + "db/*.hl"].map do |file|
        File.basename(file,".hl").downcase
      end
      downcased_collections = collections.map {|c| c.downcase}
      collections.each do |c|
        File.open(DB_PATH + "db/#{c.downcase}.hl", "w") if static.include?(c.downcase) == false
      end
       
      static.each do |c|
        File.delete(DB_PATH + "db/#{c.downcase}.hl") if downcased_collections.include?(c.downcase) == false
      end      
    
      collections.each do |collection|
        new_collection = Object.const_set(collection, Class.new)
        new_collection.extend Highland::CollectionMethods
        new_collection.extend Highland::DatabaseMethods
      end
     
    end

    def self.get_collections
      return YAML.load_file(DB_PATH + "manifesto.yml")["collections"]
    end

  end
end
# Dir["*.hl"].each {|file| puts File.basename(file,".hl")}
      # config = YAML.load_file("#{DIR}/config.yml")
      # collections = config.keys