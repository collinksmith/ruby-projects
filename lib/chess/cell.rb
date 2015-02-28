class Cell
  attr_accessor :status, :piece
  def initialize(piece=nil)
    @piece = piece
    @status = ' '
  end

  def set_piece(piece)
    @piece = piece
    if @piece
      @status = piece.type
    else
      @status = ' '
    end
  end

  def to_s
    @status
  end
end