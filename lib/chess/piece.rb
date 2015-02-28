class Piece
  attr_accessor :position, :type, :color
  def initialize(position, board, color, type)
    @position = position
    @board = board
    @color = color
    @type = type
    set_position(position)
  end

  def set_position(new_position, old_position=nil)
    if old_position
      @board.cells[old_position[0]][old_position[1]].set_piece(nil)
    end
    @board.cells[new_position[0]][new_position[1]].set_piece(self)
  end

  def off_board?(new_position)
    #Check if the new position is on the board
    return (new_position[0].between?(0, 7) && new_position[1].between?(0, 7)) ? false : true
  end

  def occupied_by_friendly?(new_position, new_cell)
    # Check if the new position is occupied by a same-color piece
    if new_cell.piece
      return true if new_cell.piece.color == @color
    end
    return false
  end

  def open_line?(new_position)
    new_column = new_position[0]
    old_column = @position[0]
    new_row = new_position[1]
    old_row = @position[1]

    # Check the column
    if new_column == old_column
      if new_row > old_row
        puts "old_column : #{old}"
        (old_column+1).upto(new_column-1) do |row|
          return false #unless @board.cells[new_column][row].piece == nil
        end
      else
        (old_column-1).downto(new_column+1) do |row|
          return false if @board.cells[new_column][row].piece
        end
      end
    end

    return true
  end

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

end