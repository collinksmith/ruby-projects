require_relative 'piece.rb'

class Pawn < Piece
  def initialize(position, board, color)
    @type = 'P'
    super(position, board, color, @type)
  end

end