class Piece
  attr_accessor :position, :type, :color
  def initialize(position, board, color, type=nil, player=nil)
    @position = position
    @board = board
    @color = color
    @type = type
    @player = player
    set_position(position, true)
  end

  # Change the piece's position, and update the relevant cells on the board.
  # The cell at the old position has its piece set to nil.
  # The cell at the new position has its piece set to this piece.
  def set_position(new_position, init=false)
    unless init
      @board.cells[@position[0]][@position[1]].set_piece(nil)
    end
    @board.cells[new_position[0]][new_position[1]].set_piece(self)
    @position = new_position
  end

  #Check if the new position is on the board
  def off_board?(new_position)
    return (new_position[0].between?(0, 7) && new_position[1].between?(0, 7)) ? false : true
  end

  # Check if the new position is occupied by a same-color piece
  def occupied_by_friendly?(new_position, new_cell)
    if new_cell.piece
      return true if new_cell.piece.color == @color
    end
    return false
  end

  def columns_and_rows(new_position)
    new_column = new_position[0]
    new_row = new_position[1]
    old_column = @position[0]
    old_row = @position[1]
    return new_column, new_row, old_column, old_row
  end

  # Check if there is a piece in the way
  def open_line?(new_position)
    new_column, new_row, old_column, old_row = columns_and_rows(new_position)
    # Check the column
    if new_column == old_column
      # Going up the column
      if new_row > old_row
        (old_row+1).upto(new_row-1) do |row|
          return false if @board.cells[new_column][row].piece
        end
      # Going down the column
      else
        (old_row-1).downto(new_row+1) do |row|
          return false if @board.cells[new_column][row].piece
        end
      end
    end

    # Check the row
    if new_row == old_row
      # Going up the row
      if new_column > old_column
        (old_column+1).upto(new_column-1) do |column|
          return false if @board.cells[column][new_row].piece
        end
        # Going down the row
      else
        (old_column-1).downto(new_column+1) do |column|
          return false if @board.cells[column][new_row].piece
        end
      end
    end

    # Check the bottom left to top right diagonal
    if (new_row - old_row) == (new_column - old_column)
      # Going from bottom left to top right
      if new_row > old_row
        (old_row+1).upto(new_row-1) do |row|
          increment = row - old_row
          return false if @board.cells[old_column + increment][row].piece
        end
      # Going from top right to bottom left
      else
        (old_row-1).downto(new_row+1) do |row|
          increment = row - old_row
          return false if @board.cells[old_column + increment][row].piece
        end
      end
    end

    # Check the top left to bottom right diagonal
    if (new_row + new_column) == (old_row + old_column)
      # Going from top left to bottom right
      if new_column > old_column
        (old_column+1).upto(new_column-1) do |column|
          increment = old_column - column
          return false if @board.cells[column][old_row + increment].piece
        end
      # Going from bottom right to top left
      else
        (old_column-1).downto(new_column+1) do |column|
          increment = old_column - column
          return false if @board.cells[column][old_row + increment].piece
        end
      end
    end

    return true
  end


  # Return true if the move if allowed.
  # Otherwise, raise an error.
  def check_move(new_position)
    if off_board?(new_position)
      raise ArgumentError, "That position is not on the board."
      return false
    end
    
    old_cell = @board.cells[@position[0]][@position[1]]
    new_cell = @board.cells[new_position[0]][new_position[1]]

    if occupied_by_friendly?(new_position, new_cell)
      raise ArgumentError, "That position is occupied by a friendly piece."
      return false 
    end

    unless open_line?(new_position)
      raise ArgumentError, "There is another piece in the way."
      return false
    end

    raise ArgumentError, "Your piece is already on that square." if old_cell == new_cell

    return true
  end

  def delete
    @player.pieces.delete(self)
  end
end