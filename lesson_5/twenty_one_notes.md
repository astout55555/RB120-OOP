# OO Process

1. Write a description of the problem and extract major nouns and verbs.
2. Make an initial guess at organizing the verbs into nouns and do a spike to explore the problem with temporary code.
3. Optional - when you have a better idea of the problem, model your thoughts into CRC cards.

## Step 1: Description, Nouns, and Verbs

### Short description of game:

Twenty-One is a card game consisting of a dealer and a player, where the participants try to get as close to 21 as possible without going over.

Here is an overview of the game:
- Both participants are initially dealt 2 cards from a 52-card deck.
- The player takes the first turn, and can "hit" or "stay".
- If the player busts, they lose. If they stay, it's the dealer's turn.
- The dealer must hit until their cards add up to at least 17.
- If the dealer busts, the player wins. If both player and dealer stay, then the highest total wins.
- If both totals are equal, then it's a tie, and nobody wins.

### Nouns/Verbs:

Nouns: card, player, dealer, participant, deck, game, total (total is more of a state than an object--or even a verb like 'calculate_total')
Verbs: deal, hit, stay, bust (this is more of a state than an action--like 'busted?')

## Step 2: Organize Nouns/Verbs and do a spike of code based on this

### Organized into classes/behaviors/states

Player
- hit
- stay
- busted?
- total
Dealer
- hit
- stay
- busted?
- total
- deal (should this be here, or in Deck?)
Participant
Deck
- deal (should this be here, or in Dealer?)
Card
Game
- start

### Spike pasted into oo_twenty_one.rb

