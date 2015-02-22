class Board
  attr_accessor :cells, :game_over

  def initialize(columns=7, rows=6)
    @game_over = false
    @columns = columns
    @rows = rows

    # Initialize the board with cells. 
    # The data structure is: @cells[column#][row#]
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

  def lowest_open_row(column)
    5.downto(0) do |i|
      return i if @cells[column][i].status == ' '
    end
    false
  end

  def create_winning_combos
    winning_combos = []
    # Add horizontal wins
    0.upto(@rows-1) do |row|
      0.upto(@columns-4) { |column| winning_combos << [[column,row], [column+1,row], [column+2,row], [column+3,row]] }
    end
    # Add vertical wins
    0.upto(@columns-1) do |column|
      0.upto(@rows-4) { |row| winning_combos << [[column,row], [column,row+1], [column,row+2], [column,row+3]] }
    end
    # Add top-left to bottom-right diagonal wins
    0.upto(@columns-4) do |column|
      0.upto(@rows-4) { |row| winning_combos << [[column,row], [column+1,row+1], [column+2,row+2], [column+3,row+3]] }
    end
    # Add bottom-left to top-right diagonal wins
    0.upto(@columns-4) do |column|
      (@rows-1).downto(3) { |row| winning_combos << [[column,row], [column+1,row-1], [column+2,row-2], [column+3,row-3]] }
    end
    winning_combos
  end

  def check_status
    winning_combos = create_winning_combos

    # Check winning combos
    winning_combos.each do |combo|
      res = []
      combo.each do |column, row|
        res << @cells[column][row].status
      end
      if res.all? { |status| status == 'X' }
        @game_over = true
        return "Player X wins" 
      elsif res.all? { |status| status == 'O' }
        @game_over = true
        return "Player O wins" 
      end
    end

    # Check for tie
    all_cells = [*0...@columns].map { |column| [*0...@rows].map { |row| cells[column][row] } }.flatten
    if all_cells.none? { |cell| cell.status == ' ' }
      @game_over = true
      return "Tie game" 
    end
  end
end