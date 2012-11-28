#!/usr/bin/env rake

task :default => [:test]

task :test do
  sh("bundle exec rspec spec/")
end

desc "commit and push"
task :cp do
  system "git add ."
  verbs = ["fucks","eats","looks at","kills","inspirates","beats","wins","runs away from","loves","kicks","attacks", "dreams about","supports","deffends","impressed","excited","became popular among","danced with","chilled out","slept with"]
  nouns = ["pigs","cows","rabbits","elephants","chocolate bars","dogs","cats","busty bitches","democrats","liberals","iPhones","MacBooks","bums"]
  quantity = Random.rand(2...100500)
  vi = Random.rand(0...(verbs.length - 1))
  ni = Random.rand(0...(nouns.length - 1))
  system "git commit -m \"mac-r #{verbs[vi]} #{quantity} #{nouns[ni]}\""
  system "git push origin master"
end