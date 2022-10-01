# to store display methods which would otherwise clog up the TTTGame class
module Displayable
  def joinor(array, separator_string = ', ', final_separator = 'or')
    if array.size > 2
      final_element = array.pop
      mostly_joined = array.join(separator_string)
      "#{mostly_joined}#{separator_string}#{final_separator} #{final_element}"
    else
      array.join(" #{final_separator} ")
    end
  end

  def list_valid_moves
    valid_moves = board.unmarked_keys
    joinor(valid_moves)
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ''
  end

  def pause_prompt
    puts "Hit enter to continue."
    gets
  end

  def display_scores
    scores = <<~SCORES
      #{human.name} has: #{human.score} points.
      #{computer.name} has: #{computer.score} points.
    SCORES

    puts scores
  end

  def display_result
    clear_screen_and_display_board

    if human_won?
      puts "You won!"
    elsif computer_won?
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def clear
    system "clear"
  end

  def display_board
    puts "You're a #{human.marker}. #{computer.name} is a #{computer.marker}."
    puts ''
    board.draw
    puts ''
  end

  def display_end_of_match_message
    puts(
      if human.score >= 5
        victory_message
      else
        loss_message
      end
    )
  end

  def victory_message
    <<~MSG
      --------------
      (to the crowd) #{human.name} has achieved victory!!
      *wild applause*
      (to you) Hey, nice job out there. You made me proud.
    MSG
  end

  def loss_message
    <<~MSG
      --------------
      (to the crowd) #{human.name} has been defeated!
      *loud gasp*
      #{computer.name} is the champion!
      *boos, hissing*
      (to you) Better luck next time! I'm rootin' for ya!
    MSG
  end

  def display_play_again_message
    puts "Okay, let's play again! I'll set you up with a new computer opponent."
    puts ''
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end
end

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  attr_reader :squares

  def initialize
    @squares = {}
    reset
  end

  def []=(key, marker)
    squares[key].marker = marker
  end

  def unmarked_keys
    squares.keys.select { |key| squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      line_squares = squares.values_at(*line)
      if three_identical_markers?(line_squares)
        return line_squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |num| squares[num] = Square.new(num) }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{squares[1]}  |  #{squares[2]}  |  #{squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{squares[4]}  |  #{squares[5]}  |  #{squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{squares[7]}  |  #{squares[8]}  |  #{squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def two_in_a_row?(line_squares)
    markers = line_squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 2
    markers.min == markers.max
  end

  private

  def three_identical_markers?(line_squares)
    markers = line_squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  attr_reader :position

  def initialize(position, marker=INITIAL_MARKER)
    @position = position
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_accessor :score
  attr_reader :name, :marker

  def initialize(human_marker=nil)
    @score = 0
    set_name
    choose_marker(human_marker)
  end
end

class Human < Player
  def picking_first?
    answer = nil
    loop do
      puts "Do you want to pick who goes first? (y/n)"
      answer = gets.chomp.strip.downcase
      break if %w(y yes n no).include?(answer)
      puts "I didn't understand you. Please enter 'y' or 'n'."
    end

    answer == 'y' || answer == 'yes'
  end

  def choose_first_to_move
    to_go_first = nil
    loop do
      puts "Okay, choose who goes first. Human (h) or computer (c)."
      to_go_first = gets.chomp.strip.downcase
      break if %w(human h computer c).include?(to_go_first)
      puts "Umm, what? Please just say 'human' or 'computer'--or 'h' or 'c'."
    end
    to_go_first
  end

  private

  def set_name
    answer = nil
    loop do
      puts "What's your name, stranger?"
      answer = gets.chomp.strip
      break if answer != ''
      puts "Sorry, I didn't catch that. You have a name, right?"
    end
    @name = answer
  end

  def choose_marker(marker_input)
    loop do
      puts "What would you like to use as your marker? Enter any character."
      marker_input = gets.chomp.strip
      break if marker_input.length == 1
      puts "Sorry, choose a single character (and not an empty space)."
    end
    @marker = marker_input
  end
end

class Computer < Player
  COMPUTER_NAMES = [
    ['R1', 'R2', 'R3', 'R4'],
    ['D4', 'D6', 'D8', 'D12', 'D20']
  ]

  DIFFICULTY_RATINGS = {
    'easy' => 1,
    'medium' => 2,
    'hard' => 3,
    'demonic' => 4
  }

  attr_reader :difficulty

  def difficulty=(difficulty_label)
    @difficulty = DIFFICULTY_RATINGS[difficulty_label]
  end

  def choose_first_to_move
    if difficulty > 2
      'computer'
    elsif difficulty == 2
      ['h', 'c'].sample
    else
      'human'
    end
  end

  private

  def set_name
    @name = COMPUTER_NAMES[0].sample + COMPUTER_NAMES[1].sample
  end

  def choose_marker(human_marker)
    @marker = if %(o O 0).include?(human_marker)
                'X'
              else
                'O'
              end
  end
