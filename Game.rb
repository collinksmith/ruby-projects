require_relative 'Board'
require_relative 'Card'
require_relative 'HumanPlayer'

class Game
  attr_reader :guessed_pos
  def initialize(turns, size, player)
    @board = Board.new(size)
    @guessed_pos = nil
    @turns = turns
    @player = player
  end

  def play

    turn = 0
    while turn < @turns
      system("clear")
      @board.render
      input = @player.get_input
      @player.handle_input(input, @board[*input].value)
      make_guess(input)
      if @board.won?
        puts "You Win!"
        break
      end
      turn += 1
    end
    puts "You lose" if turn == @turns
  end

  def make_guess input
    # p @guessed_pos
    # p input
    # p @board[*input]
    if @guessed_pos.nil?
      @board[*input].reveal
      @guessed_pos = input
    else
      @board[*input].reveal
      @board.render
      sleep(3)
      if @board[*guessed_pos].value != @board[*input].value
        @board[*input].hide
        @board[*guessed_pos].hide
      else
        player.handle_match(@board[*input], @board[*guessed_pos])
      end
      @guessed_pos = nil
    end

  end
end

if __FILE__ == $PROGRAM_NAME
  begin
    print "Enter Board Size: "
    size = gets.chomp.to_i
    raise unless size.even?
  rescue
    puts "Board size must be an even number."
    retry
  end
  game = Game.new(size**2,size, HumanPlayer.new)
  game.play
end
