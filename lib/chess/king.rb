class King < Piece
  def initialize(position, board, color)
    @type = 'K'
    super(position, board, color)
  end

  def check_move(new_position)
    super(new_position)
    new_column, new_row, old_column, old_row = columns_and_rows(new_position)

    # Return true if the move is no more than one column and one row away
    # Otherwise, raise an error.
    if (new_column - old_column).abs <= 1 && (new_row - old_row).abs <= 1
      return true
    else
      raise ArgumentError, "Invalid move."
    end
  end
end