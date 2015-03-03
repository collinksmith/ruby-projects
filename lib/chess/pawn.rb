require_relative 'piece.rb'

class Pawn < Piece
  def initialize(position, board, color, player=nil)
    @type = 'P'
    super(position, board, color, @type, player)
  end

  def check_move(new_position)
    super(new_position)
    new_column, new_row, old_column, old_row = columns_and_rows(new_position)

    # Raise an error if the move is straight ahead and the spot is occupied by any piece
    if new_column == old_column && @board.cells[new_column][new_row].piece
      raise ArgumentError, "Invalid move. Pawns cannot capture straight ahead."
    end

    if @color == :white
      # Check if the move is diagonal
      if ((new_column == old_column + 1) || (new_column == old_column -1)) && (new_row == old_row + 1)
        
        # If so, can only move if the square is occupied by an opposing piece
        piece_at_new_position = @board.cells[new_column][new_row].piece
        if piece_at_new_position && piece_at_new_position.color == :black
          return true
        else
          raise ArgumentError, "Invalid move. Pawns can only move diagonally if capturing a piece."
        end

      # Otherwise, the pawn can never switch columns
      else
        unless new_column == old_column
          raise ArgumentError, "Invalid move. Cannot switch columns unless capturing a piece."
          return false
        end
      end

      # Pawn can move forward 2 if on home row. Otherwise, can only move forward 1
      if old_row == 1
        raise ArgumentError, "Invalid move. When on home row, pawns can only move 1 or 2 sqares ahead." unless new_row == old_row + 1 || new_row == old_row + 2
      else
        raise ArgumentError, "Invalid move. When not on home row, pawns can only move one square ahead." unless new_row == old_row + 1
      end
    end

    if @color == :black
      # Check if the move is diagonal
      if ((new_column == old_column + 1) || (new_column == old_column -1)) && new_row == old_row - 1
        
        # If so, can only move if the square is occupied by an opposing piece
        piece_at_new_position = @board.cells[new_column][new_row].piece
        if piece_at_new_position && piece_at_new_position.color == :white
          return true
        else
          raise ArgumentError, "Invalid move. Pawns can only move diagonally if capturing a piece."
        end

      # Otherwise, the pawn can never switch columns
      else
        unless new_column == old_column
          raise ArgumentError, "Invalid move. Cannot switch columns unless capturing a piece."
          return false
        end
      end

      # Pawn can move forward 2 if on home row. Otherwise, can only move forward 1
      if old_row == 6
        unless new_row == old_row - 1 || new_row == old_row - 2
          raise ArgumentError, "Invalid move. When on home row, pawns can only move 1 or 2 sqares ahead."
        end
      else
        unless new_row == old_row - 1
          raise ArgumentError, "Invalid move. When not on home row, pawns can only move one square ahead."
        end
      end
    end

    true
  end
end