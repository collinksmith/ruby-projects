class HumanPlayer
  def prompt
    puts "Which column do you want to play?"
    gets.chomp.to_i
  end
end
