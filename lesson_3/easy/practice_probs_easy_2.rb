### Question 1

class Oracle
  def predict_the_future
    "You will " + choices.sample # #choices is implicitly called by the object that called #predict_the_future
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new
puts oracle.predict_the_future # outputs concatenated string with random prediction

### Question 2

class RoadTrip < Oracle
  def choices # overwrites inherited instance method
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

trip = RoadTrip.new
puts trip.predict_the_future # concatenated string output with new list of random choices

### Question 3

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

puts Orange.ancestors # lookup chain => Orange => Taste => Object => Kernel => BasicObject
puts HotSauce.ancestors # lookup chain => HotSauce => Taste => Object => Kernel => BasicObject

### Question 4

class BeesWax
  attr_accessor :type # added line

  def initialize(type)
    @type = type
  end

  # def type # 2 methods removed while maintaining same functionality
  #   @type
  # end

  # def type=(t)
  #   @type = t
  # end

  def describe_type
    puts "I am a #{type} of Bees Wax" # `@` removed, preferable to direct reference
  end
end

### Question 5

# excited_dog = "excited dog" # local variable
# @excited_dog = "excited dog" # instance variable
# @@excited_dog = "excited dog" # class variable

### Question 6

class Television
  def self.manufacturer # class method, defined with `self.` before method name
    # method logic
  end

  def model
    # method logic
  end
end

# Television.manufacturer # how you would call the class method

### Question 7

class Cat
  @@cats_count = 0 # class variable

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1 # increments class variable `@@cats_count` by one every time a Cat object is initialized
  end

  def self.cats_count # class method to refer to the class variable
    @@cats_count
  end
end

cat1 = Cat.new('calico')
cat2 = Cat.new('tomcat')

puts Cat.cats_count # => 2

### Question 8

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game # added `< Game` to allow inheritence of #play instance method
  def rules_of_play
    #rules of play
  end
end

silver = Bingo.new
puts silver.play

### Question 9

class Bingo < Game
  def rules_of_play
    #rules of play
  end

  def play
    #overwrites Game.play
    "Whoops!"
  end
end

puts silver.play

### Question 10: Benefits of using Object Oriented Programming in Ruby?

# 1. Allows custom classes and objects which can reflect a higher level of abstraction,
# more closely modeling/reflecting the real world problem. Easier to think about.

# 2. Allows better method access control, hiding various methods and variables unless
# specifically needed by other parts of the program. Helps avoid bugs in larger programs,
# and better for security purposes too.

# 3. Inheritance and modules allow for reusing chunks of code without rewriting,
# but lower level classes can still overwrite methods for more specific implementation.
# This also allows for polymorphism, so that code can be written without having to consider
# how it would be specifically implemented by the various objects involved.

## LS Answer:



# Because there are so many benefits to using OOP we will just summarize some of the major ones:

  # Creating objects allows programmers to think more abstractly about the code they are writing.
  # Objects are represented by nouns so are easier to conceptualize.
  # It allows us to only expose functionality to the parts of code that need it, meaning namespace issues are much harder to come across.
  # It allows us to easily give functionality to different parts of an application without duplication.
  # We can build applications faster as we can reuse pre-written code.
  # As the software becomes more complex this complexity can be more easily managed.
