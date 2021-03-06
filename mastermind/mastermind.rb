require_relative 'game'
require_relative 'human_player'
require_relative 'computer_player'

COLORS = ['R', 'O', 'Y', 'G', 'B', 'P']

def get_rounds
  puts "How many rounds? (default is 12)"
  begin
    answer = gets.chomp.to_i
    if answer == 0
      total_rounds = 12
    elsif (answer >= 1) && (answer <= 20)
      total_rounds = answer
    else
      raise ArgumentError, "Please choose a number between 1 and 20."
    end
  rescue ArgumentError => e
    puts e
    retry
  end
  total_rounds
end

def human_guesses
  total_rounds = get_rounds
  game = Game.new(total_rounds)
  game.computer.select_colors
  round = 1
  game.display_board
  until round > total_rounds
    game.human.guess(round)
    game.give_clues(round, 'human')
    game.display_board
    game.check_status(round, 'human')
    break if game.game_over
    round += 1
  end
end

def computer_guesses
  total_rounds = get_rounds
  game = Game.new(total_rounds)
  game.human.select_colors
  round = 1
  game.display_board
  until round > total_rounds
    game.computer.guess(round)
    game.give_clues(round, 'computer')
    game.display_board
    game.check_status(round, 'computer')
    break if game.game_over
    round += 1
    puts "Press Enter to continue"
    gets
  end
end
def play_game
  puts "Welcome to mastermind!\n"\
       "To select colors, type exactly 4 of R, O, Y, G, B, or P, with no commas."\
       "Spaces and capitalization are optional.\n"\
       "After guessing, exclamation points indicate a correct color and location, "\
       "and question marks indicate a correct color.\n"\
       "The position of exclamation points does not indicate which guess was in the "\
       "correct location.\n\n"
  puts "Do you want to guess or choose the secret colors? (Type 'G' or 'C')"
  guesser = gets.chomp.upcase.strip

  case guesser
  when 'G' then human_guesses
  when 'C' then computer_guesses
  else puts "That's not an option. Please restart."
  end
  puts "Do you want to play again? (y/n)"
  play_game if gets.chomp.downcase == 'y'
end
play_game