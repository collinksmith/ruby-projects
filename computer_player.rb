class ComputerPlayer
  attr_reader :first_guess
  attr_accessor :grid

  def initialize(board_size)
    @grid = Array.new(board_size) { Array.new(board_size) }
    @guessed_pos = nil
    @matches = []
    @available_spots = populate_available_spots(board_size)
    @guessed_spots = []
  end

  def get_input
    if @guessed_pos.nil?
      guess = first_guess
    else
      guess = second_guess
    end
    guess
  end

  def handle_input(location, value)
    @grid[location[0]][location[1]] = value
    @guessed_spots << location
  end

  def handle_match(pos1, pos2, value)
    @available_spots.delete(pos1)
    @available_spots.delete(pos2)
    @matches << value
  end

  private

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end

  def populate_available_spots(board_size)
    res = []
    board_size.times do |x|
      board_size.times do |y|
        res <<[x, y]
      end
    end
    res
  end

  def first_guess
    known_match_value = check_for_matches
    if known_match_value
      guess = index(known_match_value).first
    else
      # options = @available_spots - @guessed_spots
      # guess = options.sample
      guess = (@available_spots - @guessed_spots).sample
    end
    @guessed_pos = guess
    guess
  end

  def second_guess
    guessed_value = @grid[@guessed_pos[0]][@guessed_pos[1]]
    if @grid.flatten.select { |value| value == guessed_value }.count == 2
      guess = index(guessed_value).select { |index| index != @guessed_pos }.flatten
      @guessed_pos = nil
    else
      @guessed_pos = nil
      guess = @available_spots.sample
    end
    guess
  end

  def check_for_matches
    values = @grid.flatten
    values.each_with_index do |value, i|
      ((i+1)...values.length).each do |j|
        return value if values[j] == value && !@matches.include?(value)
      end
    end

    nil
  end

  def index(value)
    positions = []
    @grid.each_with_index do |row,row_i|
      row.each_with_index do |col,col_i|
        positions << [row_i, col_i] if @grid[row_i][col_i] == value
      end
    end
    positions
  end
end