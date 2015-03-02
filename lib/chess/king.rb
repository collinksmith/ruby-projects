class King < Piece
  attr_accessor :attacking_pieces
  def initialize(position, board, color, player=nil)
    @type = 'K'
    @moved = false
    @attacking_pieces = []
    super(position, board, color, @type, player)
  end

  # def castle(new_posiiton)
  #   return false unless @moved == false
  # end

  # def move(new_position)
  #   @moved = true

  #   # Handle castles

  #   super(new_position)
  # end

  def valid_moves
    valid_moves = []
    possible_moves = [[@position[0] + 0, @position[1] + 1],
                      [@position[0] + 1, @position[1] + 1],
                      [@position[0] + 1, @position[1] + 0],
                      [@position[0] + 1, @position[1] - 1],
                      [@position[0] + 0, @position[1] - 1],
                      [@position[0] - 1, @position[1] - 1],
                      [@position[0] - 1, @position[1] + 0],
                      [@position[0] - 1, @position[1] + 1]]
    possible_moves

    possible_moves.each do |move|
      begin
        valid_moves << move if check_move(move)
      rescue
      end
    end
    return valid_moves
  end

  def check_move(new_position)
    super(new_position)
    new_column, new_row, old_column, old_row = columns_and_rows(new_position)

    # Handle castles
    
    # Return true if the move is no more than one column and one row away
    # Otherwise, raise an error.
    if (new_column - old_column).abs <= 1 && (new_row - old_row).abs <= 1
      return true
    else
      raise ArgumentError, "Invalid move."
    end
  end
end