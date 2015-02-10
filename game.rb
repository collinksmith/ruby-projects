class Game
  def initialize(rounds=12)
    @rounds = rounds
    @guess_log = Hash.new(' ')
    @clue_log = Hash.new(' ')
    @rounds.times do |i|
      @guess_log[(i+1).to_s] = ['_', '_', '_', '_']
      @clue_log[(i+1).to_s] = ['_', '_', '_', '_']
    end


  end

  def display_board
    puts "    Guesses | Results"
    @rounds.times do |i|
      puts "#{(12-i).to_s.ljust(3)} #{@guess_log[(i+1).to_s].join(' ')} | #{@clue_log[(i+1).to_s].join(' ')}"
    end
  end

end

if $0 == __FILE__
  test = Game.new
  test.display_board
end
