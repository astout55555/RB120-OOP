# Exercise 1

-- How do we create an object in Ruby? Give an example of the creation of an object.

You can create an object in Ruby by calling #new on a class of object.

`Hash.new` e.g. creates a new hash object.

If we first define a new class, then we can instantiate that class by creating an "instance" of it (a new object of that type). E.g.:

```ruby
class GoodDog # use CamelCase for class names
end

spot = GoodDog.new
```

# Exercise 2

-- What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.

A module allows us to group reusable code in one place, to extend the functionality of a class. Modules can be included in ("mixed into") a class, which will allow that class to share all those same methods as if it had inherited them from another class or if they'd been included in the class definition.

E.g.:

```ruby
module Priority # defines the module
  def prioritize(rank) # the module contains a method definition
    if rank > 1
      rank - 1
    end
  end
end

class FirstClass
  include Priority # includes the module in the class definition
end

money_bags = FirstClass.new # instantiates the new class

rank = money_bags.prioritize(2) # calls the method on the class instance/object

vip_status = true if rank == 1 # initializes a variable to test if method worked

puts vip_status # prints `true`

```

Modules can also be used as a "namespace", to better organize code. They can include other classes, e.g.:

```ruby
module Careers
  class Engineer
  end

  class Teacher
  end
end

first_job = Careers::Teacher.new
```
