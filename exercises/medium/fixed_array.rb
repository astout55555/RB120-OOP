### write the fixed-length array class:

class FixedArray < Array
  def initialize(limit)
    super()
    @limit = limit
    fill_with_nil
    remove_extra_elements
  end

  def fill_with_nil
    @limit.times { self.push(nil) }
  end

  def remove_extra_elements
    until self.size <= @limit
      self.pop
    end
  end

  def [](index)
    raise IndexError if index > self.size
    super
  end

  def []=(index, value)
    raise IndexError if index > self.size
    super
  end
end

### which can support the following code:

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil # => true
puts fixed_array.to_a == [nil] * 5 # => true

fixed_array[3] = 'a'
puts fixed_array[3] == 'a' # => true
puts fixed_array.to_a == [nil, nil, nil, 'a', nil] # => true

fixed_array[1] = 'b'
puts fixed_array[1] == 'b' # => true
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil] # => true

fixed_array[1] = 'c'
puts fixed_array[1] == 'c' # => true
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil] # => true

fixed_array[4] = 'd'
puts fixed_array[4] == 'd' # => true
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd'] # => true
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]' # => true

puts fixed_array[-1] == 'd' # => true
puts fixed_array[-4] == 'c' # => true

begin
  fixed_array[6] # this returns nil for a regular Array. I need to change the #[] method
  puts false
rescue IndexError # should trigger this error and output true, but outputting false
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true # I didn't mess up the #[] implementation, so this still triggers the error like normal
end

begin
  fixed_array[7] = 3 # this isn't triggering the IndexError because it's the Array element setter method
  puts false
rescue IndexError # I need to add a new implementation of #[]= which doesn't work above the limit
  puts true
end

# output should be `true` 16 times, but #14 and #16 were outputting `false` at first

### LS Solution below:

class FixedArray # it is generally considered bad form to inherit from standard classes
  def initialize(max_size)
    @array = Array.new(max_size) # instead, you should use a collaborator object
  end # this already creates an array with max_size elements, each nil
# however, we don't get access to Array methods (and don't have to be aware of or change them)
  def [](index)
    @array.fetch(index) # simply implement #[] as Array#fetch, which already exists 
  end

  def []=(index, value)
    self[index]             # raise error if index is invalid!
    @array[index] = value
  end

  def to_a # allows #to_a, but uses a clone so that the original cannot have # of elements changed
    @array.clone
  end

  def to_s
    to_a.to_s # calls #to_a first so it is a clone
  end
end
