require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if board.over?
      if board.tied?
        result = false
      else
        result = board.winner != evaluator
      end
      return result
    end

    check_losing = Proc.new { |child| child.losing_node? (evaluator) }

    if next_mover_mark == evaluator
      children.all?(&check_losing)
    else
      children.any?(&check_losing)
    end
  end

  def winning_node?(evaluator)
    return board.winner == evaluator if board.over?

    check_winning = Proc.new { |child| child.winning_node?(evaluator) }

    if next_mover_mark == evaluator
      children.any?(&check_winning)
    else
      children.all?(&check_winning)
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    nodes = []
    board.rows.each_with_index do |row, r_index|
      row.each_with_index do |cell, c_index|
        if cell.nil?
          new_board = board.dup
          new_board[[r_index, c_index]] = next_mover_mark
          nodes << TicTacToeNode.new(new_board, get_next_mover, [r_index, c_index])
        end
      end
    end

    nodes
  end

  def get_next_mover
    next_mover_mark == :x ? :o : :x
  end
end
