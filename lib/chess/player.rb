class Player
  def initialize(board, color)
    # puts color
    if color == :white
      pawn_adder = 0
      piece_adder = 0
    elsif color == :black
      pawn_adder = 5
      piece_adder = 7
    end
    @color = color
    @board = board
    @pieces = [Rook.new([0,0 + piece_adder], board, color),
               Knight.new([1, 0 + piece_adder], board, color),
               Bishop.new([2, 0 + piece_adder], board, color),
               Queen.new([3, 0 + piece_adder], board, color),
               King.new([4, 0 + piece_adder], board, color),
               Bishop.new([5, 0 + piece_adder], board, color),
               Knight.new([6, 0 + piece_adder], board, color),
               Rook.new([7, 0 + piece_adder], board, color),
               Pawn.new([0, 1 + pawn_adder], board, color),
               Pawn.new([1, 1 + pawn_adder], board, color),
               Pawn.new([2, 1 + pawn_adder], board, color),
               Pawn.new([3, 1 + pawn_adder], board, color),
               Pawn.new([4, 1 + pawn_adder], board, color),
               Pawn.new([5, 1 + pawn_adder], board, color),
               Pawn.new([6, 1 + pawn_adder], board, color),
               Pawn.new([7, 1 + pawn_adder], board, color),]

  end

  # Check if the player has a piece on the old position. If not raise an error.
  # Then, check if the move is legal.
  # Then, set the position of the piece to the new position
  def move(old_position, new_position)
    old_column, old_row = old_position[0], old_position[1]
    new_column, new_row = new_position[0], new_position[1]
    piece = @board.get_piece([old_column, old_row])

    unless piece.color == @color
      raise ArgumentError, "You don't have a piece on that square."
    end

    piece.check_move(new_position)
    piece.set_position(new_position)
  end
end