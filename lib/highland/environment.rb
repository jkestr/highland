require 'yaml'
#puts "#{Dir.glob('*').select {|f| File.directory? f}}"
# $default_collections = "highland/db/" 
# $custom_collections = ""
 COLLECTIONS = ["DummyUsers"]

module Highland

  def self.included(klass)
    puts "Included #{self} into #{klass}"
    klass.extend CollectionMethods
  end

  module HighlandEnvironment

    def self.define
      self.load_collections
    end

    def self.load_collections
      COLLECTIONS.each do |collection|
        new_collection = Object.const_set(collection, Class.new)
        new_collection.extend Highland::CollectionMethods
        new_collection.extend Highland::DatabaseMethods
      end
    end

  end
end

      # config = YAML.load_file("#{DIR}/config.yml")
      # collections = config.keys