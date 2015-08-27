class Queen < Piece
  def initialize(position, board, color, player=nil, game)
    @type = 'Q'
    super(position, board, color, @type, player, game)
  end

  def check_move(new_position)
    super(new_position)
    new_column, new_row, old_column, old_row = columns_and_rows(new_position)

    # Return true if move is along a column or row
    if new_column == old_column || new_row == old_row
      return true
    # Return true if move is along a diagonal
    elsif (new_row - old_row == new_column - old_column) || (new_row + new_column == old_row + old_column)
      return true
    # Otherwise, raise an error.
    else
      raise ArgumentError, "Invalid move."
    end
  end
end