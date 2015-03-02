require_relative 'cell.rb'

class Board
  attr_accessor :board, :cells

  # Create an array with 64 elements, from [1,1] to [8,8], to
  # serve as the board.
  def initialize
    @columns = 8
    @rows = 8
    @cells = [*1..@columns].map { |i| []}
    @cells.each do |column|
      @rows.times { |i| column << Cell.new }
    end
  end
  
  def display
    @columns.times do |column|
      print "#{@columns - column}"
      @rows.times do |row|
        print "|#{@cells[@columns-1 - column][row]}"
      end 
      print "|\n"
    end
    print "  a b c d e f g h "
  end

  def get_piece(position)
    @cells[position[0]][position[1]].piece
  end
end