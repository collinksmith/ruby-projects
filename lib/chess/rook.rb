class Rook < Piece
  attr_accessor :moved
  def initialize(position, board, color, player=nil, game)
    @type = 'R'
    @moved = false
    super(position, board, color, @type, player, game)
  end

  def move(new_position)
    @moved = true
    super(new_position)
  end

  def check_move(new_position)
    super(new_position)
    new_column, new_row, old_column, old_row = columns_and_rows(new_position)

    # Return true if it is along the same column or row.
    # Otherwise, return false
    if new_column == old_column || new_row == old_row
      return true
    else
      raise ArgumentError, "Invalid move."
    end
  end
end