# Chess

A chess game played between two human players on the command line. Built as part of [The Odin Project](http://www.theodinproject.com/ruby-programming/ruby-final-project).

## How to Play

Move by typing in the coordinates of the piece you want to move, then the coordinates of the square you want to move it to. 
* Commas and spaces are ignored. 
* Coordinates are should be given as a column, then a row. Columns range from a-h, and rows range from 1-8 (corresponding to the letters and numbers displayed on the board).
* If your move is illegal for any reason, the program will tell you why's illegal and wait for a new move.

To castle, simply moved the king to the square he will end up on. You can only castle if you are not in check and neither the king nor the rook in question have moved.

The program will let you know if you are in check or if checkmate has occurred. If there is a checkmate, the program will declare the winner and exit.

## Saving, Loading, and Exiting

You can save or load the game by typing 'save' or 'load' at any point. You will then be prompted for the file name that you want to save to or load from. The save files are stored as .yaml files in the saves folder of the root directory of this project.

You can exit the program by typing 'exit' or 'quit' at any time. This will save the game with the name 'autosave"'. There can only be one autosave at a time.

## Updates
* 3/5/15 - Added en passant.
* 3/6/15 - Added promotion for pawns.

## To-Do

This program should implement all rules of chess correctly with the following exceptions:
* The game does not detect or declare automatic draws (i.e. if a king is not in check but the player has no legal moves, or there are only two kings left). In this situation, there will simply be no possible move and you must exit the program manually.