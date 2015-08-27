class Knight < Piece
  def initialize(position, board, color, player=nil, game)
    @type = "N"
    super(position, board, color, @type, player, game)
  end

  def check_move(new_position)
    super(new_position)
    new_column, new_row, old_column, old_row = columns_and_rows(new_position)

    allowed_moves = [[old_column + 2, old_row + 1],
                     [old_column + 2, old_row - 1],
                     [old_column + 1, old_row + 2],
                     [old_column + 1, old_row - 2],
                     [old_column - 1, old_row + 2],
                     [old_column - 1, old_row - 2],
                     [old_column - 2, old_row + 1],
                     [old_column - 2, old_row - 1]]
    
    # Return true if the new_position is an allowed move.
    # Otherwise, return false.
    if allowed_moves.include?(new_position)
      return true
    else
      raise ArgumentError, "Invalid move."
    end
  end
end