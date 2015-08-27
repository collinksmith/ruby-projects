require 'set'
require 'byebug'
require_relative 'player.rb'
require_relative 'computer_player.rb'

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

player1 = Player.new("Joe")
player2 = Player.new("Steve")
player3 = ComputerPlayer.new("Bob")
game = Game.from_file([player1, player2, player3], 'ghost-dictionary.txt')
game.run
