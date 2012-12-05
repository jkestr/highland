![Highland Logo](https://raw.github.com/mac-r/highland/master/logo.png)

[![Build Status](https://secure.travis-ci.org/mac-r/highland.png)](https://travis-ci.org/mac-r/highland)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/mac-r/highland)

#### Requirements:
 ruby 1.9.3

### Overview:

HighlandDB is a lightweight NoSQL database for custom Ruby based applications. It creates the database in the application directory, stores data in special highland files and utilizes assymptotically efficient algorythms for working with existing data.

#### HighlandDB and Your Application:

You've got some Rack or other application (ex. Sinatra, Rails, Ajaila). Install HighlandDB as a gem. Initialize DB in the root folder and have fun. You'll have highland folder in the root directory of your project (with manifesto and collections).

### Highland Cheat Sheet:
Simplicity is the core feature of Highland. You can look through the workflow below to learn everything you need to get started with this awesome database.

#### 0) Install highland gem and run bundler in your terminal:
```
$ gem install highland
$ bundle install
```
If everyrhing is green - go to the next step.

#### 1) Go to the root directory and type:
```
$ highland init
```
That will generate 'highland_db' folder with 'manifesto.yml' file and 'db' directory inside.

#### 2) Go to the 'highland_db' folder and edit 'manifesto.yml':
```yml
# inside manifesto.yml
collections:
  - Users # <= add your collections like that
```
Now you we can work with Users collection in any way we want.

#### 3) Simply add 'highland' to any file:
```ruby
# some file inside your application
require "highland"
 # work with highland dsl here 
```
#### 4) Look through examples of queries:
```ruby

# Will return all HighlandObjects of 
# collection or some of them according to the query.
Users.all(:name => "Fake", :age => 20)
Users.all(:age => 20)
Users.all

# Clears the collection. 
# Static and virtual hashes get empty.
Users.clear

# Define keys and it will return all
# elements from collection. If the order is not
# specified - it’s ascending.
Users.count(:name => "Fake", :age => 20)
Users.count(:name => "Fake")
Users.count(:age => 21)
Users.count

# Creates new element in the collection.
Users.create(:age => 26, :name => "Chris")

# Allows to get all values of a specified key
# inside collection. It’s a good way to get all ids as well.
Users.distinct(:name)
Users.distinct(:id)

# Allows you to find elements in collection. It’s more
# powerful than “where” if you want to find several
# elements by id or by other keys.
Users.find([put ids here, ... , id])
Users.find(:age => [20,21,22])
Users.find(:age => [28])
Users.find(:age => 20)

# Returns the first element according to the query.
Users.first(:name => "Bill", :age => 80)
Users.first(:age => 80)

# Removes the element of collection.
Users.remove(:age => 25, :name => "Bob")

# Define the key and it will return all elements
# from collection. If the order is not specified - it’s ascending.
# Look at examples of possible syntax.
Users.sort(:age)
Users.sort(:age => "asc")
Users.sort(:age => "desc")

# Updates the element of collection.
Users.update(:id => some_id,:age => 40, :name => "Kate")

# Returns an array of elements according to the query.
Users.where(:name => "Helen", :age => 20)
Users.where(:age => 20)

```
