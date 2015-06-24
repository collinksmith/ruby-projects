require_relative 'board'

class Sudoku
  def initialize(file)
    @board = Board.from_file(file)
  end

  def render
    @board.display
  end

  def play
    until @board.solved?
      render
      pos = get_pos
      value = get_value
      @board[pos] = value
    end

    render
    puts "Congrats!"
  end

  private

    def get_pos
      puts "What position do you want to change? (i.e. 1,2)"
      gets.chomp.split(",").map(&:to_i)
    end

    def get_value
      puts "What is the value?"
      gets.chomp.to_i
    end
end
