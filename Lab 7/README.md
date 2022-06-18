In this lab, we extended on Lab 6's tug of war game but here you play with the computer. The computer will try to pull the light to its side
and you have to counteract that and pull it to your side. The computer can play on different levels, chosen by changing the value of the 9 switches, with
level 0 (correspoding to all the switches being 0) as the easiest level. This time there are two counters representing the wins for the player and the computer,
with the number of wins each has displayed on the HEX's. Once a player wins the game automatically resets and the light goes back to the center. The wins go up to 7 
and so after that the whole machine needs to be reset (which is done by using switch 9). We implemented the computer's presses using an LFSR random number generator.
