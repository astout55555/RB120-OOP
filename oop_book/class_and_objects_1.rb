class GoodDog
  def initialize(name) # `initialize` is an instance method, runs when class is instantiated
    @name = name # `@name` is an instance variable, tied to the object
  end

  def name # each instance method has access to the instance variables, so e.g:
    @name # since all this does is retrieve the @name instance variable, this is
  end # called a "getter method"

  def name=(n) # this is a "setter method", which reassigns an instance variable
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new('Sparky') # pass 'Sparky' to #new class method, which passes it to instance method #initialize

# if I create another instance of GoodDog, it could be given a different name.
# each instance has separate objects (strings) assigned to their respective instance variables.

puts sparky.speak

puts sparky.name

sparky.name = "Spartacus" # syntactical sugar for `name=('Spartacus')`, method `#name=`
# setter methods always return value passed in as an argument, ignore any attempt to return something else.

puts sparky.name


### refactoring to use `attr_accessor :name` to include the getter and setter methods

class GoodDog
  attr_accessor :name # takes a symbol as argument, creates getter and setter methods for it

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.name            # => "Sparky"
sparky.name = "Spartacus"
puts sparky.name            # => "Spartacus"

# can use `attr_reader` to only create the getter method, not the setter
# can use `attr_writer` to only create the setter method without the getter

# use this syntax to set up getter and setter methods for multiple states at once:
# `attr_accessor :name, :height, :weight`

# once a getter (or setter) method is created for a certain state (instance variable),
# you can call it within other methods rather than referencing the instance variable directly, like so:

# def speak
#   "#{name} says arf!" # instead of "#{@name}..."
# end

# this is preferred in case you need to format or make some change to the state within the getter or setter method itself

### updated full class definition to allow changing and use of multiple states

class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{name} says arf!" # using `name` is okay for the getter method, but...
  end

  def change_info(n, h, w)
    self.name = n # here we use `self.name =` instead of `name =` because otherwise
    self.height = h # Ruby would think we're trying to initialize new local variables.
    self.weight = w # this is required to use setter methods properly.
  end

  def info # could also use `self.info` here, but unnecessary and clunky
    "#{name} weighs #{weight} and is #{height} tall."
  end
end

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
puts sparky.info      # => Sparky weighs 10 lbs and is 12 inches tall.

sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info      # => Spartacus weighs 45 lbs and is 24 inches tall.


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

  def show_car_info
    puts "This car is a #{color} #{year} #{model}."
    puts "The current speed of the car is: #{speed}."
  end
end

roger = MyCar.new(1999, 'red', 'Mystique')

roger.show_car_info
roger.speed_up(25)
roger.speed_up(47)
puts roger.speed
roger.brake(33)
puts roger.speed
roger.speed_up(21)
roger.shut_off
puts roger.speed

roger.color = 'dusty red'
puts roger.year

roger.show_car_info

def spray_paint(object, new_color)
  object.color = new_color
end

spray_paint(roger, 'black')

roger.show_car_info
