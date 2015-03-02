require_relative 'helper.rb'

class Game
  include Helper
  attr_accessor :board, :white_player, :black_player
  def initialize
    @board = Board.new
    @white_player = Player.new(@board, :white)
    @black_player = Player.new(@board, :black)
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
      player = @white_player
      other_player = @black_player
    else
      player = @black_player
      other_player = @white_player
    end
    attacking_pieces = player.king.attacking_pieces
    king_position = player.king.position

    # If there's only one attacking piece, check if the defending 
    # player can put a piece between it and his king, or capture it. 
    if attacking_pieces.length == 1
      attacking_pieces.each do |attacking_piece|
        positions = positions_between(player.king.position, attacking_piece.position)
        positions << attacking_piece.position
        # puts "positions between are #{positions}"
        positions.each do |position|
          player.pieces.each do |piece|
            next if piece == player.king
            # puts "checking #{position}"
            begin
              if piece.check_move(position)
                # puts "Not checkmate because a piece can move in the way"
                # puts "Piece that can move is #{piece.type} at #{piece.position}"
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
    valid_moves.each do |position|
      player.move(king_position, position)
      still_in_check = check?(color)
      if still_in_check == true
        player.move(position, king_position)
      else
        avoided_check = true
        player.move(position, king_position)
      end
    end
    return avoided_check ? false : true

    return true
  end
end