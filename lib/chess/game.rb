class Game
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

    other_player.pieces.each do |piece|
      begin
        return true if piece.check_move(king_position)
      rescue
      end
    end
    return false
  end

  def checkmate?(player)

  end
end