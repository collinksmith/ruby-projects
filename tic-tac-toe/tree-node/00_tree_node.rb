class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent=(node)

    @parent.children.delete(self) if @parent

    @parent = node
    @parent.children << self if @parent

  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise unless children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target)
    return self if target == value

    children.each do |child|
      result = child.dfs(target)
      return result if result
    end

    nil
  end

  def bfs(target)
    queue = [self]

    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target
      queue.concat(current_node.children)
    end

    nil
  end
end
