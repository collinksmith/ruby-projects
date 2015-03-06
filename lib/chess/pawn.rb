require_relative 'piece.rb'

class Pawn < Piece
  def initialize(position, board, color, player=nil, game)
    @type = 'P'
    @capturing_by_en_passant = false
    super(position, board, color, @type, player, game)
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
        
        #Check if en passant is allowed
        if en_passant?(new_column, new_row)
          @capturing_by_en_passant = true
          return true
        end

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
        
        # Check if en passant is allowed
        if en_passant?(new_column, new_row)
          @capturing_by_en_passant = true
          return true
        end


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

  def en_passant?(new_column, new_row)
    if @color == :white && @game.en_passant
      # En passant is allowed if moving to row 5 and a column
      # in which black just advanced a pawn to row 4
      if @game.en_passant.position[0] == new_column && new_row == 5
        return true
      end
    elsif @color == :black && @game.en_passant
      # En passant i allowed if moving to row 2 and a column
      # in which white just advanced a pawn to row 3
      if @game.en_passant.position[0] == new_column && new_row == 2
        return true
      end
    else
    end

    false
  end

  def move(new_position)
    old_position = @position

    super(new_position, true)

    # If performing en passant, delete the opposing pawn
    if @capturing_by_en_passant
      @game.en_passant.delete
      @capturing_by_en_passant = false
    end

    # Flag the pawn as available to be taken by en passant  if it is
    # moving two spaces forward from its home row
    if @color == :white && old_position[1] == 1 && new_position[1] == 3
      @game.en_passant = self
    elsif @color == :black && old_position[1] == 6 && new_position[1] == 4
      @game.en_passant = self
    else
      @game.en_passant = nil
    end
  end
end