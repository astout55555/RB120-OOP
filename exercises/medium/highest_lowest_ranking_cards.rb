### Modify Card class so it can be used to determine lowest and highest ranked card objects in an array (by value, 2 low, Ace high)
## Also add a Card#to_s method to return string representation of the card

# class Card
#   attr_reader :rank

#   def initialize(rank, suit)
#     @rank = rank
#     @rank_value = determine_rank_value 
#     @suit = suit
#   end

#   def ==(other_card)
#     rank == other_card.rank
#   end

#   protected

#   attr_reader :rank_value

#   private

#   attr_reader :suit

#   def <=>(other_card)
#     if rank_value < other_card.rank_value
#       -1
#     elsif rank_value == other_card.rank_value
#       0
#     elsif rank_value > other_card.rank_value
#       1
#     end
#   end

#   def determine_rank_value
#     if @rank.is_a?(Integer)
#       @rank
#     else
#       case @rank
#       when 'Jack' then 11
#       when 'Queen' then 12
#       when 'King' then 13
#       when 'Ace' then 14
#       end
#     end
#   end

#   def to_s
#     "#{@rank} of #{suit}"
#   end
# end

## Test cases:

# cards = [Card.new(2, 'Hearts'),
#   Card.new(10, 'Diamonds'),
#   Card.new('Ace', 'Clubs')]
# puts cards
# puts cards.min == Card.new(2, 'Hearts')
# puts cards.max == Card.new('Ace', 'Clubs')

# cards = [Card.new(5, 'Hearts')]
# puts cards.min == Card.new(5, 'Hearts')
# puts cards.max == Card.new(5, 'Hearts')

# cards = [Card.new(4, 'Hearts'),
#   Card.new(4, 'Diamonds'),
#   Card.new(10, 'Clubs')]
# puts cards.min.rank == 4
# puts cards.max == Card.new(10, 'Clubs')

# cards = [Card.new(7, 'Diamonds'),
#   Card.new('Jack', 'Diamonds'),
#   Card.new('Jack', 'Spades')]
# puts cards.min == Card.new(7, 'Diamonds')
# puts cards.max.rank == 'Jack'

# cards = [Card.new(8, 'Diamonds'),
#   Card.new(8, 'Clubs'),
#   Card.new(8, 'Spades')]
# puts cards.min.rank == 8
# puts cards.max.rank == 8

## Expected output:

# 2 of Hearts
# 10 of Diamonds
# Ace of Clubs
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

### LS Solution: uses Comparable module

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
#     VALUES.fetch(rank, rank) # 2nd arg is the default value if rank not found in VALUES keys
#   end

#   def <=>(other_card) # with Comparable module, this automatically creates a usable #== method
#     value <=> other_card.value
#   end
# end

### FE: update Card class to account for suit rankings (low to high: Diamonds, Clubs, Hearts, Spades)

# class Card
#   RANK_VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

#   attr_reader :rank, :suit

#   def initialize(rank, suit)
#     @rank = rank
#     @suit = suit
#   end

#   def ==(other_card)
#     rank == other_card.rank &&
#       suit == other_card.suit
#   end

#   protected

#   def rank_value
#     RANK_VALUES.fetch(rank, rank) # 2nd arg is the default value if rank not found in VALUES keys
#   end

#   def suit_value
#     case suit
#     when 'Diamonds' then 1
#     when 'Clubs' then 2
#     when 'Hearts' then 3
#     when 'Spades' then 4
#     end
#   end

#   private

#   def <=>(other_card)
#     if rank_value < other_card.rank_value
#       -1
#     elsif rank_value == other_card.rank_value
#       suit_value <=> other_card.suit_value
#     elsif rank_value > other_card.rank_value
#       1
#     end
#   end

#   def to_s
#     "#{rank} of #{suit}"
#   end
# end

# ### Test cases:

# cards = [Card.new(2, 'Hearts'),
#   Card.new(10, 'Diamonds'),
#   Card.new('Ace', 'Clubs')]
# puts cards
# puts cards.min == Card.new(2, 'Hearts')
# puts cards.max == Card.new('Ace', 'Clubs')

# cards = [Card.new(5, 'Hearts')]
# puts cards.min == Card.new(5, 'Hearts')
# puts cards.max == Card.new(5, 'Hearts')

# cards = [Card.new(4, 'Hearts'),
#   Card.new(4, 'Diamonds'),
#   Card.new(10, 'Clubs')]
# puts cards.min.rank == 4
# puts cards.max == Card.new(10, 'Clubs')

# cards = [Card.new(7, 'Diamonds'),
#   Card.new('Jack', 'Diamonds'),
#   Card.new('Jack', 'Spades')]
# puts cards.min == Card.new(7, 'Diamonds')
# puts cards.max.rank == 'Jack'

# # Everything above still works, and:

# cards = [Card.new(8, 'Diamonds'),
#   Card.new(8, 'Clubs'),
#   Card.new(8, 'Spades')]
# puts cards.min.suit == 'Diamonds'
# puts cards.max.suit == 'Spades'
# # cards are also being sorted properly by suit
