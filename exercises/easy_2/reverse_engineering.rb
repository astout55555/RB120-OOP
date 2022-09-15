## My class definition:

class Transform
  def initialize(string)
    @string = string
  end

  def self.lowercase(string_to_lower)
    string_to_lower.downcase
  end

  def uppercase
    @string.upcase
  end
end

## Test case:

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')

## Expected output:

# ABC
# xyz
