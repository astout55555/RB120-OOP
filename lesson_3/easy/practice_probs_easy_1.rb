### Question 1

true.class # boolean object, TrueClass
'hello'.class # String object/class
[1, 2, 3, 'happy days'].class # Array object/class
142.class # Integer object/class

### Question 2

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed # include the module

  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed # include the module

  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

# test/demonstrate that they can go fast
damien = Car.new
damien.go_fast

hot_daniel = Truck.new
hot_daniel.go_fast

### Question 3

# This is done by interpolating `self.class` into the output string.
# Calls #class on the calling object, returning its class (then converted to a String.)

damien.class.class # => `Class` -- if we don't convert to string, the output is a `Class`

### Question 4

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

charles = AngryCat.new # creating a new instance of the class

### Question 5

class Fruit
  def initialize(name)
    name = name # not an instance variable, no `@` syntax
  end
end

class Pizza
  def initialize(name)
    @name = name # `@name` is the instance variable, initialized to `name` argument
  end
end

p Fruit.new('banana') # prints a class object with no instance variables
p Pizza.new('pepperoni') # prints a class object with an @name instance variable

hot_pizza = Pizza.new("cheese")
orange    = Fruit.new("apple")

p hot_pizza.instance_variables # => [:@name]
p orange.instance_variables # => []

### Question 6

class Cube
  attr_reader :volume # added to access instance variable

  def initialize(volume)
    @volume = volume
  end
end

rubix = Cube.new(20)
p rubix.volume
p rubix.instance_variable_get("@volume") # can also retrieve instance var without attr_reader

### Question 7

# default return value of #to_s called on object is
#   the object's Class, ObjectID, and instace vars names/values
puts rubix # #puts calls #to_s implicitly
# can also go to documentation for #to_s for the type of object, or for Object#to_s

### Question 8

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1 # `self` here refers to the calling Cat object making use of the instance method
  end
end

### Question 9

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count # `self` here refers to the class `Cat`, which can call the class method Cat#cats_count
    @@cats_count
  end
end

### Question 10

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

my_purse = Bag.new('red', 'silk') # pass in 2 arguments to create new instance
