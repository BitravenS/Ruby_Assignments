require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array.uniq.sort)
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    return unless node

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false)
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true)
  end

  def include?(value, node = @root)
    return false unless node
    return true if node.data == value

    if value < node.data
      include?(value, node.left)
    else
      include?(value, node.right)
    end
  end

  def insert(value, node = @root)
    return if include?(value)

    if value < node.data
      node.left ? insert(value, node.left) : node.left = Node.new(value)
    else
      node.right ? insert(value, node.right) : node.right = Node.new(value)
    end
  end

  def delete(value, node = @root)
    return nil unless node

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      return node.right unless node.left
      return node.left unless node.right

      min_larger_node = find_min(node.right)
      node.data = min_larger_node.data
      node.right = delete(min_larger_node.data, node.right)
    end

    node
  end

  def find_min(node)
    current = node
    current = current.left while current.left
    current
  end

  def level_order(node = @root, queue = [], result = [], &block)
    if node.nil? && queue.empty?
      return block_given? ? self : result
    end

    if node
      result << node.data
      yield(node.data) if block_given?
      queue << node.left if node.left
      queue << node.right if node.right
    end

    next_node = queue.shift
    level_order(next_node, queue, result, &block)
  end

  def inorder(node = @root, result = [], &block)
    return result unless node

    inorder(node.left, result, &block)
    result << node.data
    yield(node.data) if block_given?
    inorder(node.right, result, &block)

    block_given? ? self : result
  end

  def preorder(node = @root, result = [], &block)
    return result unless node

    result << node.data
    yield(node.data) if block_given?
    preorder(node.left, result, &block)
    preorder(node.right, result, &block)

    block_given? ? self : result
  end

  def postorder(node = @root, result = [], &block)
    return result unless node

    postorder(node.left, result, &block)
    postorder(node.right, result, &block)
    result << node.data
    yield(node.data) if block_given?

    block_given? ? self : result
  end

  def find(value, node = @root)
    return nil unless node
    return node if node.data == value

    if value < node.data
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  def height(value, node = find(value))
    return -1 unless node

    calculate_height(node)
  end

  def calculate_height(node)
    return -1 unless node

    left_height = calculate_height(node.left)
    right_height = calculate_height(node.right)

    1 + [left_height, right_height].max
  end

  def depth(value, node = @root, current_depth = 0)
    return -1 unless node
    return current_depth if node.data == value

    if value < node.data
      depth(value, node.left, current_depth + 1)
    else
      depth(value, node.right, current_depth + 1)
    end
  end

  def balanced?(node = @root)
    return true unless node

    left_height = calculate_height(node.left)
    right_height = calculate_height(node.right)

    (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    sorted_array = inorder
    @root = build_tree(sorted_array)
  end

  private

  def build_tree(array)
    return nil if array.empty?

    mid = array.length / 2
    node = Node.new(array[mid])
    node.left = build_tree(array[0...mid])
    node.right = build_tree(array[mid + 1..])

    node
  end
end
