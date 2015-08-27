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
