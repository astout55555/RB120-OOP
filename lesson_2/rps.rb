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
    self.name = CURRENT_GAME.remaining_computers.sample
  end

  def r2d2_choose
    self.move = if move_history.empty? || rand(10) < 7
                  'scissors'
                else
                  'paper'
                end
  end

  def hal_choose
    self.move = if ['rock', 'scissors'].include?(CURRENT_GAME.human.move.value)
                  'spock'
                else
                  ['scissors', 'scissors', 'lizard'].sample
                end
  end

  def chappie_choose
    self.move = 'rock'
  end

  def sonny_choose
    self.move = ['scissors', 'spock'].sample
  end

  def number_5_choose
    self.move = ['paper', 'lizard'].sample

    return unless ((move_history.size + 1) % 5) == 0

    until move > CURRENT_GAME.human.move
      self.move = Move::VALUES.sample
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
  attr_reader :value

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
  attr_accessor :human, :computer, :remaining_computers

  POINTS_TO_WIN = 5

  def initialize
    @human = Human.new
    @remaining_computers = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5']
    display_welcome_message
  end

  def display_welcome_message
    puts "Thank goodness you're here, #{human.name}. It's a disaster!"
    puts "E-topia has been overrun #{remaining_computers.size} evil AIs!"
    puts "You must fight them using Rock, Paper, Scissors, Lizard, Spock!"
    puts "First to #{RPSGame::POINTS_TO_WIN} points wins the match. Hurry!"
  end

  def display_goodbye_message
    if full_game_won?
      puts "Holy cow, #{human.name}, you defeated every computer!"
      puts "You saved E-topia! You're welcome back anytime, hero :)"
    else
      puts "Thanks for playing RPSLS!"
      puts "Come back when you're ready to take on the computer menace!"
    end
  end

  def display_moves
    puts '------------'
    puts "#{human.name} chose: #{human.move}"
    puts "#{computer.name} chose: #{computer.move}"
  end

  def dislpay_move_history
    puts "#{human.name}'s move history: #{human.move_history}"
    puts "#{computer.name}'s move history: #{computer.move_history}"
  end

  def human_won_round?
    human.move > computer.move
  end

  def human_won_match?
    human.score >= RPSGame::POINTS_TO_WIN
  end

  def computer_won_round?
    human.move < computer.move
  end

  def computer_won_match?
    computer.score >= RPSGame::POINTS_TO_WIN
  end

  def display_winner
    if human_won_round?
      puts "#{human.name} won!"
    elsif computer_won_round?
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_score
    puts "You have #{human.score} points."
    puts "#{computer.name} has #{computer.score} points."
  end

  def display_end_of_match_message
    if human_won_match?
      puts "Huzzah! You defeated #{computer.name}!"
    elsif computer_won_match?
      puts "Oh no, #{human.name} has been crushed by #{computer.name}!"
    end
  end

  def display_end_of_round_details
    display_moves
    dislpay_move_history
    display_winner
  end

  def resolve_round
    display_end_of_round_details
    human.score += 1 if human_won_round?
    computer.score += 1 if computer_won_round?
    display_score
    display_end_of_match_message if match_over?
  end

  def match_over?
    human_won_match? || computer_won_match?
  end

  def full_game_won?
    remaining_computers.empty?
  end

  def play_again?
    answer = nil
    loop do
      puts "Are you willing to continue the fight? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'yes', 'n', 'no'].include?(answer)
      puts "Sorry, must by 'y' or 'n'."
    end

    return true if answer == 'y' || answer == 'yes'
    false
  end

  def set_up_game
    human.score = 0
    human.move_history = []
    self.computer = Computer.new
    declare_opponent
  end

  def declare_opponent
    puts "Your opponent is the #{Computer::INTRO_ADJ.sample} #{computer.name}!"
  end

  def players_throw
    human.choose
    human.move_history << human.move.value
    computer.choose
    computer.move_history << computer.move.value
  end

  def execute_round
    players_throw
    resolve_round
    remaining_computers.delete(computer.name) if human_won_match?
  end

  def play
    loop do
      set_up_game
      loop do
        execute_round
        break if match_over?
      end
      break if full_game_won? || !play_again?
    end
    display_goodbye_message
  end
end

## Game Code Execution

CURRENT_GAME = RPSGame.new
CURRENT_GAME.play
