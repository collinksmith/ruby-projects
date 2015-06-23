class HumanPlayer
  def get_input
    print "Enter a guess ex(1,3)"
    gets.chomp.split(",").map { |n| n.to_i  - 1}
  end

  def handle_match(match1, match2)
    puts "Correct!"
  end
end
