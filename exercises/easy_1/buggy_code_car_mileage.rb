## Fix the following code:

class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    @mileage = total # changed `mileage` to `@mileage` to disambiguate from local variable initialization
    # `self.mileage = total` => even better option, doesn't bypass the setter method, in case that matters
  end

  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678
