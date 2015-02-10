require_relative 'human_player'
require_relative 'computer_player'

class Game
  attr_accessor :guess_log, :clue_log, :human, :computer, :game_over

  def initialize(rounds=12)
    @game_over = false
    @rounds = rounds
    @human = HumanPlayer.new(self)
    @computer = ComputerPlayer.new(self)
    @computer.select_colors
    @guess_log = Hash.new(' ')
    @clue_log = Hash.new(' ')
    @rounds.times do |i|
      @guess_log[(i+1)] = ['_', '_', '_', '_']
      @clue_log[(i+1)] = ['_', '_', '_', '_']
    end
  end

  def display_board
    puts "    Guesses | Results"
    @rounds.times do |i|
      puts "#{(i+1).to_s.ljust(3)} #{@guess_log[(i+1)].join(' ')} | #{@clue_log[(i+1)].join(' ')}"
    end
  end

  def check_status(round)
    if @guess_log[round] == computer.selected_colors
      puts "You win! Congratulations!"
      @game_over = true
    elsif round == @rounds
      puts "Time's up. You lose. =("
      @game_over = true
    end
  end

end

if $0 == __FILE__
  test = Game.new
  test.display_board
end
