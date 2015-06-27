require_relative 'board'
require_relative 'node_memory'

class Node
  attr_reader :board, :remaining_coords, :memory

  def initialize(board, remaining_coords = nil, memory)
    @memory = memory
    @board = board
    @remaining_coords = remaining_coords || [(0..(board.size-1)).to_a, (0..(board.size-1)). to_a]
    @seen_boards = []
  end

  def find_solution
    if board.queen_count == board.size && !memory.seen_boards.include?(board.grid)
      memory.seen_boards << board.grid
      return [board]
    end

    solutions = []
    children.each { |child| solutions += child.find_solution }

    solutions
  end

  def children
    nodes = []

    @remaining_coords[0].each do |row|
      @remaining_coords[1].each do |cell|
        if board.diagonal_clear?([row, cell])
          nodes << create_new_node(row, cell)
        end
      end
    end

    nodes
  end

  def create_new_node(row, cell)
    new_board = board.dup(board.size)
    new_board[row, cell] = :q
    new_coords = [@remaining_coords[0] - [row], @remaining_coords[1] - [cell]]
    Node.new(new_board, new_coords, memory)
  end
end

if __FILE__ == $PROGRAM_NAME
  start_time = Time.now

  board = Board.new(5)
  node = Node.new(board, NodeMemory.new)

  solutions = node.find_solution
  solutions.each{ |solution| solution.render }

  puts "Found #{solutions.count} solutions."
  puts "Took #{Time.now - start_time} seconds."
end