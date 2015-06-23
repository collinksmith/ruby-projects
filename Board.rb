class Board
  def initialize(size)
    @grid = build_grid(size)
  end

  def build_grid(size)
    possible_cards = (1..(size**2/2)).to_a
    pairs = (possible_cards * 2).shuffle
    Array.new(size) { Array.new(size) { Card.new(pairs.pop) } }
  end

  def render
    @grid.each do |rowset|
      rowset.each do |cell|
        print cell
      end
      puts
    end
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end

  def won?
    @grid.each do |rowset|
      return false unless rowset.all? { |cell| cell.hidden == false }
    end
    true
  end

  def reveal(guessed_pos)
    self[*guessed_pos].reveal
  end
end
