require 'yaml'

class Game
  attr_accessor :word, :display_word, :guesses, :status, :player, :playing
  def initialize
    @wordlist = File.read('wordlist.txt')
    @word = select_word
    @display_word = "_" * @word.length
    @guesses = 7
    @player = Player.new(self)
    @playing = true
  end

  def select_word
    @wordlist = @wordlist.split("\n")
    @wordlist.select! { |word| word.strip.length.between?(5,12) }
    @wordlist[rand(@wordlist.length)].strip.downcase
  end

  def check_status
    if @display_word.split(' ').join == @word
      puts "Congratulations, you win!"
      @playing = false
    elsif @guesses == 0
      puts "Sorry, you lose. The word was #{@word}."
      @playing = false
    else
    end
  end

  def display
    puts @display_word.split('').join(' ')
    puts "#{@guesses} guesses remaining." if @playing == true
  end

  def save_game
    yaml = YAML::dump(self)
    save_file = File.new('save_file.yaml', 'w')
    save_file.write(yaml)
    save_file.close
  end
end

class Player

  def initialize(game)
    @game = game
    @word = game.word
  end

  def guess
    puts "Guess a letter"
    begin
      @choice = gets.chomp.downcase.strip
      unless (@choice.length == 1 && @choice =~ /[a-z]/) || @choice == 'save' || @choice == 'quit' || @choice == 'load'
        raise ArgumentError, "Invalid guess. Please type a single letter."
      end
    rescue ArgumentError => e
      puts e
      retry
    end
  end

  def check_guess
    if @choice == 'save'
      @game.save_game
      guess
    elsif @choice == 'load'
      load_game
    elsif @choice == 'quit'
      exit
    elsif @word =~ /#{@choice}/
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

def play_game
  puts "Start a new game or load a game? (new/load)"
  game = new_or_load
  until game.playing == false
    game.player.guess
    game.player.check_guess
    game.check_status
    game.display
  end
  end_game
end

def new_or_load
  begin
    choice = gets.chomp.strip.downcase
    if choice == 'new'
      game = Game.new
      game.display
      return game
    elsif choice == 'load'
      load_game
    else
      raise ArgumentError, "Invalid choice. Please type 'new' or 'load'"
    end
  rescue ArgumentError => e
    puts e
    retry
  end
end

def load_game
  save_file = File.open('save_file.yaml', 'r')
  yaml = save_file.read
  game = YAML::load(yaml)
  game.display
  return game
end

def end_game
  puts "Do you want to play again? (y/n)"
  begin
    again = gets.chomp.downcase
    if again == 'y'
      play_game
    elsif again == 'n'
    else 
      raise ArgumentError, "Invalid"
    end
  rescue ArgumentError => e
    puts e
    retry
  end
end

puts "Welcome to the hangman game. At any time, you can type 'save' to save your game, "\
      "or 'load' to go back to the save. You can only have one saved game at a time."
play_game