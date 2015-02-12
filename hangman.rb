class Game
  attr_accessor :wordlist, :word
  def initialize
    @wordlist = File.read('wordlist.txt')
    @word = select_words
  end

  def select_words
    @wordlist = @wordlist.split("\n")
    @wordlist.select! { |word| word.strip.length.between?(5,12) }
    @wordlist[rand(@wordlist.length)].strip
  end
end


game = Game.new
puts game.word