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
Object.const_set(
  "HighlandObject", Class.new do
    include Highland::CollectionMethods
  end
)
collections.each do |classname|
  eval("class #{classname} < HighlandObject; end;")
end