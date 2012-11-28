class Hash
  def remove!(*keys)
    keys.each{|key| self.delete(key) }
    self
  end

  def remove(*keys)
    self.dup.remove!(*keys)
  end
end

class HighlandObject < Array
end