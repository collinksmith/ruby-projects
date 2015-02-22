class Player
  attr_accessor :token, :board
  def initialize(token, board)
    @token = token
    @board = board
  end

  def play(column)
    open_row = 5
    @board.cells[column-1][open_row].status = @token
  end
end