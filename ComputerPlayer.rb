class ComputerPlayer
  def initialize(board_size, board)
    @grid = Array.new(board_size) { Array.new(board_size) }
    @first_guess = true
    @matches = []
    @to_guess = nil
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end

  def get_input
    # if !@to_guess.empty?
    #   @to_guess[0]
    #   @to_guess.shift
    # elsif @first_guess

      check_for_match

    else
       knows_location

    end
  end

  def handle_input(location, value)
    @grid[*location] = value
  end

  def handle_match(match1, match2)
    @revealed << match1, match2
  end

  def index value
    positions = []
    @grid.each_with_index do |row,row_i|
      row.each_with_index do |col,col_i|
        positions << if @grid[row_i,col_i] == value
      end
    end

  end

  def check_for_match
    matches = []
    @grid.flatten.each_with_index do |cell,idx|
      ((idx+1)...@grid.flatten.length).each do |num|
        matches << cell if cell == num
    end
    matches.uniq

    else
      random_guess
      @to_guess
    end
  end

  def random_guess
    pos = nil
    until pos && !@revealed.include?(pos)
      pos = [rand(board_size),rand(board_size)]
      @to_guess = pos
    end
  end

  def knows_location
    @grid.each_index do |x|
      @grid.each_index do |y|
        return [x,y] if @grid[x,y] == @to_guess
      end
    end
  end





end
