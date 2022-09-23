# Approach to OOP

The classical approach to object oriented programming is:

  1. Write a textual description of the problem or exercise.
  2. Extract the major nouns and verbs from the description.
  3. Organize and associate the verbs with the nouns.
  4. The nouns are the classes and the verbs are the behaviors or methods.


## Example: Initial textual description
Rock, Paper, Scissors is a two-player game where each player chooses
one of three possible moves: rock, paper, or scissors. The chosen moves
will then be compared to see who wins, according to the following rules:

- rock beats scissors
- scissors beats paper
- paper beats rock

If the players chose the same move, then it's a tie.

## Example: Extracted major nouns/verbs

Nouns: player, move, rule
Verbs: choose, compare

## Example: Initial attempt to organize/associate verbs/nouns

Player
 - choose
Move
Rule

- compare

# Approach Summary

In general, you should follow the below approach:

  1. Write a description of the problem and extract major nouns and verbs.
  2. Make an initial guess at organizing the verbs and nouns into methods and classes/modules, then do a spike to explore the problem with temporary code.
  3. When you have a better idea of the problem, model your thoughts into CRC cards.

## CRC Cards Format:

+------------------------------------------------+
| Class Name                 (super-class: name) |
|------------------------------------------------|
|   -public methods / behaviors | -collaborator  |
|   -things it "has" (state)    |   objects      |
|                                                |
+------------------------------------------------+

# Notes regarding branched versions:

I branched my repository so I could experiment with the bonus feature assignment of using a class for each type of move, rather than simply assigning a different value to the Move object based on the move chosen.

Pros:
  -this allowed me to break up the huge logic chains previously required for RPSLS, for the `<` and `>` methods, and put only the relevant comparison logic into each subclass
  -if I were to make the game even more complicated, with additional move options, this design would allow me to scale more easily and keep it more readable, because the logic would still be split up into manageable chunks, instead of all clustered together in the same Move instance methods

Cons:
  -because there was no easy translation from a string input (or random string selection) to the relevant class name, I had to define a move=(choice) method for Player objects which used a case statement to translate the string to the relevant object, which could be assigned to the move instance variable for the Player
  -this ended up taking more space because I needed to define 5 different initialize methods to set the value for each subclass of Move, in order to prevent redundancy when initializing the objects, i.e. so I could use `Rock.new` instead of `Rock.new('rock')`
  -I still had to use a separate constant for an array of valid moves, even though I couldn't use it to directly set the value of the Move object anymore

Overall, this was probably a good design choice. It takes up more space and is a bit more redundant in some ways (with initialize and the valid moves list), but it allows for more readable code and avoids upsetting rubocop with overly complex logic within a definition.