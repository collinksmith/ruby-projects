require_relative 'human_player'
require_relative 'computer_player'

class Game
  attr_accessor :guess_log, :human, :computer

  def initialize(rounds=12)
    @rounds = rounds
    @human = HumanPlayer.new(self)
    @computer = ComputerPlayer.new(self)
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

end

if $0 == __FILE__
  test = Game.new
  test.display_board
end
