class Board
  attr_accessor :board

  # Create an array with 64 elements, from [1,1] to [8,8], to
  # serve as the board.
  def initialize
    @rows = [1,2,3,4,5,6,7,8]
    @columns = [1,2,3,4,5,6,7,8]
    @board = []
    @rows.each do |r| 
      @columns.each do |c|
        @board << [r, c]
      end
    end
  end

  def display
    print @board
    print @board.size
  end
end