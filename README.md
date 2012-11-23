![Highland Logo](https://raw.github.com/mac-r/highland/master/logo.png)

[![Build Status](https://secure.travis-ci.org/mac-r/highland.png)](https://travis-ci.org/mac-r/highland)

### Overview:

HighlandDB is a lightweight NoSQL database for custom Ruby based applications. It creates the database in the application directory, stores data in special highland files and utilizes assymptotically efficient algorythms for working with existing data.

#### HighlandDB and Your Application:

You've got some Rack or other application (ex. Sinatra, Rails, Ajaila). Install HighlandDB as a gem. Initialize DB in the root folder and have fun, don't forget to adjust access features or other stuff in the configuration file. You'll have highland folder in the root directory of your project (with db and tables).

NB! For Ruby apps only.

#### New Tables:
* creates manifesto for particular table
* ready to write input data in some table of db
* writes everything in the first table with indexed rows (id as indexer)
* creates helper tables with sorted columns, one table per sorted column

#### Get Data:

```yml
# manifesto for peple table
people: table
name: string
age: integer
born: date
```

```ruby
require "highland"
People.all # returns array of class objects
People.all(age > 10) # returns array of objects according to criteria
```