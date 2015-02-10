class HumanPlayer
  def initialize(game)
    @game = game

  end

  def guess(round)
    puts "What is your guess?"
    @guess = gets.chomp.upcase.split()
    @guess.map! {|color| color.strip}
    @game.guess_log[round] = @guess
  end

end