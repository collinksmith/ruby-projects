class Game
  def initialize
    @board = Board.new
    @white_player = Player.new(@board, :white)
    @black_player = Player.new(@board, :black)
  end
end