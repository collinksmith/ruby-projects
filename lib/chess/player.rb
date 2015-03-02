class Player
  attr_accessor :pieces, :king, :color
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
    @pieces = [Rook.new([0,0 + piece_adder], board, color, self),
               Knight.new([1, 0 + piece_adder], board, color, self),
               Bishop.new([2, 0 + piece_adder], board, color, self),
               Queen.new([3, 0 + piece_adder], board, color, self),
               King.new([4, 0 + piece_adder], board, color, self),
               Bishop.new([5, 0 + piece_adder], board, color, self),
               Knight.new([6, 0 + piece_adder], board, color, self),
               Rook.new([7, 0 + piece_adder], board, color, self),
               Pawn.new([0, 1 + pawn_adder], board, color, self),
               Pawn.new([1, 1 + pawn_adder], board, color, self),
               Pawn.new([2, 1 + pawn_adder], board, color, self),
               Pawn.new([3, 1 + pawn_adder], board, color, self),
               Pawn.new([4, 1 + pawn_adder], board, color, self),
               Pawn.new([5, 1 + pawn_adder], board, color, self),
               Pawn.new([6, 1 + pawn_adder], board, color, self),
               Pawn.new([7, 1 + pawn_adder], board, color, self),]
    @king = @pieces[4]
  end

  # If legal, move the piece to the new position.
  # If there's an opposing piece there, delete it.
  def move(old_position, new_position)
    old_column, old_row = old_position[0], old_position[1]
    new_column, new_row = new_position[0], new_position[1]
    piece = @board.get_piece([old_column, old_row])

    # Check that the player has a piece on that square
    if piece == nil || piece.color != @color
      raise ArgumentError, "You don't have a piece on that square."
    end

    piece.move(new_position)
  end

  def attacking?(position)
    @pieces.each do |piece|
      begin
        return true if piece.check_move(position)
      rescue
      end
    end
    false
  end
end