## Complete code to get expected output:

class Person
  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
  end

  # added in two custom instace var writers to capitalize as names are changed
  def first_name=(first_name)
    @first_name = first_name.capitalize
  end

  def last_name=(last_name)
    @last_name = last_name.capitalize
  end
  # end of added methods

  def to_s
    "#{@first_name} #{@last_name}"
  end
end

person = Person.new('john', 'doe')
puts person

person.first_name = 'jane'
person.last_name = 'smith'
# `person = Person.new('jane', 'smith')` could replace above 2 lines, but let's fix the class definition instead
puts person

## Expected output:

# John Doe
# Jane Smith
