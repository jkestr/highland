# Inserting
Users.create(:age => 26, :name => 'Chris')

# Querying
Users.where(:name => 'John').first
Users.first(:name => 'John')
Users.where(:name => 'John').all
Users.all(:name => 'John')

# Find by _id
Users.find('chris')
Users.find('chris', 'steve')
Users.find(['chris', 'steve'])

# Sort
Users.sort(:age).all
Users.sort(:age.asc).all # same as above
Users.sort(:age.desc).all
Users.sort(:age).last # steve

# Counting
Users.count # 3
Users.size # 3
Users.count(:name => 'John')       # 1
Users.where(:name => 'John').count # 1
Users.where(:name => 'John').size  # 1

# Distinct
Users.distinct(:age) # [26, 29, 28]

# Select only certain fields
Users.fields(:age).find('chris')   # {"_id"=>"chris", "age"=>26}
Users.only(:age).find('chris')     # {"_id"=>"chris", "age"=>26}
Users.ignore(:name).find('chris')  # {"_id"=>"chris", "age"=>26}

# Pagination, yeah we got that
Users.sort(:age).paginate(:per_page => 1, :page => 2)
Users.sort(:age).per_page(1).paginate(:page => 2)

Users.sort(:age).limit(2).to_a           # [chris, john]
Users.sort(:age).skip(1).limit(2).to_a   # [john, steve]
Users.sort(:age).offset(1).limit(2).to_a # [john, steve]

# Symbol Operators
Users.where(:age.gt => 28).count       # 1 (steve)
Users.where(:age.lt => 28).count       # 1 (chris)
Users.where(:age.in => [26, 28]).to_a  # [chris, john]
Users.where(:age.nin => [26, 28]).to_a  # [steve]

# Removing
Users.remove(:name => 'John')
Users.count # 2
Users.where(:name => 'Chris').remove
Users.count # 1
Users.remove
Users.count # 0