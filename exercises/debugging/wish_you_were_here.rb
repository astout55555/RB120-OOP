class Person
  attr_reader :name
  attr_accessor :location

  def initialize(name)
    @name = name
  end

  def teleport_to(latitude, longitude)
    @location = GeoLocation.new(latitude, longitude)
  end
end

class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end

  # adding an implementation of #== to fix the problem
  def ==(other_location)
    self.to_s == other_location.to_s
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(-33.89, 151.277)

puts ada.location                   # (-33.89, 151.277)
puts grace.location                 # (-33.89, 151.277)
puts ada.location == grace.location # expected: true
                                    # actual: false
# this outputs false because the @location instance variable for each person points to a GeoLocation object, for which there is no specific implementation of #==,
# so it uses BasicObject#==, which only returns true if they are the same object. because these are different objects, the equality comparison says they are not the same.
# in order to be read as equal, there needs to be an implementation of #== for the class which returns true if the to_s outputs are equal (which would be compared based on the String#== implementation)

# alternate solution from LS is to implement this version of #==

# def ==(other)
#   latitude == other.latitude && longitude == other.longitude
# end
# this has the advantage of comparing based on actual values of instance variables, preventing a sort of false positive you might get when comparing it to a string literal rather than an actual GeoLocation object
