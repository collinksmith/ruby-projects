class ComputerPlayer
  attr_accessor :selected_colors

  def initialize(game)
    @game = game
    @selected_colors = []
  end

  def select_colors
    4.times {@selected_colors.push(COLORS[rand(6)])}
  end

  def check_guesses(round)
    @correct = []
    @game.human.selected_colors.each_with_index do |color, index|
      @correct.push(index) if @game.guess_log[round-1][index] == color
    end
    @correct
  end

  def guess(round)
    @guess = []
    4.times {@guess.push(COLORS[rand(6)])}
    if round > 1
      @correct = check_guesses(round)
      @correct.each {|i| @guess[i] = @game.guess_log[round-1][i]}
    end
    @game.guess_log[round] = @guess
  end
end
