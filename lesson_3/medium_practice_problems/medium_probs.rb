### Question 1

class BankAccount
  attr_reader :balance # getter method is available at the object level

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0 # this is okay, does not need a `@` because there is no assignment
  end
end

# Ben is correct

### Question 2

# class InvoiceEntry
#   attr_reader :quantity, :product_name

#   def initialize(product_name, number_purchased)
#     @quantity = number_purchased
#     @product_name = product_name
#   end

#   def update_quantity(updated_count) # will fail when called
#     # prevent negative quantities from being set
#     quantity = updated_count if updated_count >= 0 # should be `@quantity` to refer to instance var
#   end
# end

# alternatively, could create an attr_writer for :quantity, and use `self.quantity = ...`
### Question 3 - anything wrong with this solution?

class InvoiceEntry
  attr_reader :product_name
  attr_accessor :quantity

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    self.quantity = updated_count if updated_count >= 0
  end
end

# this could allow setting the quantity in a way that bypasses the >= 0 safeguard

### Question 4

class Greeting
  def greet(string)
    puts string
  end
end

class Hello < Greeting
  def hi
    greet('Hello')
  end
end

class Goodbye < Greeting
  def bye
    greet('Goodbye')
  end
end

### Question 5

class KrispyKreme
  attr_reader :filling_type, :glazing # added getter methods

  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @filling_type = 'Plain' if filling_type == nil # added translation if filling is nil
    @glazing = glazing
  end

  # additional code to make puts statements work as expected below
  def to_s
    output = "#{filling_type}"
    output += " with #{glazing}" if glazing != nil
    output
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
  # => "Plain"

puts donut2
  # => "Vanilla"

puts donut3
  # => "Plain with sugar"

puts donut4
  # => "Plain with chocolate sprinkles"

puts donut5
  # => "Custard with icing"

## alternative solution from LS:

class KrispyKreme
  # ... keep existing code in place and add the below...
  def to_s
    filling_string = @filling_type ? @filling_type : "Plain" # makes use of nil's falsiness
    glazing_string = @glazing ? " with #{@glazing}" : '' # same here, very clever
    filling_string + glazing_string
  end
end

### Question 6

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231" # does not use the setter method above
  end

  def show_template
    template # uses the getter method above, with good syntax
  end
end

# compared with:

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231" # uses the setter method created above
  end

  def show_template
    self.template # uses the getter method created above, but with unnecessary `self.`
  end
end

### Question 7

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def light_status # change to `status` so it can be called like `.status` for clarity
    "I have a brightness level of #{brightness} and a color of #{color}"
  end

end
