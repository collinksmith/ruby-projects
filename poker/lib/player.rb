class Player
  attr_accessor :hand, :folded
  attr_reader :bank, :name

  def initialize(name, bank = 100)
    @name = name
    @bank = bank
    @hand = nil
    @folded = false
  end

  def fold
    @folded = true
  end

  def bet(amt)
    raise BetError.new("player can't cover bet") if amt > bank
    @bank -= amt
  end

  def get_bet(bet_type)
    puts "How much do you want to #{bet_type}?"
    gets.chomp.to_i
  end

  def get_winnings(pot_amt)
    @bank += pot_amt
  end

  def get_input
    begin
      puts "What do you want to do?"
      input = gets.chomp.downcase.strip.to_sym
      unless valid_input?(input)
        raise ArgumentError.new("Invalid argument. Please type 'bet', call', 'raise', 'check', or 'fold'.")
      end
    rescue ArgumentError => e
      puts e.message
      retry
    end

    input
  end

  def get_num_cards(deck)
    begin
      puts "#{name}, which cards do you want to exchange? (Type the indices. You can select up to three.)"
      card_indicies = gets.chomp.gsub(/[, ]/, '').split('').map(&:to_i)
      raise BetError.new("Invalid selection. Try again.") unless valid_cards?(card_indicies)
    rescue BetError => e
      puts e.message
      retry
    end

    hand.return_cards(card_indicies, deck)
    card_indicies.length
  end

  def valid_input?(input)
    [:call, :check, :raise, :fold, :bet].include?(input) ? true : false
  end

  def valid_cards?(cards)
    return false unless cards.length.between?(0,3) && cards.all? { |card| card.between?(0,4) }
    true
  end

  def give_cards(cards)
    hand.add_cards(cards)
  end

  def folded?
    folded
  end

  private

  attr_reader :folded
end
