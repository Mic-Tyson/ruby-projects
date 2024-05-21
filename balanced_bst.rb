class Node
  attr_accessor :val, :left, :right

  def initialize(val, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end

  def advance
    @left || @right
  end
end

def sorted?(array)
  (0...array.length - 1).each do |i|
    return false if array[i] > array[i + 1]
  end
  true
end

class BalancedBST
  attr_reader :root

  def initialize(array)
    array = array.uniq
    ArgumentError unless sorted?(array)

    @root = build_tree(array)
  end

  def build_tree(array)
    return nil if array.empty?

    mid = array.length / 2
    root = Node.new(array[mid])

    root.left = build_tree(array[0...mid])
    root.right = build_tree(array[mid + 1..])
    root
  end

  def insert(val)
    return @root = Node.new(val) if @root.nil?

    curr = @root
    while curr
      if val < curr.val
        return curr.left = Node.new(val) if curr.left.nil?

        curr = curr.left
      else
        return curr.right = Node.new(val) if curr.right.nil?

        curr = curr.right
      end
    end
  end

  def delete(val)
    delete_with_node(val, @root)
  end

  def smallest(node)
    node = node.left until node.left.nil?
    node
  end

  def leaf?(node)
    node.right.nil? && node.left.nil?
  end

  def one_child?(node)
    node.right.nil? ^ node.left.nil?
  end

  def find(val, root = @root)
    curr = root
    while curr
      return curr if curr.nil? || curr.val == val

      curr = val < curr.val ? curr.left : curr.right
    end
  end

  def level_order
    return if @root.nil?

    queue = Queue.new
    queue << @root

    until queue.empty?
      curr = queue.deq unless queue.empty?
      yield curr
      queue << curr.left unless curr.left.nil?
      queue << curr.right unless curr.right.nil?
    end
  end

  def inorder
    return if @root.nil?

    stack = []
    curr = @root

    until stack.empty? && curr.nil?
      if curr
        stack << curr
        curr = curr.left
      else
        curr = stack.pop
        yield curr
        curr = curr.right
      end
    end
  end

  def preorder
    return if @root.nil?

    stack = []
    stack << @root

    until stack.empty?
      curr = stack.pop
      yield curr
      stack << curr.right unless curr.right.nil?
      stack << curr.left unless curr.left.nil?
    end
  end

  def postorder(node = @root, &block)
    return if node.nil?

    postorder(node.left, &block)
    postorder(node.right, &block)

    yield node if block_given?
  end

  def height(node)
    return -1 if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    return left_height + 1 if left_height > right_height

    right_height + 1
  end

  def depth(node)
    curr = @root
    depth = 0
    while curr
      break if curr.nil? || curr == node

      depth += 1
      curr = node.val < curr.val ? curr.left : curr.right
    end

    curr == node ? depth : nil
  end

  def balanced?
    level_order do |node|
      next if node.nil?

      return false unless height(node.left) == height(node.right)
    end
    true
  end

  def rebalance
    array = []
    inorder { |node| array << node.val }
    balansing = BalancedBST.new(array)
    @root = balansing.root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.val}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def delete_with_node(val, node)
    return if node.nil?

    if val < node.val
      node.left = delete_with_node(val, node.left)
    elsif val > node.val
      node.right = delete_with_node(val, node.right)
    else
      if !leaf?(node)
        node.val = smallest(node.right).val
        node.right = delete_with_node(node.val, node.right)
      elsif !node.left.nil?
        node = node.left
      elsif !node.right.nil?
        node = node.right
      else
        node = nil
      end
    end
    node
  end
end

array = [1, 2, 3, 4, 6, 7, 8, 9, 10, 11, 12]

test = BalancedBST.new(array)

test.insert(5)
test.pretty_print

p test.find(6)

test.delete(7)
test.pretty_print

test.level_order { |node| puts node.val }
puts '-----'
test.inorder { |node| puts node.val }
puts '-----'
test.preorder { |node| puts node.val }
puts '-----'
test.postorder { |node| puts node.val }
puts '-----'

puts test.height(test.root)
puts '-----'
puts test.depth(test.find(4))
puts '-----'
puts test.balanced?
test.rebalance
test.insert(13)
test.insert(9.5)
test.insert(5.5)
test.insert(2.5)
test.pretty_print
puts test.balanced?
