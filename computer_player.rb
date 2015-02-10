class ComputerPlayer
  attr_accessor :selected_colors

  def initialize(game)
    @game = game
    @selected_colors = []
  end

  def select_colors
    4.times {@selected_colors.push(COLORS[rand(6)])}
  end

  def give_clues(round)
    @guess = @game.guess_log[round].clone
    @clues = ['_', '_', '_', '_']
    @correct_colors = 0
    @correct_spots = 0
    @temp_selected_colors = @selected_colors.clone
    @temp_guess = @guess.clone

    @selected_colors.each_with_index do |color, index|
      if color == @guess[index]
        @correct_spots += 1
        @temp_selected_colors.delete_at(@temp_selected_colors.index(color))
        @temp_guess.delete_at(@temp_guess.index(color))
      end
    end
    @temp_guess.each do |color|
      if @temp_selected_colors.any? {|e| e==color}
        @correct_colors += 1
        @temp_selected_colors.delete_at(@temp_selected_colors.index(color))
      end
    end
    @correct_spots.times {|i| @clues[i] = '!'}
    @correct_colors.times {|i| @clues[i+@correct_spots] = '?' }
    @game.clue_log[round] = @clues
  end
end
