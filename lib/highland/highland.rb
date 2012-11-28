require 'highland/collection_methods'
require 'highland/database_methods'
require 'yaml'

module Highland
  include DatabaseMethods
  include CollectionMethods

  def self.included(klass)
    puts "Included #{self} into #{klass}"
    klass.extend CollectionMethods
  end
  
end

collections = ["DummyUsers"]
#collections = YAML.load_file("#{db}/config.yml").keys
collections.each do |collection|
  new_collection = Object.const_set(collection, Class.new)
  new_collection.extend Highland::CollectionMethods
  new_collection.extend Highland::DatabaseMethods
end