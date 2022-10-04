require 'pry-byebug'

module Displayable
  def clear
    system 'clear'
  end

  def display_opening_message
    opening_message = <<~OPENING
      ...The ground finally starts to level out. You're at the mountain top!
      You look up from your feet to see a folksy figure shrouded by sunlight.
      Squinting reveals an old man, grinning toothily.
      --------------------------
    OPENING

    puts opening_message
  end

  def display_welcome_message
    welcome_message = <<~WELCOME
      --------------------------
      Well, shucks, it's a pleasure to meet you, #{player.name}.
      Name's #{dealer.name}. This here's me card shack.
      Folks come from all around to play honest, old-fashioned Twenty-one.
    WELCOME

    puts welcome_message
  end

  def display_instructions
    response = nil
    loop do
      display_short_instructions
      puts "Clear enough? (y/n)"
      response = gets.chomp.strip.downcase
      break if %w(y yes n no).include?(response)
      puts "Quit yer mumblin' and answer me straight!"
    end

    display_full_instructions if %w(n no).include?(response)

    display_transition_to_gameplay_message
  end

  def display_short_instructions
    short_instructions = <<~SHORT
      It's like Blackjack without all the fancy splits and such.
      Just try to get as close to twenty-one as ye can without bustin'.
      ---------------------------
    SHORT

    puts short_instructions
    sleep 3
  end

  def display_full_instructions
    puts '---------------------'
    display_full_instructions_part_one
    puts '...'
    sleep 10
    puts "(The old man takes a comically large breath and continues.)"
    puts '...'
    sleep 2
    display_full_instructions_part_two
  end

  def display_full_instructions_part_one
    full_instructions_part_one = <<~FULL_ONE
      So yee's a tenderfoot, eh? Well the game's simple enough. We each start
      out with two cards, one face up, one face down. Then you take your turn.
      On your turn, you can either "hit" or "stay". If you "hit" that means you
      want another card, and I'll deal it to ya. If you "stay", that means you
      don't want any more cards, and then it's my turn. I'll do the same thing,
      'cept as I'm the dealer I'll always hit if my cards total up to less
      than seventeen, and I'll always stay if my total is seventeen or higher.
    FULL_ONE

    puts full_instructions_part_one
  end

  def display_full_instructions_part_two
    full_instructions_part_two = <<~FULL_TWO
      Name o' the game is Twenty-one cuz ya wanna git yer total as close to
      twenty-one as ya can, but no more! You go over and you "bust", and the
      best you can hope for then is a tie cuz I might just bust meself. But
      if nobody busts, then whoever had the higher total wins. Each card is
      worth what it says on the face, 'cept the face cards are each worth ten.
      Only special card is an Ace, cuz that's worth eleven, but drops down to
      only one if being a big eleven would bust ye. Nice to have one in hand.
    FULL_TWO

    puts full_instructions_part_two
    sleep 8
  end

  def display_transition_to_gameplay_message
    transition_message = <<~MSG
    ---------------------
    Alright, now have a seat and I'll deal out the cards.
    ---------------------
    MSG

    puts transition_message
    sleep 2
  end

  def display_known_info
    display_player_cards_and_total
    display_visible_dealer_cards
  end

  def display_player_cards_and_total
    puts "Your hand: #{player.list_all_cards}: a total of #{player.total}"
  end

  def display_visible_dealer_cards
    puts "Dealer's hand: #{dealer.list_visible_cards} and one face down card."
  end

  def display_end_of_round_message
    case determine_round_outcome
    when :both_bust
      puts "We both busted? What in tarnation...luck-o-the-draw, I s'pose."
    when :dealer_wins
      puts "YEEHAW, there's GOLD in them there cards! My gold, that is!"
    when :player_wins
      puts "Ah, shoot, looks like ye bested me. I'll get ye next time!"
    when :tie
      puts "Hoo-wee, same totals? Reckon' it's a tie. Let's try that agin."
    end
  end

  def display_goodbye_message
    goodbye_message = <<~GOODBYE
      --------------------------
      That was a hoot! Make the trek back anytime you get a hankerin'!
    GOODBYE

    puts goodbye_message
  end
end

class Participant
  attr_reader :name, :current_action

  attr_accessor :hand

  def initialize
    @hand = []
    @name = set_name
    @current_action = nil
  end

  def hit?
    current_action == 'hit' || current_action == 'h'
  end

  def stay?
    current_action == 'stay' || current_action == 's'
  end

  def busted?
    total > 21
  end

  def total
    temp_total = @hand.sum(&:numeric_value)
    aces_valued_at_eleven = @hand.count { |card| card.face_value == 'Ace' }
    until temp_total <= 21 || aces_valued_at_eleven == 0
      temp_total -= 10
      aces_valued_at_eleven -= 1
    end
    temp_total
  end

  def list_visible_cards
    visible_cards = hand.select(&:face_up?)
    visible_cards.map(&:to_s).join(', ')
  end

  def list_all_cards
    hand.map(&:to_s).join(', ')
  end
end

