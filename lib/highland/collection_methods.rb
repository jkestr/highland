require 'yaml'

module Highland
  module CollectionMethods
    # def init(collection)      
    #   DIR
    # end
  	# Users.create(:age => 26, :name => 'Chris')
    def create(*params)
      "called create"
    end

    # Users.where(:name => 'John')
    def where(*params)
      "called where"
    end

    # Users.first(:name => 'John')
    def first(*params)
      "called first"
    end

    # Users.all(:name => 'John')
    def all(*params)
      "called all"
    end

    # Users.find('chris')
    # Users.find('chris', 'steve')
    # Users.find(['chris', 'steve'])
    def find(*params)
      "called find"
    end

    # Users.sort(:age).all
    # Users.sort(:age.asc).all
    # Users.sort(:age.desc).all
    # Users.sort(:age).last
    def sort(*params)
      "called sort"
    end

    # Users.count # 3
    # Users.count(:name => 'John')       # 1
    # Users.where(:name => 'John').count # 1
    def count(*params)
      "called count"
    end

    # Users.size # 3
    # Users.where(:name => 'John').size  # 1
    def size(*params)
      "called size"
    end

    # Users.distinct(:age) => [26, 29, 28]
    def distinct(*params)
      "called distinct"
    end

    # Users.fields(:age).find('chris') => {"_id"=>"chris", "age"=>26}
    def fields(*params)
      "called fields"
    end 

    # Users.only(:age).find('chris') => {"_id"=>"chris", "age"=>26}
    def only(*params)
      "called only"
    end 

    # Users.ignore(:name).find('chris') => {"_id"=>"chris", "age"=>26}
    def ignore(*params)
      "called ignore"
    end 

    # Users.remove(:name => 'John')
    # Users.where(:name => 'Chris').remove
    # Users.remove
    def remove(*params)
      "called remove"
    end 

  end
end

# # Symbol Operators
# Users.where(:age.gt => 28).count       # 1 (steve)
# Users.where(:age.lt => 28).count       # 1 (chris)
# Users.where(:age.in => [26, 28]).to_a  # [chris, john]
# Users.where(:age.nin => [26, 28]).to_a  # [steve]