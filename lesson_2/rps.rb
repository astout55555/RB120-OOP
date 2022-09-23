## Classes/methods based on organized nouns/verbs

class Player
  attr_accessor :name, :score, :move_history
  attr_reader :move

  def initialize
    set_name
    @score = 0
    @move_history = []
  end

  def move=(choice)
    case choice
    when 'rock' then @move = Rock.new
    when 'paper' then @move = Paper.new
    when 'scissors' then @move = Scissors.new
    when 'lizard' then @move = Lizard.new
    when 'spock' then @move = Spock.new
    else puts "Error! Invalid choice passed into Player#move=() as an argument."
    end

    @move_history << choice
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard, or Spock:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice)
      puts 'Sorry, invalid choice.'
    end

    self.move = choice
  end
end

class Computer < Player
  INTRO_ADJ = ['illustrious', 'relentless', 'merciless', 'devious', 'squeaky']
  
  def set_name
    self.name = RPSGame.remaining_computers.sample
  end

  def r2d2_choose
    if move_history.size < 3 || rand(10) < 7
      self.move = 'scissors'
    elsif rand(10) == 7
      self.move = 'spock'
    else
      self.move = 'paper'
    end
  end

  def hal_choose
    self.move = Move::VALUES.sample
  end

  def chappie_choose
    self.move = ['spock', 'lizard'].sample
  end

  def sonny_choose
    self.move = 'rock'
  end

  def number_5_choose
    if ((move_history.size + 1) % 5) == 0
      self.move = 'paper'
    else
      self.move = 'scissors'
    end
  end

  def choose
    case name
    when 'R2D2' then r2d2_choose
    when 'Hal' then hal_choose
    when 'Chappie' then chappie_choose
    when 'Sonny' then sonny_choose
    when 'Number 5' then number_5_choose
    else puts "Error! Somehow computer did not get a valid name."
    end
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def to_s
    @value
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
  end

  def <(other_move)
    other_move.paper? || other_move.spock?
  end

  def >(other_move)
    other_move.scissors? || other_move.lizard?
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
  end

  def <(other_move)
    other_move.scissors? || other_move.lizard?
  end

  def >(other_move)
    other_move.spock? || other_move.rock?
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
  end

  def <(other_move)
    other_move.rock? || other_move.spock?
  end

  def >(other_move)
    other_move.paper? || other_move.lizard?
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
  end

  def <(other_move)
    other_move.scissors? || other_move.rock?
  end

  def >(other_move)
    other_move.paper? || other_move.spock?
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
  end

  def <(other_move)
    other_move.paper? || other_move.lizard?
  end

  def >(other_move)
    other_move.scissors? || other_move.rock?
  end
end

## Game Orchestration Engine

class RPSGame
  attr_accessor :human, :computer

  @@remaining_computers = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5']

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def self.remaining_computers
    @@remaining_computers
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
    puts "Get ready, #{human.name}. First to 10 points wins the match!"
  end

  def display_goodbye_message
    puts 'Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Goodbye!'
  end

  def display_moves
    puts '------------'
    puts "#{human.name} chose: #{human.move}"
    puts "#{computer.name} chose: #{computer.move}"

    puts "#{human.name}'s move history: #{human.move_history}"
    puts "#{computer.name}'s move history: #{computer.move_history}"
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
      human.score += 1
    elsif human.move < computer.move
      puts "#{computer.name} won!"
      computer.score += 1
    else
      puts "It's a tie!"
    end
  end

  def match_over?
    (human.score >= 10) || (computer.score >= 10)
  end

  def display_score
    puts "You have #{human.score} points."
    puts "#{computer.name} has #{computer.score} points."

    if human.score >= 10
      puts "#{human.name} triumphs over #{computer.name}!"
      @@remaining_computers.delete("#{computer.name}")
    elsif computer.score >= 10
      puts "Oh no, #{human.name} has been vanquished by #{computer.name}!"
    end
  end

  def play_again?
    if @@remaining_computers.empty?
      puts "Holy cow, #{human.name}, you defeated every computer!"
      return false
    end

    answer = nil
    loop do
      puts "Are you prepared to face another challenger? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'yes', 'n', 'no'].include?(answer)
      puts "Sorry, must by 'y' or 'n'."
    end

    return true if answer == 'y' || answer == 'yes'
    false
  end

  def reset_game
    human.score = 0
    human.move_history = []
    computer.score = 0
    computer.move_history = []
    computer.set_name
  end

  def declare_opponent
    puts "Your opponent is the #{Computer::INTRO_ADJ.sample} #{computer.name}!"
  end

  def play
    display_welcome_message
    loop do
      declare_opponent
      loop do
        human.choose
        computer.choose
        display_moves
        display_winner
        display_score
        break if match_over?
      end
      break unless play_again?
      reset_game
    end
    display_goodbye_message
  end
end

## Game Code Execution

RPSGame.new.play