class Player < Participant
  def set_name
    response = nil
    loop do
      puts "What's yer name, partner?"
      response = gets.chomp.strip
      break unless response.nil?
      puts "WUSSAT!? HUH!? Speak up, friend!"
    end
    @name = response
  end

  def hits_or_stays
    answer = nil
    loop do
      puts "You wanna hit (h), or stay (s)?"
      answer = gets.chomp.strip.downcase
      break if %w(hit h stay s).include?(answer)
      puts "I'm not sure I know what you mean. Which was it?"
    end
    @current_action = answer
  end
end

class Dealer < Participant
  FOLKSY_DESCRIPTORS = ['Wild Eye', "Ramblin'", 'Ill-starred', 'Bush Beard']
  OLD_TIMEY_NAMES = ['Willie', 'Jebediah', 'Dedrick', 'Chatfield']

  def set_name
    @name = "#{FOLKSY_DESCRIPTORS.sample} #{OLD_TIMEY_NAMES.sample}"
  end

  def hits_or_stays
    @current_action = if total < 17
                        'hit'
                      elsif total >= 17
                        'stay'
                      end
  end
end

class Deck
  FACE_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

  SUITS = ['Spades', 'Clubs', 'Hearts', 'Diamonds']

  attr_accessor :cards

  def initialize
    @cards = []
    build_deck
    shuffle!
  end

  def deal(recipient, flip_card: true)
    card = cards.shift
    card.flip! if flip_card
    recipient.hand << card
  end

  def shuffle!
    cards.shuffle!
  end

  private

  def build_deck
    FACE_VALUES.each do |face_value|
      SUITS.each do |suit|
        card = Card.new(face_value, suit, visibility: 'face down')
        cards << card
      end
    end
  end
end

class Card
  NUMERIC_VALUES = {
    2 => 2, 3 => 3, 4 => 4, 5 => 5,
    6 => 6, 7 => 7, 8 => 8, 9 => 9,
    10 => 10, 'Jack' => 10, 'Queen' => 10, 'King' => 10,
    'Ace' => 11
  }

  attr_reader :face_value, :suit, :numeric_value

  def initialize(face_value, suit, visibility: 'face down')
    @face_value = face_value
    @suit = suit
    @visibility = visibility
    @numeric_value = NUMERIC_VALUES[face_value]
  end

  def flip!
    @visibility = if @visibility == 'face up'
                    'face down'
                  elsif @visibility == 'face down'
                    'face up'
                  end
  end

  def face_up?
    @visibility == 'face up'
  end

  def face_down?
    @visibility == 'face down'
  end

  def to_s
    "#{face_value} of #{suit}"
  end
end

### Orchestration Engine

class Game
  attr_reader :player, :dealer, :deck

  def initialize
    clear
    display_opening_message
    sleep 3
    @player = Player.new
    @dealer = Dealer.new
    display_welcome_message
    display_instructions
    @deck = Deck.new
  end

  def start
    loop do
      play_round
      break unless play_again?
      reset_game
    end
    display_goodbye_message
  end

  private

  include Displayable

  def play_round
    deal_starting_hands!
    display_known_info
    player_turn
    dealer_turn unless player.busted?
    resolve_round
  end

  def deal_starting_hands!
    deck.deal(player, flip_card: false)
    deck.deal(dealer, flip_card: false)
    deck.deal(player)
    deck.deal(dealer)
  end

  def player_turn
    loop do
      player.hits_or_stays
      deck.deal(player) if player.hit?

      break if player.stay? || player.busted?

      display_known_info
    end
  end

  def dealer_turn
    puts "Dealer's turn!"

    loop do
      dealer.hits_or_stays
      if dealer.hit?
        puts "Dealer hits!"
        deck.deal(dealer)
        display_visible_dealer_cards
      end

      break if dealer.busted? || dealer.stay?
    end
  end

  def resolve_round
    reveal_hidden_dealer_card_and_total
    display_end_of_round_message
  end

  def reveal_hidden_dealer_card_and_total
    last_dealer_card = dealer.hand.select(&:face_down?).first
    last_dealer_card.flip!
    puts "The dealer's face down card was: #{last_dealer_card}!"
    puts "Dealer's total was: #{dealer.total}!"
    display_end_of_round_message
  end

  def determine_round_outcome
    if double_bust?
      :both_busted
    elsif player.busted? || (player.total < dealer.total)
      :dealer_wins # why is it displaying the ending message twice?
    elsif dealer.busted? || (dealer.total < player.total)
      :player_wins
    else
      :tie
    end
  end

  def double_bust?
    player.busted? && dealer.busted?
  end

  def play_again?
    response = nil
    loop do
      puts "Would you like to play again? (y/n)"
      response = gets.chomp.strip.downcase
      break if %w(yes y no n).include?(response)
      puts "I'm not sure what yer sayin'...let's try that again."
    end
    response == 'yes' || response == 'y'
  end

  def reset_game
    @deck = Deck.new
    player.hand = []
    dealer.hand = []
  end
end

### Code to execute

Game.new.start
