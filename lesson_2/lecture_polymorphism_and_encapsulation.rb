### On a final note, always keep in mind that the class should have as few public methods as possible.
### It lets us simplify using that class and protect data from undesired changes from the outer world.

### fleshed out code for example of polymorphism / duck typing:

class Wedding
  attr_reader :guests, :flowers, :songs

  def initialize
    @guests = ["Billy", "Jessica"]
    @flowers = ["lilies", "tulips"]
    @songs = ["Eye of the Tiger", "Africa"]
  end

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end

end

class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_food(guests)
    puts "Preparing food for #{guests[0]} and #{guests[1]}"
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_place(wedding.flowers)
  end

  def decorate_place(flowers)
    puts "Placing the #{flowers[0]} and #{flowers[1]} on the tables"
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end

  def prepare_performance(songs)
    puts "Qeueing up #{songs[0]} and #{songs[1]}"
  end
end

joe = Chef.new
bob = Decorator.new
linda = Musician.new
staff = [joe, bob, linda]
sean_and_dyani = Wedding.new
sean_and_dyani.prepare(staff)
