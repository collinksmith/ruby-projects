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

  def get_chess_symbol(color, status)
    if color == :black
      symbols = {'K' => "\u2654",
                 'Q' => "\u2655",
                 'R' => "\u2656",
                 'B' => "\u2657",
                 'N' => "\u2658",
                 'P' => "\u2659"}
    end

    if color == :white
      symbols = {'K' => "\u265A",
                 'Q' => "\u265B",
                 'R' => "\u265C",
                 'B' => "\u265D",
                 'N' => "\u265E",
                 'P' => "\u265F"}
    end

    symbol = symbols[status]
  end

  def to_s
    @status == ' ' ? @status : get_chess_symbol(@piece.color, @status)
  end
end