def new_game
  board = Board.new
  player_x = Player.new('X', board)
  player_o = Player.new('O', board)
end