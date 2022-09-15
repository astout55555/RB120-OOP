## Refactor the following classes so they all use a common superclass, and inherit behavior as needed:

# added superclass Vehicle definition:

class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s # these were all the same, moved into superclass
    "#{make} #{model}"
  end

  def wheels # this Vehicle#wheels method borrowed from a student answer
    0 # it makes polymorphism easier in case we're working with a generic Vehicle
  end # if we don't add a #wheels method into a subclass, the default is 0 wheels
end

class Car < Vehicle # added `< Vehicle` for inheritence
  def wheels
    4 # each of these numbers is different across the classes, keeping in subclasses
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :payload # moved reader for make, model from all to Vehicle, but kept :payload here

  def initialize(make, model, payload)
    super(make, model) # refactored code but kept original functionality of Vehicle#initialize
    @payload = payload # keeping this line for the new parameter
  end

  def wheels
    6
  end
end
