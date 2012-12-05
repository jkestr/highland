Gem::Specification.new do |s|
  s.name        = 'highland'
  s.version     = '0.0.1'
  s.date        = '2012-12-04'
  s.platform = Gem::Platform::RUBY
  s.summary     = "Lightweight NoSQL database inside your Ruby app."
  s.description = "Simple database initially built as a default Ajaila database, which can be installed in less than a minute."
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
  s.homepage    = 'http://github.com/mac-r/highland'
  s.add_dependency("rio")
  s.add_dependency("gli")
end
