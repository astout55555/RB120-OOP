### Part 1 ###

## Complete this program so it produces the expected output:

class Book
  attr_reader :author, :title # added public reader methods for instance variables

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.) # no reader method available for @title or @author, so raises errors
puts %(book = #{book}.)

## Expected output:

# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

### Part 2 ###

## Complete this program so it produces the expected output:

class Book
  attr_accessor :author, :title # added public read/write methods for instance variables

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

## Expected output:

# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.
