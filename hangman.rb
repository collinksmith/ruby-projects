class Game
  attr_accessor :word, :display_word, :guesses, :status, :player, :playing
  def initialize
    @wordlist = File.read('wordlist.txt')
    @word = select_words
    @display_word = "_" * @word.length
    @guesses = 8
    @player = Player.new(self)
    @playing = true
  end

  def select_words
    @wordlist = @wordlist.split("\n")
    @wordlist.select! { |word| word.strip.length.between?(5,12) }
    @wordlist[rand(@wordlist.length)].strip.downcase
  end

  def check_status
    if @display_word.split(' ').join == @word
      puts "Congratulations, you win!"
      @playing = false
    elsif @guesses == 0
      puts "Sorry, you lose."
      @playing = false
    else
    end
  end

  def display
    puts @display_word.split('').join(' ')
    puts "#{@guesses} guesses remaining." if @playing == true
  end
end

class Player

  def initialize(game)
    @game = game
    @word = game.word
  end

  def guess
    puts "Guess a letter!"
    begin
      @choice = gets.chomp.downcase
      unless @choice.length == 1 && @choice =~ /[a-z]/
        raise ArgumentError, "Invalid guess. Please type a single letter."
      end
    rescue ArgumentError => e
      puts e
      retry
    end
  end

  def check_guess
    if @word =~ /#{@choice}/
      puts "Correct!"
      positions = []
      @word.split('').each_with_index { |letter, index| positions << index if letter == @choice}        
      positions.each {|index| @game.display_word[index] = "#{@choice}"}
    else
      puts "Wrong."
      @game.guesses -= 1
    end

  end

end

def new_game
  game = Game.new
  puts "For testing: The word is #{game.word}"
  until game.playing == false
    game.player.guess
    game.player.check_guess
    game.check_status
    game.display
  end
  puts "Do you want to play again? (y/n)"
  begin
    again = gets.chomp.downcase
    if again == 'y'
      new_game() 
    elsif again == 'n'
    else 
      raise ArgumentError, "Invalid"
    end
  rescue ArgumentError => e
    puts e
    retry
  end

end

new_game