# NOTE: I'm not sure why I need this to run my tests.
# I didn't need it for rook.rb
require_relative "piece.rb"

class Bishop < Piece
  def initialize(position, board, color)
    @type = 'B'
    super(position, board, color)
  end

  def check_move(new_position)
    super(new_position)
    new_column, new_row, old_column, old_row = columns_and_rows(new_position)

    # Return true if it is along a diagonal. Otherwise, return false.
    if (new_row - old_row == new_column - old_column) || (new_row + new_column == old_row + old_column)
      return true
    else
      raise ArgumentError, "Invalid move."
    end
  end
end