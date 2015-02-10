require_relative 'game'
require_relative 'human_player'
require_relative 'computer_player'

COLORS = ['R', 'O', 'Y', 'G', 'B', 'P']

def play_game
  puts "How many rounds? (default is 12)"
  total_rounds = gets.chomp.to_i
  game = Game.new(total_rounds)
  round = 1
  # puts "FOR TESTING: SELECTED COLORS ARE #{game.computer.selected_colors}"
  game.display_board
  until round > total_rounds
    game.human.guess(round)
    game.computer.give_clues(round)
    game.display_board
    game.check_status(round)
    break if game.game_over
    round += 1
  end
  puts "Do you want to play again? (y/n)"
  play_game if gets.chomp.downcase == 'y'
end
play_game