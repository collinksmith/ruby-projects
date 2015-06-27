class Board
  attr_accessor :grid, :queen_count, :size

  DIAGONALS = [[1, -1], [1, 1], [-1, 1], [-1, -1]]

  def initialize(size, grid = nil, queen_count = 0)
    @size = size
    @grid = grid || blank_grid
    @solution_count = 0
    @queen_count = queen_count
  end

  def blank_grid
    Array.new(size) { Array.new(size) }
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, value)
    @grid[row][col] = value
  end

  def render
    @grid.each do |row|
      puts row.map {|space| space.nil? ? " ": space }.join("|")
    end
    puts
  end

  def diagonal_clear?(pos)
    DIAGONALS.each do |diag|
      x, y = pos
      while onboard?([x, y])
        return false if self[x,y] == :q
        x += diag[0]
        y += diag[1]
      end
    end

    true
  end

  def onboard?(pos)
    pos.all? { |coord| coord.between?(0, (size-1)) }
  end

  def dup(size)
    duped_rows = grid.map(&:dup)
    self.class.new(size, duped_rows, queen_count + 1)
  end
end
