# Object-oriented Approach Summary

1. Write a description of the problem and extract major nouns and verbs

2. Make an initial guess at organizing the verbs into nouns and do a spike to explore the problem with temporary code.

3. Optional - model thoughts into CRC (class-responsibilities-collaborators) cards

# Nouns and Verbs

Tic Tac Toe is a 2-player board game played on a 3x3 grid. Players take turns marking a square. The first player to mark 3 squares in a row wins.

Nouns: board, player (human, computer), square, game
Verbs: play, mark

(Re-)Organized:

Board
- mark
Square
Player
Game
- play

# Notes regarding code review:

I've implemented most suggested changes, and should make a few comments about this final version.

1. My refactored version of the Computer class could allow the computer to choose its own marker based on knowledge of the human marker passed to it. This seemed better than moving even more of the computer instance methods into the TTTGame class definition, plus it allowed me to replace a couple lines of code where I call the method to set the computer marker and simply pass the computer object the necessary bit of information as it's instantiated.

2. I could have done the same with the determine_difficulty method, but I don't think that would have logically followed the OO structure. Adjusting the #determine_difficulty method so that it wouldn't accept responses that were not clearly yes or no ran me afoul of rubocop. While I refactored to fix this, I realized that even though I would need to run this method every time I created a new computer, it made more sense to place the method definition (and its 2 new supporting methods) into the TTTGame class, given that it was the game and the input from the player which determined the difficulty, not the computer deciding its own difficulty.

3. This also allowed me to not include the Displayable module in the Computer class, removing the overlap of code between two separate classes of objects (game and computer player), which seemed desirable given that it helped me refactor the Displayable module so it really just consisted of various messages, and left most of the logic of the game to the TTTGame class definition.

4. I liked that I ended up with the same method names for the same functions across both types of players, and could potentially call `human.set_name` or `computer.set_name`, `human.choose_marker` or `computer.choose_marker`, within the flow of the game (in the TTTGame class definition) if it suited me. In practice, these were methods I called in the `Player#initialize` method, and the implementation varied in the definitions of each sub-class. With the `human_marker` argument having a default value of `nil`, I was able to remove the specific implementations of `initialize` for the sub-classes, and pass the nil to the `Human#choose_marker` method to take the place of a local variable I would've had to define as nil as a placeholder for the choice anyway; this all works as long as I remember to pass the human marker to any newly instantiated Computer objects. Even if I didn't have to do that, though, I'd need to remember to call an additional method after creating each new Computer object, so it's at least no worse intuitively.

5. In part for these reasons, I decided against making the change suggested by the TA reviewing the code, where I would combine the instance methods `picking_first?`, `choose_first_to_move`, `set_name`, and `choose_marker`. I could see how I could pass in arguments to allow a single method to instead display the appropriate prompt, and use the appropriate verification method, but the purpose and use of these methods was just too different I think to make such a change beneficial.

First of all, I had already found a way to include #set_name and #choose_marker in the Player#initialize method, and I like that I don't have to separately call some single method all these separate times with separate arguments. Additionally, the implementation of #choose_first_to_move differed based on the sub-class of Player, and this very different implementation would need to be accounted for if I wanted to still have the natural readable code where at various points I can write `human.choose_first_to_move` or `computer.choose_first_to_move` and not worry about the implementation.

Finally, the expected behavior of each method was fairly different. Some involved actually reassigning the value of some instance variable, such as @marker or @name or @first_to_move. But Human#picking_first? was meant to simply return a boolean value. There simply didn't seem to be enough similarity of purpose and overall structure to collapse these different methods, even if most of them contained a pattern of giving a prompt, verifying the input, and then giving some sort of output. And not even all of them did that for each sub-class' implementation, e.g. Computer#choose_marker and Computer#choose_first_to_move simply assigned/reassigned a value to an instance variable based on either the human marker or the computer difficulty.

6. Also, I did implement HEREDOC a couple times, to have cleaner and more elaborate ending messages. But other than that I used multiple lines of #puts, because when it's only 2 lines, it doesn't seem all that valuable to use HEREDOC, which requires a few additional lines of code to implement each time. The only other place where I have 3+ lines of output in a row is with the #display_board method, but that one didn't play well with HEREDOC. It printed the board before the rest of the text, which messed up the order. So I left everything else as it was.

7. One more note. Rubocop doesn't like whenever I used a keyword argument (like `mode: 'defense'`), and tells me that errors are occurring, although it doesn't count as an offense, so it should be okay. It's a little annoying though, not sure why it doesn't like that, might just be because of the older version I'm using for Launch School.

8. Overall I'm satisfied with the completed game and the current choices for its OO structure.
