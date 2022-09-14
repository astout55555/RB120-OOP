# Nothing is technically wrong, but what should be changed to avoid potential future problems?

class Flight
  attr_accessor :database_handle # should remove this line so @database_handle is not used in code

  def initialize(flight_number)
    @database_handle = Database.init # we may decide to change this implementation detail and not use a database
    @flight_number = flight_number
  end
end
