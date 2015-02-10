class HumanPlayer
  def initialize

  end

  def guess
    puts "What is your guess?"
    @guess = gets.chomp.split(',')
    @guess.map! {|color| color.strip}
  end

end