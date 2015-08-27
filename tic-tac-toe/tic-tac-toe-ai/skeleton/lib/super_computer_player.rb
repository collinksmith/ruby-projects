require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    current_node = TicTacToeNode.new(game.board.dup, mark)

    winner = current_node.children.find { |kid| kid.winning_node?(mark) }
    return winner unless winner.nil?

    draw = current_node.children.find { |kid| !kid.losing_node?(mark) }
    return draw unless draw.nil?

    raise "Imperfection!"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
