## Update the following code...

class Pet
  def initialize(name, age, colors)
    @name = name
    @age = age
    @colors = colors # added third parameter and initialized another instance variable
  end

  private

  def name
    @name.capitalize
  end

  attr_reader :age, :colors
end

class Cat < Pet
  private
  
  def to_s
    "My cat #{name} is #{age} years old and has #{colors} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

## ...to get the correct output below:

# My cat Pudding is 7 years old and has black and white fur.
# My cat Butterscotch is 10 years old and has tan and white fur.
