require 'highland/collection_methods'
require 'highland/database_methods'

module Highland
  include DatabaseMethods
  include CollectionMethods
end

    # Dummy = PseudoCollection.new
    # Dummy.extend(Highland::CollectionMethods)