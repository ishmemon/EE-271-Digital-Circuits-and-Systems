In this lab we created a Connect 4 game on a GPIO LED grid display connected to a DE1_SoC board.
How it works: SW[9] is reset (it resets the score and the board). Switches 8, 7, 6, 5 control the
first players’ blocks. That color is red. 8 through 5 control the columns from left to right.
Switches 3 to 0 control the second players’ blocks. That color is green. 3 through 0 also control
the columns from left to right. If one of the players wins their score updates and the game
resets. The game only goes until someone gets 7 points, then we have to manually reset or else
the counter won’t keep counting for that player.
