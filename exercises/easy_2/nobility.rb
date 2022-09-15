# one solution below, isolated from the other classes from previous exercise

# module Walkable
#   def walk
#     puts "#{name} #{self.gait} forward"
#   end
# end

# class Noble
#   include Walkable

#   attr_reader :name, :title

#   def initialize(name, title)
#     @name = name
#     @title = title
#   end

#   def gait
#     'struts'
#   end

#   def walk
#     @temp = name
#     @name = "#{title} #{name}"
#     super
#     @name = @temp
#   end
# end

# byron = Noble.new("Byron", "Lord")
# byron.walk
# # => "Lord Byron struts forward"

# puts byron.name
# # => "Byron"
# puts byron.title
# # => "Lord"

## Further Exploration: solve exercise #10 with inheritance and remove duplicate methods

class Animal
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  def to_s
    "#{name}"
  end

  def walk
    puts "#{self} #{self.gait} forward"
  end
end

class Person < Animal
  private

  def gait
    "strolls"
  end
end

class Cat < Animal
  private

  def gait
    "saunters"
  end
end

class Cheetah < Cat
  private

  def gait
    "runs"
  end
end

class Noble < Person
  attr_reader :title

  def initialize(name, title)
    super(name)
    @title = title
  end

  def to_s
    "#{title} #{name}"
  end

  private

  def gait
    'struts'
  end
end

## Test cases:

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"

byron = Noble.new("Byron", "Lord")
byron.walk
# => "Lord Byron struts forward"

puts byron.name
# => "Byron"
puts byron.title
# => "Lord"
