var search_data = {"index":{"searchIndex":["colors","dummyclass","hash","highland","collectionmethods","databasemethods","environment","highlandobject","object","string","all()","build()","build_object()","clear()","clear_static()","clear_virtual()","color()","count()","create()","create_missing()","define_classes()","delete()","delete_unused()","distinct()","expander()","find()","find_db()","find_root()","find_root()","first()","generate_hl()","get_collections()","get_static()","help()","init_collection()","init_file()","insert_shash()","insert_vhash()","insert_vhelper()","load()","load_collections()","load_vhash()","load_vhelper()","load_virtuals()","objectize()","reload_virtual()","remove()","remove()","remove!()","return_vhash()","return_vhelper()","root?()","root?()","size()","sort()","update()","update_columns()","update_db()","where()","gemfile","rakefile","gemfile","procfile"],"longSearchIndex":["colors","dummyclass","hash","highland","highland::collectionmethods","highland::databasemethods","highland::environment","highlandobject","object","string","highland::collectionmethods#all()","highland::environment#build()","highland::collectionmethods#build_object()","highland::collectionmethods#clear()","highland::databasemethods#clear_static()","highland::databasemethods#clear_virtual()","string#color()","highland::collectionmethods#count()","highland::collectionmethods#create()","highland::environment#create_missing()","highland::environment#define_classes()","highland::databasemethods#delete()","highland::environment#delete_unused()","highland::collectionmethods#distinct()","highland::environment#expander()","highland::collectionmethods#find()","highland::databasemethods#find_db()","highland::environment#find_root()","object#find_root()","highland::collectionmethods#first()","highland::databasemethods#generate_hl()","highland::environment#get_collections()","highland::environment#get_static()","object#help()","highland::collectionmethods#init_collection()","highland::databasemethods#init_file()","highland::databasemethods#insert_shash()","highland::databasemethods#insert_vhash()","highland::databasemethods#insert_vhelper()","highland::environment#load()","highland::environment#load_collections()","highland::databasemethods#load_vhash()","highland::databasemethods#load_vhelper()","highland::environment#load_virtuals()","highland::collectionmethods#objectize()","highland::databasemethods#reload_virtual()","hash#remove()","highland::collectionmethods#remove()","hash#remove!()","highland::databasemethods#return_vhash()","highland::databasemethods#return_vhelper()","highland::environment#root?()","object#root?()","highland::collectionmethods#size()","highland::collectionmethods#sort()","highland::collectionmethods#update()","highland::databasemethods#update_columns()","highland::databasemethods#update_db()","highland::collectionmethods#where()","","","",""],"info":[["Colors","","Colors.html","","<p>This are console colors.\n"],["DummyClass","","DummyClass.html","","<p>Is a class for testing purposes.\n"],["Hash","","Hash.html","",""],["Highland","","Highland.html","","<p>Highland is a lightweight NoSQL database. Enjoy!\n"],["Highland::CollectionMethods","","Highland/CollectionMethods.html","","<p>CollectionMethods are mostly the API of Highland. Methods marked with\n“API:” are the ones, …\n"],["Highland::DatabaseMethods","","Highland/DatabaseMethods.html","","<p>DatabaseMethods are not the part of the user API. These methods are the\nfundamentals of the one. They …\n"],["Highland::Environment","","Highland/Environment.html","","<p>Environment is the initial set of methods, which gets loaded after you\ninclude highland in your file. …\n"],["HighlandObject","","HighlandObject.html","",""],["Object","","Object.html","",""],["String","","String.html","",""],["all","Highland::CollectionMethods","Highland/CollectionMethods.html#method-i-all","(*params)","<p>API: Returns all elements from the collection, you can also specify details\nof your request. Look at …\n"],["build","Highland::Environment","Highland/Environment.html#method-i-build","(file)","<p>Build is an alternative for load method. Allows you to redefine class\nvariable. It’s not recommended …\n"],["build_object","Highland::CollectionMethods","Highland/CollectionMethods.html#method-i-build_object","()","<p>Objectize method helper.\n"],["clear","Highland::CollectionMethods","Highland/CollectionMethods.html#method-i-clear","()","<p>API: Clears the collection. Static and virtual hashes get empty.\n<p>example: your code &mdash; Users.clear\n<p>example: … &mdash; "],["clear_static","Highland::DatabaseMethods","Highland/DatabaseMethods.html#method-i-clear_static","()","<p>Clears static hash (collection).\n"],["clear_virtual","Highland::DatabaseMethods","Highland/DatabaseMethods.html#method-i-clear_virtual","()","<p>Clears virtual hash and virtual helper.\n"],["color","String","String.html#method-i-color","(color)",""],["count","Highland::CollectionMethods","Highland/CollectionMethods.html#method-i-count","(*params)","<p>API: Define keys and it will return all elements from collection. If the\norder is not specified - it’s …\n"],["create","Highland::CollectionMethods","Highland/CollectionMethods.html#method-i-create","(*params)","<p>API: Creates new element in collection.\n<p>example: your code &mdash; Users.create(:age =&gt; 26, :name =&gt; ‘Chris’) …\n"],["create_missing","Highland::Environment","Highland/Environment.html#method-i-create_missing","(collections, static)","<p>Creates all the missing static hashes, which are mentioned in manifesto.\n"],["define_classes","Highland::Environment","Highland/Environment.html#method-i-define_classes","(collections)","<p>Creates classes for relevant collections and provides them with API.\n"],["delete","Highland::DatabaseMethods","Highland/DatabaseMethods.html#method-i-delete","(*query)","<p>Deletes element from collection.\n"],["delete_unused","Highland::Environment","Highland/Environment.html#method-i-delete_unused","(collections, static)","<p>Deletes all static collections, which are not mentioned in the manifesto.\n"],["distinct","Highland::CollectionMethods","Highland/CollectionMethods.html#method-i-distinct","(column)","<p>API: Allows to get all values of a specified key inside collection. It’s a\ngood way to get all ids as …\n"],["expander","Highland::Environment","Highland/Environment.html#method-i-expander","(file)","<p>Expands the path of input file.\n"],["find","Highland::CollectionMethods","Highland/CollectionMethods.html#method-i-find","(*params)","<p>API: Allows you to find elements in collection. It’s more powerful than\n“where” if you want …\n"],["find_db","Highland::DatabaseMethods","Highland/DatabaseMethods.html#method-i-find_db","(*query)","<p>Finds hash elements according to the query.\n"],["find_root","Highland::Environment","Highland/Environment.html#method-i-find_root","(path)","<p>Recursive method, which tries to find the application root.\n"],["find_root","Object","Object.html#method-i-find_root","(path = File.expand_path(File.dirname(__FILE__)))",""],["first","Highland::CollectionMethods","Highland/CollectionMethods.html#method-i-first","(*params)","<p>API: Returns the first element according to the query.\n<p>example: your code #1 &mdash; Users.first(:name =&gt; ‘Bill’, …\n"],["generate_hl","Highland::DatabaseMethods","Highland/DatabaseMethods.html#method-i-generate_hl","()","<p>Creates static hash in the database folder.\n"],["get_collections","Highland::Environment","Highland/Environment.html#method-i-get_collections","()","<p>Gets names of collections from manifesto.yml.\n"],["get_static","Highland::Environment","Highland/Environment.html#method-i-get_static","()","<p>Gets all static hashes (collections) from the database folder.\n"],["help","Object","Object.html#method-i-help","","<p>Returns the version of Highland, further it should return the list of\ncommands and examples of HighlandDB …\n"],["init_collection","Highland::CollectionMethods","Highland/CollectionMethods.html#method-i-init_collection","(collection)","<p>Initializes collection (loads virtual hash and helper).\n"],["init_file","Highland::DatabaseMethods","Highland/DatabaseMethods.html#method-i-init_file","(shash)","<p>Defines @file instance variable.\n"],["insert_shash","Highland::DatabaseMethods","Highland/DatabaseMethods.html#method-i-insert_shash","(element)","<p>Inserts hash element into the static hash.\n"],["insert_vhash","Highland::DatabaseMethods","Highland/DatabaseMethods.html#method-i-insert_vhash","(element)","<p>Inserts hash element into the virtual hash.\n"],["insert_vhelper","Highland::DatabaseMethods","Highland/DatabaseMethods.html#method-i-insert_vhelper","(element)","<p>Inserts hash element into the virtual helper.\n"],["load","Highland::Environment","Highland/Environment.html#method-i-load","()","<p>Load initializes the class variable @@db_path and loads collections. You\nshouldn’t call this method. …\n"],["load_collections","Highland::Environment","Highland/Environment.html#method-i-load_collections","()","<p>Gets the list of static collections, compares it with the manifesto.yml. If\nmanifesto.yml doesn’t include …\n"],["load_vhash","Highland::DatabaseMethods","Highland/DatabaseMethods.html#method-i-load_vhash","(shash)","<p>Loads virtual hash.\n"],["load_vhelper","Highland::DatabaseMethods","Highland/DatabaseMethods.html#method-i-load_vhelper","()","<p>Loads virtual helper.\n"],["load_virtuals","Highland::Environment","Highland/Environment.html#method-i-load_virtuals","(classes)","<p>Loads virtual hash and virtual helper for each collection.\n"],["objectize","Highland::CollectionMethods","Highland/CollectionMethods.html#method-i-objectize","(hash)","<p>It’s one of core methods, which works as a factory for HighlandObjects.\n"],["reload_virtual","Highland::DatabaseMethods","Highland/DatabaseMethods.html#method-i-reload_virtual","()","<p>Reloads virtual hash and virtual helper.\n"],["remove","Hash","Hash.html#method-i-remove","(*keys)",""],["remove","Highland::CollectionMethods","Highland/CollectionMethods.html#method-i-remove","(*params)","<p>API: Removes the element of collection.\n<p>example: your code &mdash; Users.remove(:age =&gt; 25, :name =&gt; “Bob”) …\n"],["remove!","Hash","Hash.html#method-i-remove-21","(*keys)",""],["return_vhash","Highland::DatabaseMethods","Highland/DatabaseMethods.html#method-i-return_vhash","()","<p>Returns virtual hash.\n"],["return_vhelper","Highland::DatabaseMethods","Highland/DatabaseMethods.html#method-i-return_vhelper","()","<p>Returns virtual helper.\n"],["root?","Highland::Environment","Highland/Environment.html#method-i-root-3F","(path)","<p>Returns true if the input path is the application root.\n"],["root?","Object","Object.html#method-i-root-3F","(path)",""],["size","Highland::CollectionMethods","Highland/CollectionMethods.html#method-i-size","(*params)","<p>API: is a synonim for “count”.\n"],["sort","Highland::CollectionMethods","Highland/CollectionMethods.html#method-i-sort","(*params)","<p>API: Define the key and it will return all elements from collection. If the\norder is not specified - …\n"],["update","Highland::CollectionMethods","Highland/CollectionMethods.html#method-i-update","(*params)","<p>API: Updates the element of collection.\n<p>example: your code &mdash; Users.update(:id =&gt; some_id,:age =&gt; 40, …\n"],["update_columns","Highland::DatabaseMethods","Highland/DatabaseMethods.html#method-i-update_columns","()","<p>Assigns the latest information about columns the @columns.\n"],["update_db","Highland::DatabaseMethods","Highland/DatabaseMethods.html#method-i-update_db","(*query)","<p>Updates element.\n"],["where","Highland::CollectionMethods","Highland/CollectionMethods.html#method-i-where","(*params)","<p>API: Returns array of elements according to the query.\n<p>example: your code #1 &mdash; Users.where(:name =&gt; ‘Helen’, …\n"],["Gemfile","","Gemfile.html","","<p>source ‘rubygems.org’\n<p>group :test do\n\n<pre>gem 'rake'\ngem 'rspec'</pre>\n"],["Rakefile","","Rakefile.html","","<p>#!/usr/bin/env rake\n<p>task :default =&gt; [:test]\n<p>task :test do\n"],["Gemfile","","spec/highland/dummy_apps/sinatra/Gemfile.html","",""],["Procfile","","spec/highland/dummy_apps/sinatra/Procfile.html","","<p>web: bundle exec ruby app.rb -p $PORT\n"]]}}