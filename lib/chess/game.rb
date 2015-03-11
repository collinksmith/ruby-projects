=begin
Note: There is a problem with both checkmate? and stalemate? because for both, I need to move a piece and then check if the game would be in checkmate afterward. If not, then the functions return false. The problem is that, if I then revert to the old position by simply moving the piece back, it won't work properly if there had been an opposing piece on the sqare of the test move. That piece would be gone.
 
One idea to get around this is to save the game before the test moves, and if necessary, revert by loading that save, rather than trying to manually

UPDATE: Actually, I think I should be able to simply make a copy of the 'game' object that's passed the method and call it test_game. Then, test out the moves on test_game and call test_game.check? to see if they would result in a check. If not, I can simply exit the method and the original game will be unchanged an ready to be used by the program.
=end

require_relative 'helper.rb'
require 'yaml'

class Game
  include Helper
  attr_accessor :board, :white_player, :black_player, :turn, :en_passant
  def initialize
    @board = Board.new
    @white_player = Player.new(@board, :white, self)
    @black_player = Player.new(@board, :black, self)
    @turn = :white
    @en_passant = nil
  end

  # Return true if the given player is in check.
  def check?(color)
    if color == :white
      player = @white_player
      other_player = @black_player
    else
      player = @black_player
      other_player = @white_player
    end

    king_position = player.king.position
    player.king.attacking_pieces = []

    other_player.pieces.each do |piece|
      begin
        if piece.check_move(king_position)
          player.king.attacking_pieces << piece
        end
      rescue
      end
    end
    return true if player.king.attacking_pieces.length > 0
    return false
  end

  # Return true if the player of the given color is in checkmate.
  def checkmate?(color)
    return false unless check?(color)

    if color == :white
      player = white_player
      other_player = black_player
    else
      player = black_player
      other_player = white_player
    end
    attacking_pieces = player.king.attacking_pieces
    king_position = player.king.position

    # If there's only one attacking piece, check if the defending 
    # player can put a piece between it and his king, or capture it. 
    if attacking_pieces.length == 1
      attacking_pieces.each do |attacking_piece|
        positions = positions_between(player.king.position, attacking_piece.position)
        positions << attacking_piece.position
        positions.each do |position|
          player.pieces.each do |piece|
            next if piece == player.king
            begin
              if piece.check_move(position)
                return false 
              end
            rescue
            end
          end
        end
      end
    end
    # Check if the king can move out of check
    avoided_check = false
    valid_moves = player.king.valid_moves
    game_state = get_game_state
    valid_moves.each do |position|
      test_game = Marshal::load(game_state)
      test_player = color == :white ? test_game.white_player : test_game.black_player
      test_king_position = test_player.king.position

      test_player.move(test_king_position, position)
      still_in_check = test_game.check?(color)
      unless still_in_check == true
        avoided_check = true
      end
    end
    return avoided_check ? false : true

    return true
  end

  # Check if the game is in stalemate and return true if it is.
  def stalemate?(color)
    player = color == :white ? white_player : black_player

    # Step through every piece and check if it has a legal move
    game_state = get_game_state
    player.pieces.each do |piece|
      piece_index = player.pieces.index(piece)
      # Check every possible cell
      0.upto(7) do |column|
        0.upto(7) do |row|
          test_game = Marshal::load(game_state)
          test_piece = color == :white ? test_game.white_player.pieces[piece_index] : test_game.black_player.pieces[piece_index]
          begin
            if test_piece.check_move([column, row]) == true
              # puts "Moving #{player.color}'s #{piece} to #{[column,row]}"
              test_piece.move([column, row])
              # puts "Testing whether #{player.color} is in check in #{test_game}"
              return false unless test_game.check?(player.color)
            end
          rescue
          end
        end
      end
    end
    true
  end

  def get_game_state
    Marshal.dump(self)
  end

  def save_game(file_name)
    puts "Saving..."
    yaml = YAML::dump(self)
    save_file = File.new("../saves/#{file_name}.yaml", 'w')
    save_file.write(yaml)
    save_file.close
    puts "Saved as '#{file_name}'!"
  end
end