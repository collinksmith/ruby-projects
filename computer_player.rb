class ComputerPlayer
  attr_accessor :selected_colors

  def initialize(game)
    @game = game
    @selected_colors = []
  end

  def select_colors
    4.times {@selected_colors.push(COLORS[rand(6)])}
  end

  def guess(round)
    @guess = []
    4.times {@guess.push(COLORS[rand(6)])}
    @game.guess_log[round] = @guess
  end
end
