require 'highland/environment'
require 'highland/collection_methods'
require 'highland/database_methods'

module Highland
  include Environment
  include DatabaseMethods
  include CollectionMethods  
end