require_relative 'game'
require_relative 'human_player'
require_relative 'computer_player'

COLORS = ['R', 'O', 'Y', 'G', 'B', 'P']

def play_game
  puts "How many rounds? (default is 12)"
  total_rounds = gets.chomp.to_i
  game = Game.new(total_rounds)
  round = 1
  game.display_board
  until round == total_rounds
    game.human.guess(round)
    game.computer.give_clues(round)
    game.display_board
    round += 1
  end
end
play_game