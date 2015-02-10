class ComputerPlayer

  def initialize
    @selected_colors = []
  end

  def select_colors
    4.times {@selected_colors.push(COLORS[rand(6)])}
  end


end
