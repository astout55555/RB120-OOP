### Use previous Card class, and build a Deck class that can:
# use a #draw method to deal one card
# shuffle itself when initialized
# reset when it runs out of its 52 cards

class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.fetch(rank, rank) # 2nd arg is the default value if rank not found in VALUES keys
  end

  def <=>(other_card) # with Comparable module, this automatically creates a usable #== method
    value <=> other_card.value
  end
end

## Deck class:

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

### Test cases:

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
