# Mastermind

## A command line implementation of the mastermind board game. 

The player can choose to select the secret colors or guess the secret colors, and the computer will fill the opposite role. The available colors are red, orange, yellow, green, blue, and purple (selected with R, O, Y, G, B, and P). To win, the guesser must select the exact combination of colors and locations by the end of the specified number of turns (default is 12).

Between each turn, there will be a display showing the history of the guesses and the results of those guesses. In the results column, an exclamation point indicates a correct color and location, while a question mark indicates a correct color, but incorrect location. The position of the exclamation point does *not* indicate which guess was in the correct location - they are simply placed from left to right.

The AI for the computer guessing is very simple. It will guess at random, and if any of the guesses is exactly correct, it will keep that guess for all future guesses, and continue to guess randomly for the other positions.