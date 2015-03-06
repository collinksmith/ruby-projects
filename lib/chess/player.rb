require_relative 'helper.rb'
class Player
  include Helper
  attr_accessor :pieces, :king, :color, :queenside_rook, :kingside_rook
  def initialize(board, color, game)
    # puts color
    if color == :white
      pawn_adder = 0
      piece_adder = 0
    elsif color == :black
      pawn_adder = 5
      piece_adder = 7
    end
    @game = game
    @color = color
    @board = board
    @pieces = [Rook.new([0,0 + piece_adder], board, color, self, game),
               Knight.new([1, 0 + piece_adder], board, color, self, game),
               Bishop.new([2, 0 + piece_adder], board, color, self, game),
               Queen.new([3, 0 + piece_adder], board, color, self, game),
               King.new([4, 0 + piece_adder], board, color, self, game),
               Bishop.new([5, 0 + piece_adder], board, color, self, game),
               Knight.new([6, 0 + piece_adder], board, color, self, game),
               Rook.new([7, 0 + piece_adder], board, color, self, game),
               Pawn.new([0, 1 + pawn_adder], board, color, self, game),
               Pawn.new([1, 1 + pawn_adder], board, color, self, game),
               Pawn.new([2, 1 + pawn_adder], board, color, self, game),
               Pawn.new([3, 1 + pawn_adder], board, color, self, game),
               Pawn.new([4, 1 + pawn_adder], board, color, self, game),
               Pawn.new([5, 1 + pawn_adder], board, color, self, game),
               Pawn.new([6, 1 + pawn_adder], board, color, self, game),
               Pawn.new([7, 1 + pawn_adder], board, color, self, game)]
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
    unless @pieces.include?(rook)
      raise ArgumentError, "You can't castle because you don't have the rook!"
    end

    # Check if king has moved
    raise ArgumentError, "You can't castle because the king has moved." if @king.moved

    # Check if rook has moved
    raise ArgumentError, "You can't castle because the rook has moved." if rook.moved

    # Check whether there are any pieces in the way
    positions = positions_between(@king.position, rook.position)
    positions.each do |position|
      if @board.cells[position[0]][position[1]].piece
        raise ArgumentError, "You can't castle because there are pieces in the way."
      end
    end

    # Check whether the player is in check
    if @game.check?(@color)
      raise ArgumentError, "You can't castle because you are in check!"
    end

    return true
  end

  def castle(side)
    can_castle?(side)
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
    @king.moved = true
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