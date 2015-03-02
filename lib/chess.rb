=begin
# REMINDERS

* I was unable to incorporate a check to see if a move result in a check by
the moving player in the check_move function. This means that, when moving with
the game logic, I will need to call game.check?, and if it returns true, raise an
error and start the move loop over (just like I will if the check_move function
raises an error for any reason). These should be able to go in the same begin loop.

  * Note: I just realized that this should also take care of checking whether
  somebody successfully moves out of check if they are already in check. At any
  time, they should be unable to make a move that results in them being in check.

* My plan is to call game.check?, and then if that returns true, call game.checkmate?

* Don't forget that I will need to convert what a player enters (e.g. e8) into the
appropriate cell as the computer understands it (in this example, [4,7]).

* That's all I can really think of right now. I think basically all I need to do is the
game logic in this file, implementing saving, and the unicode characters for pieces.

=end