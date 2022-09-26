### Question 1

# class Greeting
#   def greet(message)
#     puts message
#   end
# end

# class Hello < Greeting
#   def hi
#     greet("Hello")
#   end
# end

# class Goodbye < Greeting
#   def bye
#     greet("Goodbye")
#   end
# end

# # Case 1

# hello = Hello.new
# hello.hi # => 'Hello'

# # Case 2

# hello = Hello.new
# # hello.bye # => raises a NoMethodError, #bye is not defined by Hello or Greeting class

# # Case 3

# hello = Hello.new
# # hello.greet # => raises an ArgumentError, provided 0, requires 1 argument

# # Case 4

# hello = Hello.new
# hello.greet("Goodbye") # => 'Goodbye'

# # Case 5

# # Hello.hi # => raises a NoMethodError, no class method #hi for class Hello

### Question 2

class Greeting
  def self.greet(message) # also here, so it calls one last class method
    puts message
  end
end

class Hello < Greeting
  def self.hi # added `self.` before `hi` to make this a class method
    self.greet("Hello") # also here, so it calls another class method
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

Hello.hi # call this without getting an error

# another option from LS:

class Hello
  def self.hi
    greeting = Greeting.new
    greeting.greet("Hello")
  end
end

### Question 3

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

tom = AngryCat.new(12, 'Tom')
jerry = AngryCat.new(10, 'Jerry')

### Question 4

class Cat
  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{@type} cat."
  end
end

garfield = Cat.new('orange')
puts garfield

# or, don't overwrite #to_s for a more specific custom method (and use a getter)

class Cat
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def display_type
    puts "I am a #{type} cat"
  end
end

### Question 5

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
# tv.manufacturer # NoMethodError (trying to call a class method on an instance)
tv.model # runs just fine (but nothing in the method definition, nothing happens)

Television.manufacturer # runs the class method (and nothing happens)
# Television.model # NoMethodError (calling an instance method on the class)

### Question 6

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    @age += 1 # could be rewritten as `self.age += 1`
  end
end

### Question 7

class Light
  attr_accessor :brightness, :color # these aren't being used, but could be interpolated into returned string for self.information
# however, they could be used to alter the brightness and color outside the class definition
  def initialize(brightness, color) # these instance variables aren't being used either
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green" # the `return` is also not doing anything here
  end

end

