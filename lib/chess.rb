=begin
TODO: 
  * En passant
  * Unicode characters
  * Ability to save
  * Get a piece when you get the pawn to the end
=end
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

def valid_position?(position)
  return false unless position[0] =~ /[abcdefgh]/
  return false unless position[1].to_i.between?(1, 8)
  true
end

def get_move(player_color)
  begin
    move = gets.chomp.scan(/\w/)
    raise ArgumentError unless move.length == 4
    move = [move[0..1],move[2..3]]
    raise ArgumentError unless valid_position?(move[0]) && valid_position?(move[1])
  rescue ArgumentError
    puts "Invalid move coordinates. Please try again."
    retry
  end
  move = [convert_position(move[0]), convert_position(move[1])]
  return move
end

def player_turn(game, player)
  player_name = player.color == :white ? 'White player' : 'Black player'
  puts "\n#{player_name}, what is your move?"
  begin
    move = get_move(player.color)
    player.move(move[0], move[1])
    if game.check?(player.color)
      game.board.cells[move[1][0]][move[1][1]].piece.set_position(move[0])
      raise ArgumentError, "That move puts you in check!"
    end
  rescue ArgumentError => e
    print e.message
    puts " Please try again."
    retry
  end
end

def check_status(game, player)
  other_player = player.color == :black ? 'White player' : "Black player"
  game_over = false
  if game.check?(player.color)
    if game.checkmate?(player.color)
      game_over = true
      puts "\nCheckmate. #{other_player} wins!"
    else
      puts "\nCheck."
    end
  end
  game_over
end

def play_game
  game = Game.new
  game_over = false
  game.board.display

  counter = 0
  until game_over
    if counter.even?
      player_turn(game, game.white_player)
      game.board.display
      game_over = check_status(game, game.black_player)
    else
      player_turn(game, game.black_player)
      game.board.display
      game_over = check_status(game, game.white_player)
    end
    counter += 1
  end
  puts "Thanks for playing!"
  exit
end

play_game if $0 == __FILE__