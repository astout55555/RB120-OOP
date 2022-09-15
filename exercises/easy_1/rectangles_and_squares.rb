## Given

class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end

## write a class called Square which inherits from Rectangle...

# class Square < Rectangle 
#   def initialize(side_length)
#     @side_length = side_length
#   end

#   def area
#     side_length**2
#   end

#   private

#   attr_reader :side_length
# end

## ^^Oops--not what I'm supposed to do--I should make use of inherited behaviors!
## Trying again...

class Square < Rectangle
  def initialize(side_length)
    super(side_length, side_length) # passes input in as both args
  end
end # nothing else needed, it inherits #area instance method

## ...and is used like this

square = Square.new(5)
puts "area of square = #{square.area}"
