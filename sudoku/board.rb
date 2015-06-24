require_relative 'tile'

class Board

  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def self.from_file(file)
    grid = File.readlines(file)
    grid.map! do |row|
      row.chomp.split('').map! do |char|
        char.to_i == 0 ? Tile.new(char.to_i) : Tile.new(char.to_i, true)
      end
    end

    Board.new(grid)
  end

  def [](pos)
    row,col = pos

    @grid[row - 1][col - 1]
  end

  def []=(pos, new_value)
    row,col = pos

    @grid[row - 1][col - 1].change_value(new_value)
  end

  def display
    @grid.each do |row|
      row.each do |tile|
         print " #{tile.to_s} "
      end
      puts
    end
    nil
  end

  def solved?
    test_array = (1..9).to_a

    rows.all? { |row| row.sort == test_array }          &&
    columns.all? { |col| col.sort == test_array }       &&
    squares.all? { |square| square.sort == test_array }
  end

  private

    def rows
      @grid.map { |row| row.map(&:value) }
    end

    def columns
      @grid.transpose.map { |col| col.map(&:value) }
    end

    def squares
      squares_array = []
      (1..3).each do |row|
        (1..3).each do |col|
          squares_array << square([3*row,3*col])
        end
      end
      squares_array.map { |square| square.map(&:value) }
    end

    def square(pos)
      row, col = pos
      square = []

      (0..2).each do |i|
        (0..2).each do |j|
          square << self[[(row - i), (col - j)]]
        end
      end

      square
    end


end
