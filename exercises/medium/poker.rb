### Include Card and Deck classes from the last two exercises:

## Using my own version of Card class so I have public access to rank values

class Card
  attr_reader :rank, :suit, :rank_value

  def initialize(rank, suit)
    @rank = rank
    @rank_value = determine_rank_value 
    @suit = suit
  end

  def ==(other_card)
    rank == other_card.rank
  end

  private

  def <=>(other_card)
    if rank_value < other_card.rank_value
      -1
    elsif rank_value == other_card.rank_value
      0
    elsif rank_value > other_card.rank_value
      1
    end
  end

  def determine_rank_value
    if @rank.is_a?(Integer)
      @rank
    else
      case @rank
      when 'Jack' then 11
      when 'Queen' then 12
      when 'King' then 13
      when 'Ace' then 14
      end
    end
  end

  def to_s
    "#{@rank} of #{suit}"
  end
end

## not using LS version of Card class:

# class Card
#   include Comparable
#   attr_reader :rank, :suit

#   VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

#   def initialize(rank, suit)
#     @rank = rank
#     @suit = suit
#   end

#   def to_s
#     "#{rank} of #{suit}"
#   end

#   def value
#     VALUES.fetch(rank, rank)
#   end

#   def <=>(other_card)
#     value <=> other_card.value
#   end
# end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @cards = []
    build_deck
  end

  def draw
    card = @cards.shift
    build_deck if @cards.empty?
    card
  end

  private

  def build_deck
    RANKS.each do |rank|
      SUITS.each do |suit|
        @cards << Card.new(rank, suit)
      end
    end
    @cards.shuffle!
  end
end

### Create new class PokerHand which:
# takes 5 cards from the deck
# evaluates them as a poker hand

class PokerHand
  def initialize(deck)
    @hand = []
    draw_hand(deck)
  end

  def print
    puts @hand
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def draw_hand(deck)
    5.times { @hand << deck.draw }
  end

  def royal_flush?
    straight_flush? && @hand.min_by(&:rank_value).rank == 10
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    ranks = @hand.map(&:rank)
    ranks.each do |card_rank|
      count = ranks.count(card_rank)
      return true if count == 4
    end
    false
  end

  def full_house?
    three_of_a_kind? && pair?
  end

  def flush?
    suits = @hand.map(&:suit).sort
    suits.min == suits.max
  end

  def straight?
    ranks = @hand.map(&:rank_value).sort
    (ranks.uniq.size == 5) && (ranks.max - ranks.min == 4)
  end

  def three_of_a_kind?
    ranks = @hand.map(&:rank)
    ranks.each do |card_rank|
      count = ranks.count(card_rank)
      return true if count == 3
    end
    false
  end

  def two_pair?
    ranks = @hand.map(&:rank)
    pair? && ranks.uniq.size == 3
  end

  def pair?
    ranks = @hand.map(&:rank)
    ranks.each do |card_rank|
      count = ranks.count(card_rank)
      return true if count == 2
    end
    false
  end
end

### Test cases:

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

### Danger danger danger: monkey patching for testing purposes. ###
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'

### Expected output:

## first, 5 different cards:
# 5 of Clubs
# 7 of Diamonds
# Ace of Hearts
# 7 of Clubs
# 5 of Spades

## then, results of tests:
# Two pair
# true
# true
# true
# true
# true
# true
# true
# true
# true
# true
# true
# true
# true
