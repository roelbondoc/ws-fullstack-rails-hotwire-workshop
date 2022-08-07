# A method make it seem a method takes time to run
class Object
  def slowly
    sleep 1
    self
  end
end
