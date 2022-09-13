### Practice Problems 1, 2

# class Person
#   attr_reader :name, :first_name, :last_name

#   def initialize(name)
#     @name = name
#     @first_name = name.split(' ').first
    
#     if name.split(' ')[1]
#       @last_name = name.split(' ').last
#     else
#       @last_name = ''
#     end
#   end

#   def last_name=(last_name)
#     @last_name = last_name
#     @name = first_name + ' ' + last_name
#   end
# end

### 1 Test Cases

# bob = Person.new('bob')
# bob.name                  # => 'bob'
# bob.name = 'Robert' # raises error after modifications in problem 2
# bob.name                  # => 'Robert'

### 2 Test Cases

# bob = Person.new('Robert')
# bob.name                  # => 'Robert'
# bob.first_name            # => 'Robert'
# bob.last_name             # => ''
# bob.last_name = 'Smith'
# bob.name                  # => 'Robert Smith'

### Alternate Solution for Problem 2 from LS:

# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(full_name)
#     parts = full_name.split
#     @first_name = parts.first
#     @last_name = parts.size > 1 ? parts.last : ''
#   end

#   def name
#     "#{first_name} #{last_name}".strip
#   end

#   ### modifying for problem 3, creating a smart name= setter method
#   def name=(first_or_full_name)
#     parts = first_or_full_name.split

#     if parts.size > 1
#       @first_name = parts.first
#       @last_name = parts.last
#     else
#       @first_name = parts.first
#     end
#   end
# end

### 3 Test Cases

# bob = Person.new('Robert')
# bob.name                  # => 'Robert'
# bob.first_name            # => 'Robert'
# bob.last_name             # => ''
# bob.last_name = 'Smith'
# bob.name                  # => 'Robert Smith'

# bob.name = "John Adams"
# puts bob.first_name            # => 'John'
# puts bob.last_name             # => 'Adams'

### Problem 4

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  # inserted instance method for problem # 4
  def same_name_as?(other_person)
    self.name == other_person.name
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

# Solutions/Test Cases for problem 4
puts bob.name == rob.name # => true
puts bob.object_id == rob.object_id # => false
puts bob.same_name_as?(rob) # => true
