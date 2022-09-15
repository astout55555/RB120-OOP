# Fix the following code so cars have access to the drive method

module Drivable
  def drive # removed `self.` before `drive` so it is an instance method instead
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive
