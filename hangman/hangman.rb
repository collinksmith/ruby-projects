require 'yaml'

class Game
  attr_accessor :word, :display_word, :guesses, :status, :player, :playing, :command, :guessed
  def initialize
    @wordlist = File.read('wordlist.txt')
    @word = select_word
    @display_word = "_" * @word.length
    @guesses = 7
    @player = Player.new(self)
    @playing = true
    @guessed = []
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
    puts "#{@display_word.split('').join(' ')}\tGuessed letters: #{@guessed.join}"
    puts "#{@guesses} guesses remaining.\n\n" if @playing == true
  end

  def save_game
    puts "Saving..."
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

  def check_for_commands
    if @choice == 'save'
      @game.save_game
      @game
    elsif @choice == 'load'
      load_game || @game
    elsif @choice == 'quit'
      exit
    else
      @game
    end
  end

  def redo?
    true if @choice == 'save' || @choice == 'load'
  end

  def check_guess
    @game.guessed << @choice
    if @word =~ /#{@choice}/
      puts "Correct!\n\n"
      positions = []
      @word.split('').each_with_index { |letter, index| positions << index if letter == @choice}        
      positions.each {|index| @game.display_word[index] = "#{@choice}"}   
    else
      puts "Wrong.\n\n"
      @game.guesses -= 1
    end
  end
end

def play_game
  puts "Start a new game or load a game? (new/load)"
  game = new_or_load
  until game.playing == false
    game.player.guess
    game = game.player.check_for_commands
    redo if game.player.redo?
    game.player.check_guess
    game.check_status
    game.display
  end
  end_game
end

def new_game
  game = Game.new
  game.display
  return game
end

def new_or_load
  begin
    choice = gets.chomp.strip.downcase
    if choice == 'new'
      new_game
    elsif choice == 'load'
      game = load_game
      game ? game : new_game
    else
      raise ArgumentError, "Invalid choice. Please type 'new' or 'load'"
    end
  rescue ArgumentError => e
    puts e
    retry
  end
end

def load_game
  if File.exist?('save_file.yaml')
    save_file = File.open('save_file.yaml', 'r')
    yaml = save_file.read
    game = YAML::load(yaml)
    game.display
    return game
  else
    puts "No save file exists."
    return false
  end
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