class Animal
  def speak # instance method defined in Animal class
    "Hello!"
  end
end

class GoodDog < Animal # GoodDog subclass defined under Animal superclass
  def speak # instance method `#speak` overwrites `#speak` from Animal 
    super + " from GoodDog class" # keyword `super` calls `#speak` method from Animal superclass
  end
end

sparky = GoodDog.new
sparky.speak        # => "Hello! from GoodDog class" # concatenated output

## A more common example of the use of `super` is for `initialize`:

class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super # invokes the Animal class' instance method `initialize` and passes it the argument from this `initialize` instance method
    @color = color
  end
end

class BadDog < Animal
  def initialize(age, name)
    super(name) # can be called with a specific argument from the ones available
    @age = age
  end
end

bruno = GoodDog.new("brown") # => #<GoodDog:0x007fb40b1e6718 @color="brown", @name="brown">
BadDog.new(2, "bear")        # => #<BadDog:0x007fb40b2beb68 @age=2, @name="bear">

## calling `super` must be done with empty parentheses if you want to ignore available arguments

class Animal
  def initialize
  end
end

class Bear < Animal
  def initialize(color)
    super() # this way it passes 0 arguments to the method in the superclass, avoiding an error
    @color = color
  end
end

bear = Bear.new("black")        # => #<Bear:0x007fb40b1e6718 @color="black">

# You may wonder when to use class inheritance vs mixins. Here are a couple of things to consider when evaluating these choices.

#     You can only subclass (class inheritance) from one class. You can mix in as many modules (interface inheritance) as you'd like.
#     If there's an "is-a" relationship, class inheritance is usually the correct choice. If there's a "has-a" relationship, interface inheritance is generally a better choice. For example, a dog "is an" animal and it "has an" ability to swim.
#     You cannot instantiate modules (i.e., no object can be created from a module). Modules are used only for namespacing and grouping common methods together.

### the "method lookup path"
# --the order in which classes are inspected when you call a method.
# see the following example:

module Walkable # common practice to name modules with "-able" based on the type of behavior they represent
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end

class GoodDog < Animal
  include Swimmable
  include Climbable
end

puts "---GoodDog method lookup---"
puts GoodDog.ancestors

# outputs as below:
# ---GoodDog method lookup---
# GoodDog
# Climbable # note: last module added is looked at first, and can overwrite previous module of same name
# Swimmable
# Animal
# Walkable # note: also includes the module from the superclass Animal
# Object
# Kernel
# BasicObject

### Example of module being used for namespacing--organizing similar classes under a module:

module Mammal
  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end

  class Cat
    def say_name(name)
      p "#{name}"
    end
  end
end

buddy = Mammal::Dog.new # use double colons `::` to call class from witin a module
kitty = Mammal::Cat.new
buddy.speak('Arf!')           # => "Arf!"
kitty.say_name('kitty')       # => "kitty"

### Public, Private, Protected methods:

class Person
  def initialize(age) # default method access control is set to `public`
    @age = age
  end

  def older?(other_person)
    age > other_person.age
  end

  protected # sets code below to `protected` until changed again to `public` or `private`

  attr_reader :age
end

malory = Person.new(64)
sterling = Person.new(42)

malory.older?(sterling)  # => true # because age is not private, we can compare between two objects of the same class
sterling.older?(malory)  # => false

# malory.age # raises error--because age is not public, we cannot call it from outside the class
  # => NoMethodError: protected method `age' called for #<Person: @age=64>

### Exercises ###

# 1, 2, 3

module Flying_spinnable
  def can_execute_flying_spin_attack?
    true
  end
end

class Vehicle
  attr_accessor :color
  attr_reader :year, :model, :speed

  @@number_of_vehicles = 0

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
    @@number_of_vehicles += 1
  end

  def speed_up(acceleration)
    @speed += acceleration
  end

  def brake(deceleration)
    @speed -= deceleration
  end

  def shut_off
    @speed = 0
  end

  def self.gas_milage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def self.number_of_vehicles
    puts "There are now a total of #{@@number_of_vehicles} vehicles spawned by this program."
  end

  def age
    "This #{model} is #{find_age} years old."
  end

  private

  def find_age
    Time.now.year - year
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

  def to_s
    "This car is a #{color} #{year} #{model}, with a current speed of: #{speed}."
  end
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2 # you can use the same constant name across two different classes without overwriting

  include Flying_spinnable

  def to_s
    "This truck is a #{color} #{year} #{model}, with a current speed of: #{speed}."
  end
end

damien = MyCar.new(2012, 'silver', 'Honda Fit')
puts damien

hot_daniel = MyTruck.new(2030, 'cherry red', 'Apple iDrive')
puts hot_daniel

Vehicle.number_of_vehicles

puts hot_daniel.can_execute_flying_spin_attack?

# 4

puts "~~~method lookup for MyCar~~~"
puts MyCar.ancestors

puts "~~~method lookup for MyTruck~~~"
puts MyTruck.ancestors

puts "~~~method lookup for Vehicle~~~"
puts Vehicle.ancestors

# 5

damien.speed_up(40)
damien.speed
damien.brake(8)
puts damien

hot_daniel.speed_up(20)
puts hot_daniel
hot_daniel.shut_off
puts hot_daniel.speed

# 6

puts damien.age
puts hot_daniel.age

# These next 2 lines (correctly) raise errors, since Vehicle#find_age is a private method.
# puts damien.find_age
# puts hot_daniel.find_age

# 7

class Student
  attr_accessor :name

  def initialize(n, g)
    @name = n
    @grade = g
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  attr_accessor :grade
end

goku = Student.new('Goku', 14)
trunks = Student.new('Trunks', 75)

puts goku.better_grade_than?(trunks)

# The following raise errors (correctly), due to @grade reader being a protected method.
# goku.grade
# trunks.grade
