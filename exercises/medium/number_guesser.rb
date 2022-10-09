=begin

Summary: In the number guessing game, a player tries to guess what the secret number is within a certain range.
  The player has a limited number of guesses. Each time the player guesses, the game will inform the player whether
  the guess was too low or too high with respect to the secret number, and how many guesses they have left.
  If the guess is correct, the player wins. If the player runs out of guesses, the player loses.

Nouns: guessed number, secret number, game, player, guesses left
Verb: guess, win, lose, inform

game
  secret number
  -inform player of result
  player (collab object)
    guesses left
    guessed number
    -win
    -lose

=end

### My original solution:

# class Player
#   attr_reader :guesses_remaining, :current_guess

#   def initialize
#     @guesses_remaining = 7
#     @current_guess = nil
#   end

#   def guess_number
#     guess = nil
#     loop do
#       print "Enter a number between 1 and 100: "
#       guess = gets.chomp.to_i
#       break if (1..100).include?(guess)
#       print "Invalid guess. "
#     end
#     @current_guess = guess
#     @guesses_remaining -= 1
#   end
# end

# class GuessingGame
#   def play
#     @player = Player.new
#     @secret_number = rand(100) + 1
#     loop do
#       display_guesses_remaining
#       @player.guess_number
#       break if player_won? || player_lost?
#       give_hint
#     end
#     display_ending_message
#   end

#   private

#   def display_guesses_remaining
#     puts "You have #{@player.guesses_remaining} guesses remaining."
#   end

#   def player_won?
#     @player.current_guess == @secret_number
#   end

#   def player_lost?
#     !player_won? && @player.guesses_remaining == 0
#   end    

#   def give_hint
#     if @player.current_guess > @secret_number
#       puts "Your guess is too high."
#     elsif @player.current_guess < @secret_number
#       puts "Your guess is too low."
#     end
#     puts ''
#   end

#   def display_ending_message
#     if player_lost?
#       puts "You have no more guesses. You lost!"
#     elsif player_won?
#       puts "That's the number!"
#       puts ''
#       puts "You won!"
#     end
#   end
# end

### Example output for game:
# game = GuessingGame.new
# game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That's the number!

# You won!

## Another example round:
# game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low.

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high.

# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have 1 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have no more guesses. You lost!

### LS Solution:

# class GuessingGame
#   MAX_GUESSES = 7
#   RANGE = 1..100

#   RESULT_OF_GUESS_MESSAGE = {
#     high:  "Your number is too high.",
#     low:   "Your number is too low.",
#     match: "That's the number!"
#   }.freeze

#   WIN_OR_LOSE = {
#     high:  :lose,
#     low:   :lose,
#     match: :win
#   }.freeze

#   RESULT_OF_GAME_MESSAGE = {
#     win:  "You won!",
#     lose: "You have no more guesses. You lost!"
#   }.freeze

#   def initialize
#     @secret_number = nil
#   end

#   def play
#     reset
#     game_result = play_game
#     display_game_end_message(game_result)
#   end

#   private

#   def reset
#     @secret_number = rand(RANGE)
#   end

#   def play_game
#     result = nil
#     MAX_GUESSES.downto(1) do |remaining_guesses|
#       display_guesses_remaining(remaining_guesses)
#       result = check_guess(obtain_one_guess)
#       puts RESULT_OF_GUESS_MESSAGE[result]
#       break if result == :match
#     end
#     WIN_OR_LOSE[result]
#   end

#   def display_guesses_remaining(remaining)
#     puts
#     if remaining == 1
#       puts 'You have 1 guess remaining.'
#     else
#       puts "You have #{remaining} guesses remaining."
#     end
#   end

#   def obtain_one_guess
#     loop do
#       print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
#       guess = gets.chomp.to_i
#       return guess if RANGE.cover?(guess)
#       print "Invalid guess. "
#     end
#   end

#   def check_guess(guess_value)
#     return :match if guess_value == @secret_number
#     return :low if guess_value < @secret_number
#     :high
#   end

