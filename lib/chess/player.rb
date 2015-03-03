require_relative 'helper.rb'
class Player
  include Helper
  attr_accessor :pieces, :king, :color, :queenside_rook, :kingside_rook
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
    @queenside_rook = @pieces[0]
    @kingside_rook = @pieces[7]
  end

  def get_castle_rook(side)
    if side == 'K'
      rook = @kingside_rook
    elsif side == 'Q'
      rook = @queenside_rook
    else
      raise ArgumentError, "Must provide K or Q for the side toward which to castle."
    end
    return rook
  end

  def can_castle?(side)
    rook = get_castle_rook(side)
    # Check if the rook exists
    return false unless @pieces.include?(rook)

    # Check if king has moved
    return false if @king.moved

    # Check if rook has moved
    return false if rook.moved

    # Check whether there are any pieces in the way
    positions = positions_between(@king.position, rook.position)
    positions.each do |position|
      return false if @board.cells[position[0]][position[1]].piece
    end

    return true
  end

  def castle(side)
    raise ArgumentError, "You are not allowed to do that castle in this situation." unless can_castle?(side)
    rook = get_castle_rook(side)

    king_column, king_row = @king.position[0], @king.position[1]
    rook_column, rook_row = rook.position[0], rook.position[1]

    if side == 'K'
      @king.set_position([king_column+2, king_row])
      rook.set_position([rook_column-2, rook_row])
    else
      @king.set_position([king_column-2, king_row])
      rook.set_position([rook_column+3, rook_row])
    end
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