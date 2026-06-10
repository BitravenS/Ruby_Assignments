class Node
  attr_accessor :value, :next_node

  def initialize(value, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  attr_accessor :head

  def initialize
    @head = nil
  end

  def append(value)
    new_node = Node.new(value)
    current = @head
    if current.nil?
      @head = new_node
      return
    end

    loop do
      break if current.next_node.nil?

      current = current.next_node
    end
    current.next_node = new_node
  end

  def prepend(value)
    new_node = Node.new(value, @head)
    @head = new_node
  end

  def size
    count = 0
    current = @head
    until current.nil?
      count += 1
      current = current.next_node
    end
    count
  end

  def tail
    current = @head
    return nil if current.nil?

    current = current.next_node until current.next_node.nil?
    current
  end

  def at(index)
    current = @head
    count = 0
    until current.nil?
      return current if count == index

      count += 1
      current = current.next_node
    end
    nil
  end

  def pop
    return nil if @head.nil?

    if @head.next_node.nil?
      value = @head.value
      @head = nil
      return value
    end

    current = @head
    current = current.next_node until current.next_node.next_node.nil?
    value = current.next_node.value
    current.next_node = nil
    value
  end

  def contains?(value)
    current = @head
    until current.nil?
      return true if current.value == value

      current = current.next_node
    end
    false
  end

  def index(value)
    current = @head
    index = 0
    until current.nil?
      return index if current.value == value

      current = current.next_node
      index += 1
    end
    nil
  end

  def to_s
    current = @head
    str = ''
    until current.nil?
      str += "( #{current.value} ) -> "
      current = current.next_node
    end
    str += 'nil'
    str
  end
end

list = LinkedList.new
list.append(10)
list.append(20)
list.prepend(5)
puts list
