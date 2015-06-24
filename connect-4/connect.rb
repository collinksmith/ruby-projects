require_relative 'board'
require_relative 'human_player'
require_relative 'array'

class ConnectFour

  def initialize(player1, player2)
    @board = Board.new
    # @players = [player1, player2]
    @player1 = player1
    @player2 = player2
    @current_player = player1
  end

  def play
    until @board.over?
      @board.display
      play_turn(@current_player)
      switch_current_player
    end

    @board.display
    # puts "#{players.last.symbol}"
    puts "#{@board.over?} wins!"
  end

  def play_turn(player)
    input = player.prompt
    make_move(input)
  end

  def player_disc(player)
    player == @player1 ? :x : :o
  end

  def make_move(input)
    disc = player_disc(@current_player)
    @board.drop_disc(input, disc)
  end

  def switch_current_player
    # @player.rotate!
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end
