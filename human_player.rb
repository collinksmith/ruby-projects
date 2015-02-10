class HumanPlayer
  attr_accessor :selected_colors

  def initialize(game)
    @game = game
  end

  def check_guesses(guess)
    if guess.all?{|color| color =~ /[ROYGBP]/} && guess.length == 4
      guesses_ok = true
    else
      guesses_ok = false
    end
    unless guesses_ok 
      raise ArgumentError, "Invalid input, try again. Please type exactly four of R O Y G B P"
    end
  end

  def guess(round)
    begin
      puts "What is your guess?"
      @guess = gets.chomp.gsub(/\s+/, '').upcase.split('')
      check_guesses(@guess)
      @game.guess_log[round] = @guess
    rescue ArgumentError => e
      puts e
      retry
    end
  end

  def select_colors
    begin
      puts "Which colors do you select?"
      @selected_colors = gets.chomp.gsub(/\s+/, '').upcase.split('')
      check_guesses(@selected_colors)
    rescue ArgumentError => e
      puts e
      retry
    end
  end
end
