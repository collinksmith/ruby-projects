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

# Take a position as entered by a human, and convert it
# to something the computer understands

require_relative 'chess.rb'
require_relative 'chess/bishop.rb'
require_relative 'chess/board.rb'
require_relative 'chess/cell.rb'
require_relative 'chess/game.rb'
require_relative 'chess/helper.rb'
require_relative 'chess/king.rb'
require_relative 'chess/knight.rb'
require_relative 'chess/pawn.rb'
require_relative 'chess/piece.rb'
require_relative 'chess/player.rb'
require_relative 'chess/queen.rb'
require_relative 'chess/rook.rb'

def convert_position(position)
  letter_to_number = {'a' => 0,
                      'b' => 1,
                      'c' => 2,
                      'd' => 3,
                      'e' => 4,
                      'f' => 5,
                      'g' => 6,
                      'h' => 7}

  column = letter_to_number[position[0]]
  row = position[1].to_i

  return [column, row-1]
end

def get_move(player_color)
  player = player_color == :white ? 'White player' : 'Black player'
  puts "#{player}, what is your move?"
  move = gets.chomp.split
  move.map! { |position| position.split('') }
  move = [convert_position(move[0]), convert_position(move[1])]
  return move
end

def player_turn(game, player)
  begin
    move = get_move(player.color)
    player.move(move[0], move[1])
    if game.check?(player.color)
      player.move(move[1], move[0])
      raise ArgumentError, "That move puts you in check!"
    end
  rescue ArgumentError => e
    print e
    puts "Please try again."
    retry
  end
end

def check_status(game, player)
  other_player = player.color == :black ? 'White player' : "Black player"
  game_over = false
  if game.check?(player.color)
    if game.checkmate?(player.color)
      game_over = true
      puts "Checkmate. #{other_player} wins!"
    else
      puts "Check."
    end
  end
  game_over
end

def play_game
  game = Game.new
  game_over = false

  counter = 0
  until game_over
    if counter.even?
      game.board.display
      player_turn(game, game.white_player)
      game_over = check_status(game, game.black_player)
    else
      game.board.display
      player_turn(game, game.black_player)
      game_over = check_status(game, game.white_player)
    end
    counter += 1
  end
end

play_game