require 'highland/environment'
require 'highland/collection_methods'
require 'highland/database_methods'

##
# Highland is a lightweight NoSQL database. Enjoy!
module Highland
  include Environment
  include DatabaseMethods
  include CollectionMethods  
end

Highland::Environment.load