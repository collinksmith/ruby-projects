require_relative 'board'
require_relative 'card'
require_relative 'human_player'
require_relative 'computer_player'

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
      display
      input = @player.get_input
      @player.handle_input(input, @board[*input].value)
      make_guess(input)
      break if game_won?
      turn += 1
    end
    puts "You lose" if turn == @turns
  end

  def display
    system("clear") if @player.is_a?(HumanPlayer)
    @board.render
  end

  def game_won?
    if @board.won?
      @board.render
      puts "You Win!"
      return true
    end
    false
  end

  def make_guess(input)
      @board[*input].reveal
    if @guessed_pos.nil?
      @guessed_pos = input
    else
      display
      sleep(1)
      check_for_match(input)
      @guessed_pos = nil
    end
  end

  def check_for_match(input)
    if @board[*guessed_pos].value != @board[*input].value
      @board[*input].hide
      @board[*guessed_pos].hide
    else
      @player.handle_match(input, guessed_pos, @board[*input].value)
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
  game = Game.new(size * (size + 10), size, ComputerPlayer.new(size))
  game.play
end
