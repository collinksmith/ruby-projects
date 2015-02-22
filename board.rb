require_relative 'cell'
class Board
  attr_accessor :cells

  def initialize(columns=7, rows=6)
    @columns = columns
    @rows = rows
    @cells = [*1..@columns].map { |i| [] }
    @cells.each do |column|
      @rows.times { |i| column << Cell.new }
    end
  end

  def display
    # For each row, step through each column and print the cell
    # at that row and column
    [*0..@rows-1].each do |row|
      [*0..@columns-1].each do |column|
        print "|_#{@cells[column][row]}_"
      end
      print "|\n"
    end
  end
end