#   def display_game_end_message(result)
#     puts "", RESULT_OF_GAME_MESSAGE[result]
#   end
# end

### Part 2: Modify game so it can take a custom range and always provide enough guesses to win

## Building off previous LS Solution seems easiest:

class GuessingGame
  RESULT_OF_GUESS_MESSAGE = {
    high:  "Your number is too high.",
    low:   "Your number is too low.",
    match: "That's the number!"
  }.freeze

  WIN_OR_LOSE = {
    high:  :lose,
    low:   :lose,
    match: :win
  }.freeze

  RESULT_OF_GAME_MESSAGE = {
    win:  "You won!",
    lose: "You have no more guesses. You lost!"
  }.freeze

  def initialize(lower_bound, upper_bound)
    @range = (lower_bound..upper_bound)
    @max_guesses = Math.log2(@range.size).to_i + 1
    @secret_number = nil
  end

  def play
    reset
    game_result = play_game
    display_game_end_message(game_result)
  end

  private

  def reset
    @secret_number = rand(@range)
  end

  def play_game
    result = nil
    @max_guesses.downto(1) do |remaining_guesses|
      display_guesses_remaining(remaining_guesses)
      result = check_guess(obtain_one_guess)
      puts RESULT_OF_GUESS_MESSAGE[result]
      break if result == :match
    end
    WIN_OR_LOSE[result]
  end

  def display_guesses_remaining(remaining)
    puts
    if remaining == 1
      puts 'You have 1 guess remaining.'
    else
      puts "You have #{remaining} guesses remaining."
    end
  end

  def obtain_one_guess
    loop do
      print "Enter a number between #{@range.first} and #{@range.last}: "
      guess = gets.chomp.to_i
      return guess if @range.cover?(guess)
      print "Invalid guess. "
    end
  end

  def check_guess(guess_value)
    return :match if guess_value == @secret_number
    return :low if guess_value < @secret_number
    :high
  end

  def display_game_end_message(result)
    puts "", RESULT_OF_GAME_MESSAGE[result]
  end
end

## Play examples for round 2:

game = GuessingGame.new(501, 1500)
game.play

# You have 10 guesses remaining.
# Enter a number between 501 and 1500: 104
# Invalid guess. Enter a number between 501 and 1500: 1000
# Your guess is too low.

# You have 9 guesses remaining.
# Enter a number between 501 and 1500: 1250
# Your guess is too low.

# You have 8 guesses remaining.
# Enter a number between 501 and 1500: 1375
# Your guess is too high.

# You have 7 guesses remaining.
# Enter a number between 501 and 1500: 80
# Invalid guess. Enter a number between 501 and 1500: 1312
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 501 and 1500: 1343
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 501 and 1500: 1359
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 501 and 1500: 1351
# Your guess is too high.

# You have 3 guesses remaining.
# Enter a number between 501 and 1500: 1355
# That's the number!

# You won!

game.play
# You have 10 guesses remaining.
# Enter a number between 501 and 1500: 1000
# Your guess is too high.

# You have 9 guesses remaining.
# Enter a number between 501 and 1500: 750
# Your guess is too low.

# You have 8 guesses remaining.
# Enter a number between 501 and 1500: 875
# Your guess is too high.

# You have 7 guesses remaining.
# Enter a number between 501 and 1500: 812
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 501 and 1500: 843
# Your guess is too high.

# You have 5 guesses remaining.
# Enter a number between 501 and 1500: 820
# Your guess is too low.

# You have 4 guesses remaining.
# Enter a number between 501 and 1500: 830
# Your guess is too low.

# You have 3 guesses remaining.
# Enter a number between 501 and 1500: 835
# Your guess is too low.

# You have 2 guesses remaining.
# Enter a number between 501 and 1500: 836
# Your guess is too low.

# You have 1 guesses remaining.
# Enter a number between 501 and 1500: 837
# Your guess is too low.

# You have no more guesses. You lost!
