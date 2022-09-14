# # Starting code:

# class Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name.to_s # calls Object#to_s because it is called by the passed in object/argument (a string)
#   end

#   def to_s
#     @name.upcase!
#     "My name is #{@name}."
#   end
# end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name # => 'Fluffy'
# # calls instance method #name on fluffy object, which simply returns the instance variable @name.
# # #puts calls Object#to_s (the default version) on this string object (assigned to @name)

# puts fluffy # => "My name is FLUFFY."
# # #puts calls fluffy#to_s on @name ('Fluffy'), which mutates it (#upcase!) and returns interpolated string

# puts fluffy.name # => "FLUFFY"
# # object referenced by @name has been mutated, so when referenced by #name getter,
# # and ouput by #puts, the string is still capitalized

# puts name # => 'FLUFFY'
# # prints out the object referenced by local variable `name`,
# # which is pointing to the same object as instance variable @name, still mutated

### Corrected Code

class Pet
  attr_reader :name

  def initialize(name)
    @name = name # removed the unnecessary and confusing call to Object#to_s
  end

  def to_s
    "My name is #{@name.upcase}." # removed the mutation
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name # => 'Fluffy'
puts fluffy # => 'My name is FLUFFY.'
puts fluffy.name # => 'Fluffy'
puts name # => 'Fluffy'

### Alternate Corrected Code

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.upcase # upcased here so @name references an uppercase version
  end

  def to_s
    "My name is #{@name}." # removed mutating method call here, but still prints uppercase
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name # => 'FLUFFY'
puts fluffy # => 'My name is FLUFFY.'
puts fluffy.name # => 'FLUFFY'
puts name # => 'Fluffy' (original string object unchanged)

### Further Exploration ###

# given this version of corrected code...

class  Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

# explain why the following code 'works':

name = 42 # local variable `name` initialized to Integer object `42`
fluffy = Pet.new(name) # local variable `fluffy` initialized to instance of Pet class
# @name instance variable initialized to String object '42' (converted by Object#to_s)
name += 1 # local variable `name` reassigned to Integer 43

puts fluffy.name # => '42' (prints value of @name, the String '42')

puts fluffy # => 'My name is 42.' (@name '42' is upcased, but no effect because of numeric string)

puts fluffy.name # => '42' (same as before)

puts name # => '43' (local variable `name` still pointing to Integer 43,
# but #puts implicitly calls Object#to_s (or Integer#to_s) and outputs String to console)
