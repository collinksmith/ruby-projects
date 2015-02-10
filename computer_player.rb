class ComputerPlayer

  def initialize(game)
    @game = game
    @selected_colors = []
  end

  def select_colors
    4.times {@selected_colors.push(COLORS[rand(6)])}
  end

  def give_clues(round)
    @guess = @game.guess_log[round]
    @correct_colors = 0
    @correct_spots = 0

    @selected_colors.each_with_index do |color, index|
      if (color == @guess[index]) && (index == @guess[index].index)
        @correct_spots += 1
        @guess.delete_at(index)
        @selected_colors.delete_at(index)
      end
    end
    @selected_colors.each_with_index do |color, index|
      if @guess.any? {color}
        @correct_colors +=1
        @guess.delete(color)
      end
    end
  end
end
