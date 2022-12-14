## Given this code:

class House
  attr_reader :price

  def initialize(price)
    @price = price
  end

  # my new code:
  include Comparable

  def <=>(other_house)
    price <=> other_house.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

## get this output by defining only one new method in House:

# Home 1 is cheaper
# Home 2 is more expensive