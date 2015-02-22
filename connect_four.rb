require_relative 'board'
require_relative 'cell'
require_relative 'player'


def new_game
  board = Board.new
  player_x = Player.new('X', board)
  player_o = Player.new('O', board)
  return player_x, player_o, board
end

def choose_column(player)
  puts "Player #{player.token}: Which column do you wan to play in? (1-7)"
  begin
    column = gets.chomp.strip.to_i
    raise ArgumentError, "Invalid column. Try again." unless 1 <= column && column <= 7
    player.play(column)
  rescue ArgumentError => e
    puts e.message
    retry
  end
end

def end_game
  puts "Do you want to play again? (y/n)"
  again = gets.chomp.strip.downcase
  play_game if again == 'y'
end

def play_game
  player_x, player_o, board = new_game
  board.display
  until board.game_over
    choose_column(player_x)
    board.check_status
    break if board.game_over
    board.display
    choose_column(player_o)
    board.check_status
    board.display
  end
  puts board.check_status
  end_game
end

play_game if $0 == __FILE__