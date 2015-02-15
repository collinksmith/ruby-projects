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
    @value
  end

  def to_a
    Array.new(self)
  end

  def empty?
    false
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

def breadth_check(value, node, queue)
  if node.lchild
    if value == node.lchild.value
      queue = []
      return [queue, node.lchild]
    end
    queue.push(node.lchild)
  end
  if node.rchild
    if value == node.rchild.value
      queue = []
      return [queue, node.rchild]
    end
    queue.push(node.rchild)
  end
  queue
end

def breadth_first_search(value, node)
  queue = []
  return node if value == node.value
  breadth_check(value, node, queue)
  i = 10
  while queue
    if queue.is_a?(Array)
      break if queue.empty?
      res = breadth_check(value, queue[0], queue[1..-1])
      queue = res[0]
    elsif queue
      res = breadth_check(value, queue, [])
      queue = res[0]
    end
  end
  if res
    return res[1]
  else
    return nil
  end
end

t = build_tree([22, 5, 2, 19, 14, 11, 17, 30, 28, 372, 24, 78, 36])
# t.display
p breadth_first_search(14, t).value

