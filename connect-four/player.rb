class Player
  attr_accessor :token, :board
  def initialize(token, board)
    @token = token
    @board = board
  end

  def play(column)
    open_row = @board.lowest_open_row(column-1)
    # If row is full, raise an execption. Otherwise, play the token
    if open_row == false
      raise ArgumentError, "That row is full. Try again."
    else
      @board.cells[column-1][open_row].status = @token
    end
  end
end