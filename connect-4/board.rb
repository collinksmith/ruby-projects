class Board
  def initialize
    @grid = Array.new(6) { Array.new(7) }
  end

  def display
    @grid.each do |row|
      row.each do |cell|
        print " #{render_cell(cell)} "
      end
      puts
    end
    nil
  end

  def drop_disc(col_num, disc)
    col = columns[col_num]
    row = last_empty(col)

    @grid[row][col_num] = disc
  end

  def over?
      columns.each do |col|
      win_pos = col.join =~ /x{4,}|o{4,}/
      return col[win_pos] if win_pos
    end

    rows.each do |row|
      win_pos = row.join =~ /x{4,}|o{4,}/
      return row[win_pos] if win_pos
    end

    diagonals.each do |diagonal|
      win_pos = diagonal.join =~ /x{4,}|o{4,}/
      return diagonal[win_pos] if win_pos
    end

    return "Nobody" unless @grid.flatten.include?(nil)

    false
  end

  private

    def render_cell(cell)
      cell.nil? ? "_" : cell
    end

    def valid_diagonal?(diagonal)
      diagonal.all? { |pos| valid_point?(*pos) }
    end

    def valid_point?(row, col)
      row.between?(0,5) && col.between?(0,6)
    end

    def last_empty(arr)
      arr.each_with_index do |cell,idx|
        return -1 if arr[-1].nil?
        return (idx - 1) if cell
      end
    end

    def full?(col_num)
      !columns[col_num][0].nil?
    end

    def diagonals_at_point(row, col)
      diagonal_down_right, diagonal_down_left = [], []
      diagonal_up_left, diagonal_up_right = [], []

      (0..3).each do |i|
        diagonal_down_right << [row+i, col+i]
        diagonal_down_left << [row+i, col-i]
        diagonal_up_left << [row-i, col-i]
        diagonal_up_right << [row-i, col+i]
      end

      diagonals = []
      diagonals << diagonal_down_right << diagonal_down_left
      diagonals << diagonal_up_left << diagonal_up_right

      diagonals.select { |diagonal| valid_diagonal?(diagonal) }
    end

    def columns
      @grid.transpose
    end

    def rows
      @grid
    end

    def diagonals
      diagonals = []

      (0..6).each do |row|
        (0..7).each do |col|
          diagonals_at_point(row, col).each { |diagonal| diagonals << diagonal }
        end
      end

      diagonals.map do |diagonal|
        diagonal.map { |row, col| @grid[row][col] }
      end
    end
end
