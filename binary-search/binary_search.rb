class Node
  attr_accessor :value
  def initialize(value, parent, options = {})
    @value = value
    @parent = parent
    @lchild = options[:lchild]
    @rchild = options[:rchild]
  end

  def parent
    @parent
  end
  def parent=(parent)
    @parent = parent
  end

  def lchild
    @lchild
  end
  def lchild=(lchild)
    @lchild = lchild
  end

  def rchild
    @rchild
  end
  def rchild=(rchild)
    @rchild = rchild
  end

  def display
    puts @value
    unless @lchild.nil?
      print "#{@value}'s left tree: "
      @lchild.display
    end
    unless @rchild.nil?
      print "#{@value}'s right tree: "
      @rchild.display
    end
  end

  def to_s
    "#{@value}"
  end
end

def test_node(node, new_value)
  if new_value < node.value
    if node.lchild.nil?
      node.lchild = Node.new(new_value, node)
    else
      test_node(node.lchild, new_value)
    end
  else
    if node.rchild.nil?
      node.rchild = Node.new(new_value, node)
    else
      test_node(node.rchild, new_value)
    end
  end
end

def build_tree(array)
  tree = Node.new(array[0], nil)
  array[1..-1].each do |e|
    test_node(tree, e)
  end
  tree
end

def breadth_first_search(value, root)
  queue = [root]
  until queue.empty?
    node = queue.shift
    return node if value == node.value
    queue.push(node.lchild) if node.lchild
    queue.push(node.rchild) if node.rchild
  end
  nil
end

def depth_first_search(value, root)
  stack = [root]
  until stack.empty?
    node = stack.pop
    return node if value == node.value
    stack.push(node.lchild) if node.lchild
    stack.push(node.rchild) if node.rchild
  end
  nil
end

def dfs_rec(value, node)
  return node if value == node.value
  a = dfs_rec(value, node.lchild) if node.lchild
  return a if a
  b = dfs_rec(value, node.rchild) if node.rchild
  return b if b
  nil
end

t = build_tree([22, 5, 2, 19, 14, 11, 17, 30, 28, 372, 24, 78, 36])

puts breadth_first_search(22, t)
puts depth_first_search(36, t)
puts dfs_rec(17, t)