require_relative '00_tree_node'

class KnightPathFinder
  attr_reader :visited_positions
  MOVES = [[1,2], [2,1], [-1, 2], [2, -1], [1, -2], [-2, 1], [-1, -2], [-2, -1]]

  def self.valid_moves(pos)
    new_moves = MOVES.map { |array| [pos[0] + array[0], pos[1] + array[1]] }
    new_moves.select { |move| move.all? {|num| num.between?(0,7) } }
  end

  def initialize(start_pos)
    start_node = PolyTreeNode.new(start_pos)
    @visited_positions = [start_node]

    build_move_tree
  end

  def build_move_tree
    queue = [@visited_positions.first]
    until queue.empty?
      # p queue.map { |node| node.value }
      current = queue.shift
      new_move_positions(current)
      queue.concat(current.children)
    end
  end

  def find_path(target)
    queue = [@visited_positions.first]
    until queue.empty?
      current_pos = queue.shift
      if current_pos.value == target
        final_node = current_pos
        break
      end
      queue.concat(current_pos.children)
    end
    p path_array(final_node)
  end

  def path_array(final_node)
    return [] unless final_node
    path_array(final_node.parent) << final_node.value
  end

  def new_move_positions(pos)
    valid_moves = KnightPathFinder.valid_moves(pos.value)

    visited_positions.each do |visited_pos|
      valid_moves.delete_if { |new_pos| new_pos == visited_pos.value }
    end

    valid_moves.map! { |move| PolyTreeNode.new(move) }
    valid_moves.each { |node| node.parent = pos }
    visited_positions.concat(valid_moves)
    valid_moves
  end




end


KnightPathFinder.new([0,0]).find_path([7,6])
KnightPathFinder.new([0,0]).find_path([6,2])
