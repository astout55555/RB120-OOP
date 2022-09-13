### 1-2

class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

class Cat < Pet
  def speak
    'meow!'
  end

  def fetch
    'I refuse.'
  end

  def swim
    'I refuse.'
  end
end

kitty = Cat.new
puts kitty.speak
puts kitty.run
puts kitty.jump

puts kitty.fetch
puts kitty.swim