end

## Orchestration Engine

class TTTGame
  def initialize
    clear
    display_welcome_message
    @board = Board.new
    @human = Human.new
    @computer = Computer.new(human.marker)
    determine_difficulty
    @first_to_move = determine_first_to_move
    @current_marker = @first_to_move
  end

  def play
    pause_prompt
    clear
    loop do
      main_game
      break unless play_again?
      game_reset
    end
    display_goodbye_message
  end

  private

  include Displayable

  attr_reader :board, :human, :computer

  def determine_difficulty
    loop do
      puts "Do you want to pick the difficulty? (y/n)"
      answer = gets.chomp.strip.downcase
      ask_for_difficulty if answer == 'y' || answer == 'yes'
      randomly_set_difficulty if answer == 'n' || answer == 'no'
      break if %w(y yes n no).include?(answer)
      puts "Sorry, I didn't understand you."
    end
  end

  def ask_for_difficulty
    answer = nil
    loop do
      puts "How tough do you want your opponent to be?"
      puts "Choose: #{joinor(Computer::DIFFICULTY_RATINGS.keys)}"
      answer = gets.chomp.downcase
      break if Computer::DIFFICULTY_RATINGS.keys.include?(answer)
      puts "Sorry, please choose one of the listed difficulty options."
    end

    computer.difficulty = answer
  end

  def randomly_set_difficulty
    puts "You don't want to pick? Hmm."
    choice = Computer::DIFFICULTY_RATINGS.keys.sample
    computer.difficulty = choice
    puts "Okay, I'll just set it to...#{choice}, why not?"
  end

  def determine_first_to_move
    to_go_first = if human.picking_first?
                    human.choose_first_to_move
                  else
                    puts "I guess we'll let the computer pick instead."
                    computer.choose_first_to_move
                  end
    return human.marker if to_go_first == 'h' || to_go_first == 'human'
    computer.marker
  end

  def main_game
    loop do
      display_board
      players_take_turns
      resolve_round
      break if match_over?
    end

    display_end_of_match_message
  end

  def players_take_turns
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def human_turn?
    @current_marker == human.marker
  end

  def human_moves
    puts "Choose a square: #{list_valid_moves}"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    move = computer_decides_move

    board[move] = computer.marker
  end

  def computer_decides_move(tactics_available=computer.difficulty)
    tactics_available.downto(1) do |tactics|
      move = case tactics
             when 4 then find_final_square_position(mode: 'offense')
             when 3 then find_final_square_position(mode: 'defense')
             when 2 then (5 if board.squares[5].unmarked?)
             when 1 then board.unmarked_keys.sample
             end

      return move unless move.nil?
    end
  end

  def find_final_square_position(mode: 'defense')
    Board::WINNING_LINES.each do |line|
      line_squares = board.squares.values_at(*line)
      next unless board.two_in_a_row?(line_squares)
      marked_squares = line_squares.select(&:marked?)
      final_sq = line_squares.select(&:unmarked?).first

      return final_sq.position if correct_move_for_mode?(mode, marked_squares)
    end

    nil
  end

  def correct_move_for_mode?(mode, marked_squares)
    if mode == 'offense'
      marked_squares.first.marker == computer.marker
    elsif mode == 'defense'
      marked_squares.first.marker == human.marker
    end
  end

  def resolve_round
    display_result
    award_point
    display_scores
    return if match_over?
    pause_prompt
    round_reset
  end

  def human_won?
    board.winning_marker == human.marker
  end

  def computer_won?
    board.winning_marker == computer.marker
  end

  def award_point
    human.score += 1 if human_won?
    computer.score += 1 if computer_won?
  end

  def match_over?
    human.score >= 5 || computer.score >= 5
  end

  def round_reset
    board.reset
    @current_marker = @first_to_move
    clear
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n yes no).include? answer
      puts "Sorry, must be 'y' or 'n'."
    end

    answer == 'y' || answer == 'yes'
  end

  def game_reset
    clear
    display_play_again_message
    human.score = 0
    @computer = Computer.new(human.marker)
    determine_difficulty
    @first_to_move = determine_first_to_move
    pause_prompt
    round_reset
  end
end

## Code to execute

game = TTTGame.new
game.play
