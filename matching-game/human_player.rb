class HumanPlayer
  def get_input
    print "Enter a guess ex(1,3)"
    gets.chomp.split(",").map { |n| n.to_i  - 1}
  end

  def handle_match(pos1, pos2, value)
    puts "Correct!"
  end

  def handle_input(location, value)
  end
end
