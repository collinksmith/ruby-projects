class Board

  ROW_COUNT = 8
  COL_COUNT = 8

  def initialize
    @grid = Array.new(ROW_COUNT) { Array.new(COL_COUNT) }
    @solution_count = 0
    @conflicts
    place_queens
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, value)
    @grid[row][col] = value
  end

  def place_queens
    # x = 0
    y = 0
    while y < COL_COUNT
      x = (0..ROW_COUNT).to_a.sample
      @grid[x, y] = "Q"
      y += 1
    end
  end

  def render
    p @grid
  end

  def move

  end

  def check_line(array)
    array.count { |el| el == "Q" } - 1
  end

  def conflicts(row, col)
    @conflicts = check_line(@grid[row]) +
    check_line(@grid.transpose[col]) +
    check_line(left_diag(row, col)) +
    check_line(right_diag(row, col))
  end

  def left_diag(row, col)
    diag = []
    i = m = row
    j = n = col
    while on_board?(i, j)
      diag << @grid[i, j]
      i += 1
      j += 1
    end
    while on_board?(m, n)
      diag << @grid[m, n]
      m -= 1
      n -= 1
    end
    diag.uniq!
  end

  def right_diag(row, j)
    diag = []
    i = m = row
    j = n = col
    while on_board?(i, j)
      diag << @grid[i, j]
      i += 1
      j -= 1
    end
    while on_board?(m, n)
      diag << @grid[m, n]
      m -= 1
      n += 1
    end
    diag.uniq!
  end

  def on_board?(row, col)
    row.between?(0, ROW_COUNT) && col.between?(0, COL_COUNT)
  end

  def run
    while solution_count != 92
      move
    end
  end

end
