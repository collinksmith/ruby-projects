Dir['./*'].each { |file| require_relative file }

class Game
  def initialize(players)
    @init_players = players
    @players = players
    @dealer_pos = 0
    @deck = Deck.new
    @pot = 0
    @current_bet = 0
  end

  def play
    until over?
      play_hand
    end
    puts "#{winner.name} wins with #{winner.bank} in the bank!"
  end

  def over?
    players.select { |player| player.bank > 0 }.count <= 1
  end

  def winner
    players.first
  end

  def play_hand
    deck.shuffle
    deal

    play_round

    current_players.each do |player|
      num_cards = player.get_num_cards(deck)
      player.give_cards(deck.take(num_cards))
    end

    play_round

    distribute_pot
    display_results
    unfold_players
    return_all_cards

    update_players!
    switch_players!
  end

  def play_round
    current_players.each do |player|
      begin
        display_info(player)
        input = player.get_input
        process_input(input, player)
      rescue BetError => e
        puts e.message
        retry
      end
    end

    @current_bet = 0
  end

  def display_info(player)
    puts
    puts "#{player.name}'s turn."
    print "Your hand is "
    puts player.hand 
    puts "The current bet is #{current_bet}"
    puts "The pot is #{pot} and you have #{player.bank} in the bank."
    puts
  end

  def display_results
    puts "\n----------"
    puts "#{hand_winner.name} won this hand with a #{hand_winner.hand.type}"
    puts "Here was everyone's hand:"
    current_players.each do |player|
      puts "#{player.name}: #{player.hand} #{player.hand.type}"
    end
    puts "----------\n"
  end

  def process_input(input, player)
    case input
    when :fold
      player.fold
    when :call
      raise BetError.new("Can't call when there's no current_bet") if current_bet == 0
      handle_bet(player, current_bet)
    when :raise
      raise BetError.new("Can't raise when there's no current_bet") if current_bet == 0
      raise_amt = player.get_bet(:raise)
      new_bet = current_bet + raise_amt
      set_current_bet(new_bet)
      handle_bet(player, new_bet)
    when :bet
      bet_amt = player.get_bet(:bet)
      set_current_bet(bet_amt)
      handle_bet(player, bet_amt)
    when :check
    end
  end

  def return_all_cards
    players.each do |player|
      player.hand.return_cards([0,1,2,3,4], deck)
    end
  end

  def set_current_bet(amt)
    @current_bet = amt
  end

  def handle_bet(player, amt)
    player.bet(amt)
    @pot += amt
  end

  def deal
    players.each { |player| player.hand = Hand.deal_from(deck)}
  end

  def current_player
    players.first
  end

  def switch_players!
    if @dealer_pos >= players.length
      @dealer_pos = 0
    else
      @dealer_pos += 1
    end
  end

  def update_players!
    @players = players.select { |player| player.bank > 0 }
  end

  def current_players
    these_players = players.select { |player| !player.folded? }
    dealer_pos.times { these_players.rotate! }
    these_players
  end

  def distribute_pot
    hand_winner.get_winnings(pot)
    @pot = 0
  end

  def unfold_players
    players.each { |player| player.folded = false }
  end

  def hand_winner
    current_players.select do |player|
      other_players = current_players - [player]
      return player if other_players.all? { |other_player| player.hand.beats?(other_player.hand) }
    end

    raise "didn't find a winner!"
  end

  private

  attr_accessor :init_players, :pot
  attr_reader :deck, :current_bet, :dealer_pos, :players
end


p1 = Player.new("Bob")
p2 = Player.new("Joe")
p3 = Player.new("Alan")
g = Game.new([p1, p2, p3])
g.play