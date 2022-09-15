## My classes and methods:

class Pet
  attr_reader :animal, :name
  # for FE, added shelter arg for initial location of pet
  def initialize(animal, name, shelter)
    @animal = animal
    @name = name
    shelter.unadopted_pets << self
  end

  def to_s
    "a #{animal} named #{name}"
  end
end

class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def number_of_pets
    pets.size
  end
end

class Shelter
  attr_reader :name, :owners, :unadopted_pets, :adopted_pets
  
  def initialize(name)
    @name = name
    @owners = []
    @unadopted_pets = []
    @adopted_pets = []
  end

  def adopt(owner, pet)
    owners << owner unless owners.include?(owner)
    if unadopted_pets.include?(pet)
      owner.pets << unadopted_pets.delete(pet)
      adopted_pets << pet
    end
  end

  def print_adoptions
    puts "#{name} has the following unadopted pets:"
    puts unadopted_pets
    puts ''

    owners.each do |owner|
      puts "#{owner.name} has adopted the following pets:"
      owner.pets.each do |pet|
        puts pet if adopted_pets.include?(pet)
      end
      puts ''
    end
  end
end

## Code to execute:

# FE: moved Shelter object instantiation to top and given name,
# since in reality shelters are built before pets are put in them
planet_pets = Shelter.new('Planet Pets')
lonely_fields = Shelter.new('Lonely Fields') 

# pets can be placed in different named shelters, which separately track adoptions
# a shelter is chosen when Pet object is created
butterscotch = Pet.new('cat', 'Butterscotch', planet_pets)
pudding      = Pet.new('cat', 'Pudding', planet_pets)
darwin       = Pet.new('bearded dragon', 'Darwin', planet_pets)
kennedy      = Pet.new('dog', 'Kennedy', planet_pets)
asta         = Pet.new('dog', 'Asta', planet_pets)
laddie       = Pet.new('dog', 'Laddie', planet_pets)
fluffy       = Pet.new('cat', 'Fluffy', planet_pets)
kat          = Pet.new('cat', 'Kat', planet_pets)
pepsi        = Pet.new('hamster', 'Pepsi', planet_pets) # hamsters were my own pets

sweetie      = Pet.new('parakeet', 'Sweetie Pie', lonely_fields)
molly        = Pet.new('dog', 'Molly', lonely_fields)
chester      = Pet.new('fish', 'Chester', lonely_fields)
ben          = Pet.new('cat', 'Ben', lonely_fields)
chatterbox   = Pet.new('parakeet', 'Chatterbox', lonely_fields)
bluebell     = Pet.new('parakeet', 'Bluebell', lonely_fields)
sprite       = Pet.new('hamster', 'Sprite', lonely_fields)

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

planet_pets.adopt(phanson, butterscotch)
planet_pets.adopt(phanson, pudding)
planet_pets.adopt(phanson, darwin)
planet_pets.adopt(bholmes, kennedy)
planet_pets.adopt(bholmes, pepsi)

lonely_fields.adopt(bholmes, sweetie)
lonely_fields.adopt(bholmes, molly)
lonely_fields.adopt(bholmes, chester)
lonely_fields.adopt(phanson, sprite)

# each shelter will only print its own unadopted/adopted pets
planet_pets.print_adoptions
puts '-----------------'
lonely_fields.print_adoptions

# but I can still track the total adopted pets by owner in this way:
puts '-----------------'
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

# and I can still get a list of an owner's pets this way:
puts '-----------------'
puts "#{phanson.name} has the following pets:"
puts phanson.pets

puts ''
puts "#{bholmes.name} has the following pets:"
puts bholmes.pets
