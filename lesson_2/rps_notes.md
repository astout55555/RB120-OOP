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