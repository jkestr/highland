require 'highland/environment'
require 'highland/collection_methods'
require 'highland/database_methods'

module Highland
  include HighlandEnvironment
  include DatabaseMethods
  include CollectionMethods  
end

Highland::HighlandEnvironment.define
