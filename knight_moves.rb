class Knight
  MOVE_OFFSETS = [
    [2, 1],
    [2, -1],
    [-2, 1],
    [-2, -1],
    [1, 2],
    [1, -2],
    [-1, 2],
    [-1, -2]
  ].freeze

  attr_reader :position

  def initialize(position)
    @position = position
  end

  def self.moves_from(position)
    x, y = position
    MOVE_OFFSETS.map { |dx, dy| [x + dx, y + dy] }
  end

  def self.valid_moves_from(position)
    moves_from(position).select { |x, y| x.between?(0, 7) && y.between?(0, 7) }
  end

  def moves
    self.class.moves_from(@position)
  end

  def valid_moves
    self.class.valid_moves_from(@position)
  end

  def find_path(target)
    queue = [@position]
    parents = { @position => nil }
    current_index = 0

    while current_index < queue.size
      current_position = queue[current_index]
      current_index += 1

      return build_path(parents, current_position) if current_position == target

      self.class.valid_moves_from(current_position).each do |move|
        next if parents.key?(move)

        parents[move] = current_position
        queue << move
      end
    end

    nil
  end

  def visualize_path(path)
    max_value = path.size - 1
    max_size = max_value.to_s.size
    board = Array.new(8) { Array.new(8, '.'.rjust(max_size)) }
    path.each_with_index do |pos, index|
      x, y = pos
      board[y][x] = index.to_s.rjust(max_size)
    end
    board.each { |row| puts row.join(' ') }
  end

  private

  def build_path(parents, position)
    path = []

    while position
      p position
      path << position
      position = parents[position]
    end
    p ''

    path.reverse
  end
end

test = Knight.new([0, 0])
path = test.find_path([7, 7])
p "path in #{path.size - 1} moves: #{path.inspect}"
test.visualize_path(path)
