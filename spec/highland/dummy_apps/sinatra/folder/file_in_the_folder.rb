

def root?(path)
  root_objects = ["gemfile", "procfile", "readme"]  
  current_objects = Dir[path + "/*"].map do |file|
    File.basename(file).downcase
  end
  dir = ""
  current_objects.each do |co| 
     dir = (root_objects.include?(co) == true)? "ROOT" : "NOT ROOT"
     break if dir == "ROOT"
  end
  return true if dir == "ROOT"
  return false if dir == "NOT ROOT"  
end


def find_root(path = File.expand_path(File.dirname(__FILE__)))
  path = File.expand_path('..', path) if root?(path) == false
  find_root(path) if root?(path) == false
  return path if root?(path) == true
end

#puts root?(path)
puts find_root()