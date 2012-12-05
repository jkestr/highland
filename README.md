![Highland Logo](https://raw.github.com/mac-r/highland/master/logo.png)

[![Build Status](https://secure.travis-ci.org/mac-r/highland.png)](https://travis-ci.org/mac-r/highland)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/mac-r/highland)

#### Requirements:
 ruby 1.9.3

### Overview:

HighlandDB is a lightweight NoSQL database for custom Ruby based applications. It creates the database in the application directory, stores data in special highland files and utilizes assymptotically efficient algorythms for working with existing data.

#### HighlandDB and Your Application:

You've got some Rack or other application (ex. Sinatra, Rails, Ajaila). Install HighlandDB as a gem. Initialize DB in the root folder and have fun. You'll have highland folder in the root directory of your project (with manifesto and collections).

#### Get Data:

```yml
collections:
  - Users
```

```ruby

require "highland"

Users.all(:name => ‘Fake’, :age => 20)
Users.all(:age => 20)
Users.all

Users.clear

Users.count(:name => ‘Fake’, :age => 20)
Users.count(:name => ‘Fake’)
Users.count(:age => 21)
Users.count

Users.create(:age => 26, :name => ‘Chris’)

Users.distinct(:name)
Users.distinct(:id)

Users.find([put ids here, ... , id])
Users.find(:age => [20,21,22])
Users.find(:age => [28])
Users.find(:age => 20)

Users.first(:name => ‘Bill’, :age => 80)
Users.first(:age => 80)

Users.remove(:age => 25, :name => “Bob”)

Users.sort(:age)
Users.sort(:age => “asc”)
Users.sort(:age => “desc”)

Users.update(:id => some_id,:age => 40, :name => “Kate”)

Users.where(:name => ‘Helen’, :age => 20)
Users.where(:age => 20)

```
