class Studier
  attr_reader :mantra

  def initialize
    @mantra = "I am someone who studies."
  end
end

class Student < Studier
  def initialize(name, year)
    super()
    @name = name
    @year = year
  end
end

class Graduate < Student # line 1
  def initialize(name, year, parking)
    super(name, year) # line 3
    @parking = parking # line 4
  end
end

class Undergraduate < Student # line 2
  # def initialize(name, year) # or remove entire method, not needed
  #   super # line 5
  # end
end

class SelfTaughtPerson < Studier
  def study_without_school
    puts "I don't have to be a student to study."
  end
end

james = SelfTaughtPerson.new
james.study_without_school
puts james.mantra

george = Student.new('George', 2022)
puts george.mantra
