class HumanPlayer
  attr_accessor :selected_colors

  def initialize(game)
    @game = game
  end

  def guess(round)
    puts "What is your guess?"
    @guess = gets.chomp.gsub(/\s+/, '').upcase.split('')
    @game.guess_log[round] = @guess
  end

  def select_colors
    puts "Which colors do you select?"
    @selected_colors = gets.chomp.gsub(/\s+/, '').upcase.split('')
  end

end