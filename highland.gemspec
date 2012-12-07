Gem::Specification.new do |s|
  s.name        = 'highland'
  s.version     = '0.0.2'
  s.date        = '2012-12-04'
  s.platform = Gem::Platform::RUBY
  s.summary     = "Lightweight NoSQL database inside your Ruby app."
  s.description = %q{HighlandDB is a lightweight NoSQL database for custom Ruby based applications. It creates the database in the application directory, stores data in special highland files and utilizes asymptotically efficient algorythms for working with existing data.}
  s.authors     = ["Max Makarochkin"]
  s.executables = ["highland"]
  s.email       = 'maxim.makarochkin@gmail.com'
  s.files       = ["lib/highland.rb",
                   "bin/highland",
                   "lib/highland/collection_methods.rb",
                   "lib/highland/core_extensions.rb",
                   "lib/highland/database_methods.rb",
                   "lib/highland/environment.rb",
                   "lib/highland/highland.rb",
                   "README.md",
                   "spec/",
                   "doc/"]
  s.homepage    = 'http://mac-r.github.com/highland'
  s.add_dependency("rio")
  s.add_dependency("gli")
end
