HighlandDB is a lightweight NoSQL database for custom Ruby based applications. It creates the database in the application directory, stores data in special highland files and utilizes asymptotically efficient algorythms for working with existing data.

![Highland Logo](https://raw.github.com/mac-r/highland/master/logo.png)

##There are several things which are really cool: 
You can store all data inside the directory of your Rails / Sinatra / Whatever application. Thus, you can deploy your app without any "real" database, perfect for blogs, small communities. Forget about migrations and table structures, simply write your data in a way you want.


##I don't recommend HighlandDB: 
If you are planning to write more than 1k rows inside collection, after 500 rows each request gets significantly slow. Moreover, for now there are only two supported input types: string and float, I just didn't need any more.

[![Build Status](https://secure.travis-ci.org/mac-r/highland.png)](https://travis-ci.org/mac-r/highland)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/mac-r/highland)

## Learn more about Highland
[Installation](https://github.com/mac-r/highland/wiki/Installation)  |  [Querying](https://github.com/mac-r/highland/wiki/Querying) | [Making a Contribution](https://github.com/mac-r/highland/issues?milestone=&page=1&state=open)  |  [RDoc Documentation](http://rubydoc.info/github/mac-r/highland/frames/index)

## Requirements
 ruby 1.9.3
