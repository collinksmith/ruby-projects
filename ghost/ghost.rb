require 'set'
require 'byebug'

class Game
  attr_reader :fragment

  def initialize(players, dictionary)
    @fragment = ''
    @players = players
    @dictionary = dictionary
  end

  def self.from_file(players, file)
    dictionary = Set.new(File.readlines(file).map { |line| line.chomp })

    self.new(players, dictionary)
  end

  def give_players
    @players.each do |player|
      player.num_players = @players.length
    end
  end

  def run
    until @players.length == 1
      give_players
      play_round
      display_standings
      @players.select! { |player| player.losses < 5 }
    end
    puts "#{@players.first.name} wins!"
  end

  private

    def display_standings
      @players.each do |player|
        puts record(player)
      end
    end

    def record(player)
      string = "GHOST"

      print "#{player}: "
      player.losses.times do |i|
        print string[i]
      end
      puts
    end

    def play_round
      until round_over?
        render
        take_turn(current_player)
        next_player!
      end
      previous_player.losses += 1
      @fragment = ''
    end

    def round_over?
      # tests whether a dictionary word equals the fragment
      @dictionary.any? { |word| word == @fragment }
    end

    def current_player
      @players.first
    end

    def previous_player
      @players.last
    end

    def next_player!
      @players.rotate!
    end

    def render
      puts @fragment
      puts "It is #{current_player}'s turn"
    end

    def take_turn(player)
      # get input from the Player
      direction = player.get_direction
      input = player.get_input(@fragment, @dictionary)
      until valid?(input) && valid_dictionary?(input, direction)
        if !valid?(input)
          player.alert_letter
        elsif !valid_dictionary?(input, direction)
          player.alert_dictionary
        end
        direction = player.get_direction
        input = player.get_input(@fragment, @dictionary)
      end
      modify_fragment(input, direction)
    end

    def modify_fragment(input, direction)
      if direction == 'back'
        @fragment += input
      else
        @fragment = input + @fragment
      end
    end

    def valid?(input)
      input.length == 1 && ("a".."z").include?(input)
    end

    def valid_dictionary?(input, direction)
      p input
      if direction == 'back'
        test_fragment = @fragment + input
      else
        test_fragment = input + @fragment
      end
      @dictionary.any? { |word| word.start_with?(test_fragment) || word.end_with?(test_fragment) }
    end
end

class Player
  attr_accessor :losses, :num_players

  def initialize(name)
    @name = name
    # in future, create a hash that keys players into their losses.
    # maybe also use the Hash.new() { |h, k| h[k] = 0 } constructor
    @losses = 0
    @num_players = 0
  end

  def to_s
    "#{@name}"
  end

  def get_input(current_fragment, dictionary)
    puts "What letter would you like to add to the fragment? (a-z)"
    gets.chomp.downcase
  end

  def get_direction
    # rescue block to handle invalid direction inputs
    begin
      puts "Do you want to append to the beginning or the end? ('front'/'back')"
      direction = gets.chomp
      raise ArgumentError.new("Invalid direction") unless direction == 'front' || direction == 'back'
    rescue => e
      puts e.message
      retry
    end

    direction
  end

  def alert_letter
    puts "Invalid input. Plase enter a letter."
  end

  def alert_dictionary
    puts "That letter doesn't lead to any possible words! Try again."
  end
end

class ComputerPlayer < Player

  def initialize(name="Computer")
    super(name)
    @direction = nil
  end

  def get_input(current_fragment, dictionary)
    # until (some condition)
    if winning_move_back(current_fragment, dictionary) || winning_move_front(current_fragment, dictionary)
      puts "executed winning move"
      return winning_move_back(current_fragment, dictionary) || winning_move_front(current_fragment, dictionary)
    elsif only_losing_move?(current_fragment, dictionary)
      return losing_move(current_fragment, dictionary)
    else
      puts "executed a random move"
      random_move(current_fragment, dictionary)
    end
  end


  def select_letter(current_fragment)
    only_losing_move?
    get_direction
    letter = ("a".."z").to_a.sample
    temp_fragment = current_fragment
    if @direction == "back"
      temp_fragment + letter
    else
      letter + temp_fragment
    end
  end

  def get_direction
    new_direction = ["front", "back"].sample
    @direction = new_direction
    new_direction
  end

  def winning_move_back(fragment, dictionary)
    # we need to make sure the computer does not select a losing move here with the third condition in the select block
    dict_subset = dictionary.select { |word| word.start_with?(fragment) }
    unique_next_letters = dict_subset.map { |word| word[fragment.length] }.uniq

    unique_next_letters.each do |letter|
      temp_fragment = fragment + letter
      if dict_subset.select { |word| word.start_with?(temp_fragment) }.all? { |new_word| new_word.length.between?(fragment.length + 2, fragment.length + @num_players)}
        return temp_fragment[-1]
      end
    end
    nil
  end

  def winning_move_front(fragment, dictionary)
    # we need to make sure the computer does not select a losing move here with the third condition in the select block
    dict_subset = dictionary.select { |word| word.end_with?(fragment) }
    unique_next_letters = dict_subset.map { |word| word[-(fragment.length + 1)] }.uniq

    unique_next_letters.each do |letter|
      temp_fragment = letter + fragment
      if dict_subset.select { |word| word.end_with?(temp_fragment) }.all? { |new_word| new_word.length.between?(fragment.length + 2, fragment.length + @num_players)}
        return temp_fragment[0]
      end
    end
    nil
  end

  def random_move(fragment, dictionary)
    temp_fragment = select_letter(fragment)
    while dictionary.include?(temp_fragment)
      temp_fragment = select_letter(fragment)
    end
    if @direction == 'front'
      temp_fragment[0]
    else
      temp_fragment[-1]
    end
  end

  def possible_words(fragment, dictionary)
    dictionary.select { |word| word.start_with?(fragment) || word.end_with?(fragment) }
  end

  def only_losing_move?(fragment, dictionary)
    if possible_words(fragment, dictionary).all? { |word| word.length == fragment.length + 1 }
      true
    else
      false
    end
  end

  def losing_move(fragment, dictionary)
    if @direciton == 'front'
      possible_words(fragment, dictionary)[0][0]
    else
      possible_words(fragment, dictionary)[0][-1]
    end
  end

end

player1 = Player.new("Joe")
player2 = Player.new("Steve")
player3 = ComputerPlayer.new("Bob")
game = Game.from_file([player1, player2, player3], 'ghost-dictionary.txt')
game.run
