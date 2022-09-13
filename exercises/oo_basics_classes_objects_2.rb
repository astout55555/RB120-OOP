### Problems 1-7

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end

  def self.total
    puts @@total_cats
  end

  @@total_cats = 0

  attr_accessor :name

  COLOR = 'purple'

  def initialize(name)
    @name = name
    @@total_cats += 1
  end

  def rename(new_name)
    @name = new_name
  end

  def identify
    self
  end

  def personal_greeting
    puts "Hi, my name is #{name}!"
  end

  def greet
    puts "Hello! My name is #{name} and I'm a #{COLOR} cat!"
  end

  def to_s
    "I'm #{name}!"
  end
end

## Problem 1 test cases

# Cat.generic_greeting
# kitty = Cat.new
# kitty.class.generic_greeting

## Problem 2 test cases:

kitty = Cat.new('Sophie')
puts kitty.name
kitty.rename('Chloe')
puts kitty.name

## Problem 3 test case:

p kitty.identify

## Problem 4 test cases:

Cat.generic_greeting
kitty.personal_greeting

## Problem 5 test case:

kitty2 = Cat.new('Clifford')
Cat.total

## Problem 6 test case:

kitty.greet

## Problem 7 test case:

puts kitty

### End of problems 1-7

### Problem 8

class Person
  attr_accessor :secret
  
  def initialize # turns out you don't need to initialize the instance variable here,
    @secret = '' # merely creating the getter/setter methods above is enough.
  end
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
puts person1.secret

### Problem 9

class Person
  attr_writer :secret

  def share_secret
    puts secret
  end

  private

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
person1.share_secret

### Problem 10

class Person
  attr_writer :secret

  def compare_secret(other_person)
    self.secret == other_person.secret
  end

  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)
