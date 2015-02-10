require_relative 'human_player'
require_relative 'computer_player'

class Game
  attr_accessor :guess_log, :clue_log, :human, :computer, :game_over

  def initialize(rounds=12)
    @game_over = false
    @rounds = rounds
    @human = HumanPlayer.new(self)
    @computer = ComputerPlayer.new(self)
    @guess_log = Hash.new(' ')
    @clue_log = Hash.new(' ')
    @rounds.times do |i|
      @guess_log[(i+1)] = ['_', '_', '_', '_']
      @clue_log[(i+1)] = ['_', '_', '_', '_']
    end
  end

  def display_board
    puts "    Guesses | Results"
    @rounds.times do |i|
      puts "#{(i+1).to_s.ljust(3)} #{@guess_log[(i+1)].join(' ')} | #{@clue_log[(i+1)].join(' ')}"
    end
  end

  def check_status(round)
    if @guess_log[round] == computer.selected_colors
      puts "You win! Congratulations!"
      @game_over = true
    elsif round == @rounds
      puts "Time's up. You lose. =("
      @game_over = true
    end
  end

  def give_clues(round, guesser)
    guesser == 'human' ? @chooser = @computer : @chooser = @human
    puts "TEST: Trying to clone: #{guess_log[round]}"
    puts "Total guess log is: #{guess_log}"
    @guess = guess_log[round].clone
    @clues = ['_', '_', '_', '_']
    @correct_colors = 0
    @correct_spots = 0
    @temp_selected_colors = @chooser.selected_colors.clone
    @temp_guess = @guess.clone

    @chooser.selected_colors.each_with_index do |color, index|
      if color == @guess[index]
        @correct_spots += 1
        @temp_selected_colors.delete_at(@temp_selected_colors.index(color))
        @temp_guess.delete_at(@temp_guess.index(color))
      end
    end
    @temp_guess.each do |color|
      if @temp_selected_colors.any? {|e| e==color}
        @correct_colors += 1
        @temp_selected_colors.delete_at(@temp_selected_colors.index(color))
      end
    end
    @correct_spots.times {|i| @clues[i] = '!'}
    @correct_colors.times {|i| @clues[i+@correct_spots] = '?' }
    @clue_log[round] = @clues
  end

end

if $0 == __FILE__
  test = Game.new
  test.display_board
end
