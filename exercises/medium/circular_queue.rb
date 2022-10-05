### write the CircularQueue class...

# class CircularQueue
#   def initialize(buffer_size)
#     @buffer = Array.new(buffer_size)
#     @write_index = 0
#     @input_order = []
#   end

#   def enqueue(object)
#     if !(buffer[write_index] == nil)
#       to_be_overwritten = buffer[write_index]
#       index_for_deleting = @input_order.index(to_be_overwritten)
#       @input_order.delete_at(index_for_deleting)
#     end

#     buffer[write_index] = object
#     @input_order << object

#     if write_index == buffer.size - 1
#       @write_index = 0
#     else
#       @write_index += 1
#     end
#   end

#   def dequeue
#     return nil if @input_order.empty?

#     object_to_remove = @input_order.shift
#     index_in_buffer = buffer.index(object_to_remove)
#     buffer[index_in_buffer] = nil
#     object_to_remove
#   end

#   private

#   attr_reader :buffer, :write_index
# end

### ...such that the code below should output `true` 15 times

# queue = CircularQueue.new(3)
# puts queue.dequeue == nil

# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1

# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2

# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 5
# puts queue.dequeue == 6 
# puts queue.dequeue == 7
# puts queue.dequeue == nil

# queue = CircularQueue.new(4)
# puts queue.dequeue == nil

# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1

# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2

# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 4
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil

### LS Solution:

# class CircularQueue
#   def initialize(size)
#     @buffer = [nil] * size
#     @next_position = 0
#     @oldest_position = 0 # uses a 2nd pointer instead of a 2nd array
#   end

#   def enqueue(object)
#     unless @buffer[@next_position].nil? # increments the oldest_position pointer if the spot to be filled is occupied (since oldest object is being overwritten)
#       @oldest_position = increment(@next_position)
#     end

#     @buffer[@next_position] = object
#     @next_position = increment(@next_position)
#   end

#   def dequeue
#     value = @buffer[@oldest_position]
#     @buffer[@oldest_position] = nil
#     @oldest_position = increment(@oldest_position) unless value.nil?
#     value
#   end

#   private

#   def increment(position) # logic for incrementing is placed in separate private method here
#     (position + 1) % @buffer.size
#   end
# end

### FE: find a simpler solution that uses an Array, and the #push and #shift methods, without monkey-patching the Array class

class CircularQueue
  def initialize(size)
  end

  def enqueue(object)
  end

  def dequeue
  end
end

### test cases below again:

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6 
puts queue.dequeue == 7
puts queue.dequeue == nil
puts 'time for 4 spots'
queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
