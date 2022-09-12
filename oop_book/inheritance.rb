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
