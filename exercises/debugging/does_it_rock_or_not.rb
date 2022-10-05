class AuthenticationError < Exception; end

# A mock search engine
# that returns a random number instead of an actual count.
class SearchEngine
  def self.count(query, api_key)
    unless valid?(api_key) # I thought this might be a problem, but inside a class method definition any methods called without another explicit caller are called on the class, even without an explicit `self.` 
      raise AuthenticationError, 'API key is not valid.' # this message never triggers because of the rescue below
    end
    
    rand(200_000)
  end

  private

  def self.valid?(key)
    key == 'LS1A'
  end
end

module DoesItRock
  API_KEY = 'LS1A'

  class NoScore; end

  class Score
    def self.for_term(term)
      positive = SearchEngine.count(%{"#{term} rocks"}, API_KEY).to_f
      negative = SearchEngine.count(%{"#{term} is not fun"}, API_KEY).to_f

      score = positive / (positive + negative)
    # rescue Exception # this was set to rescue ALL Exceptions, including subclasses like AuthenticationError. so instead of getting the message above, it rescues and returns NoScore
      # NoScore
    end
  end

  def self.find_out(term)
    score = Score.for_term(term) # score was always assigned to NoScore because of the rescue above

    case score
    when NoScore # this never triggered because although `score == NoScore`, it is not true that `score === NoScore`, which is what #case uses (Object#===)
      "No idea about #{term}..." # essentially, score.is_a?(NoScore) returns false because score is not an instance of the NoScore class, it is the NoScore class!
    when 0...0.5
      "#{term} is not fun."
    when 0.5
      "#{term} seems to be ok..."
    else # when error is raised, we get this instead
      "#{term} rocks!"
    end
  rescue Exception => e
    e.message
  end
end

# Example (your output may differ)

puts DoesItRock.find_out('Sushi')       # Sushi seems to be ok...
puts DoesItRock.find_out('Rain')        # Rain is not fun.
puts DoesItRock.find_out('Bug hunting') # Bug hunting rocks!

### LS Solution below, with enhancements from a student:

class AuthenticationError < StandardError; end # changed to inherit from StandardError instead of the Exception superclass

# A fake search engine
# code omitted

module DoesItRock
  API_KEY = 'wrong key'

  class NoScore; end

  class Score
    def self.for_term(term)
      positive = SearchEngine.count(%{"#{term} rocks"}, API_KEY).to_f
      negative = SearchEngine.count(%{"#{term} is not fun"}, API_KEY).to_f

      score = positive / (positive + negative) # modified by student to assign value to local variable

      raise ZeroDivisionError unless valid?(score) # added to raise the error even though 0.0 / 0.0 returns NaN

      score # added to return the value stored

    rescue ZeroDivisionError # changed to specifically rescue the ZeroDivisionError triggered by 0 / 0
      NoScore.new # changed to be an instance of the NoScore class, which will allow proper === comparison below
    end

    # private method added below by student
    private
    
    def self.valid?(score)
      !score.nan?
    end
  end

  def self.find_out(term)
    score = Score.for_term(term)

    case score
    when NoScore
      "No idea about #{term}..."
    when 0...0.5
      "#{term} is not fun."
    when 0.5
      "#{term} seems to be ok..."
    else
      "#{term} rocks!"
    end
  rescue StandardError => e # changed to reference StandardError instead of the Exception superclass
    e.message
  end
end

### Additional helpful reminder/notes regarding function of Object#===

# case statements compare the object passed in to the various options, with the passed in object on the right-hand of the === comparison
# i.e. , case score above compares like this: `NoScore === score`, `0...0.5 === score`, to see if score is a member of the group or class (or simply equal)

class Person
end
# => nil

bob = Person.new
# => #<Person:0x00007fa07683f4c8>

bob === Person
# => false

Person === bob # basically, same as bob.is_a?(Person)
# => true
