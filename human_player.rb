class HumanPlayer
  def initialize(game)
    @game = game
  end

  def guess(round)
    puts "What is your guess?"
    @guess = gets.chomp.gsub(/\s+/, '').upcase.split('')
    @game.guess_log[round] = @guess
  end

end