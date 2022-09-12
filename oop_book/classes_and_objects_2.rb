class GoodDog
  DOG_YEARS = 7 # constant definition. could just capitalize first letter, but best practice to use all caps.

  attr_accessor :name, :age

  @@number_of_dogs = 0 # initialize the class variable `@@number_of_dogs` to 0 (@@ for class variable)

  def initialize(n, a) # the instance method `initialize` is specifically what gets called when the class is instantiated.
    self.name = n # e.g., if this instance method was named `test_name`, then an error would be raised
    self.age = a * DOG_YEARS # because #new would not be expecting any arguments anymore!
    @@number_of_dogs += 1 # (we can access the class variable from within an instance method)
  end

  def self.total_number_of_dogs # getter class method included to use get class variable above
    @@number_of_dogs
  end

  def speak
    "#{@name} says arf!" # (@ for instance variable)
  end
end

fido = GoodDog.new('Fido', 3)
puts fido.name
puts fido.age

sparky = GoodDog.new('Sparky', 4)
puts sparky.name
puts sparky.age

puts GoodDog.total_number_of_dogs # => 2

### Note: the #to_s method is automatically called on the object when we use #puts or when used with string interpolation
# the result of calling #to_s on an object is the object name and object ID returned in a string

### Note: use `self` when calling setter methods from within the class definition, or for class method definitions
# if called within an instance method, `self` references the calling object, i.e.:
# `self.name=` called from inside an instance method works as if calling e.g. `sparky.name=` from outside the class.
# when `self` is called from within the class itself, then it references the class, i.e.:
# `self.total_number_of_dogs`, a class method being defined in the class, works like `GoodDog.total_number_of_dogs` being called from outside the class.

### Exercises ###

class MyCar
  attr_accessor :color
  attr_reader :year, :model, :speed

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
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

  def to_s
    "This car is a #{color} #{year} #{model}, with a current speed of: #{speed}."
  end
end

MyCar.gas_milage(10, 300)

damien = MyCar.new(2012, 'silver', 'Fit')
puts damien

roger = MyCar.new(1999, 'red', 'Mystique')
puts roger
