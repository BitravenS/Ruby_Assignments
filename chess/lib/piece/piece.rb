# frozen_string_literal: true

class Piece
  attr_reader :color

  BLOCKABLE_PATH = true
  SYMBOL = 0

  def initialize(color)
    @color = color
    @symbol = (self.class::SYMBOL + (@color == :white ? 6 : 0)).chr(Encoding::UTF_8)
  end

  def moves_offset
    []
  end

  def moves_from(position)
    x, y = position
    moves_offset.map { |dx, dy| [x + dx, y + dy] }
  end

  def valid_moves_from(position, all_positions = { ally: [], enemy: [] })
    positions = all_positions[:ally] + all_positions[:enemy]
    moves_from(position).select do |target_x, target_y|
      next false unless target_x.between?(0, 7) && target_y.between?(0, 7)

      next unless self.class::BLOCKABLE_PATH

      path = self.class.path_between(position, [target_x, target_y])
      path_clear = path.all? do |square|
        positions.none? { |enemy| enemy == square }
      end

      # Destination can have an enemy but no ally, and path must be clear
      path_clear && all_positions[:ally].none? { |ally| ally == [target_x, target_y] }
    end
  end

  # all squares between two positions (exclusive)
  def self.path_between(from, to)
    x1, y1 = from
    x2, y2 = to

    dx = (x2 - x1) <=> 0 # -1, 0, or 1
    dy = (y2 - y1) <=> 0

    return [] unless dx.zero? || dy.zero? || dx.abs == dy.abs

    squares = []
    cx = x1 + dx
    cy = y1 + dy

    while cx != x2 || cy != y2
      squares << [cx, cy]
      cx += dx
      cy += dy
    end

    squares
  end

  def to_s
    @symbol
  end
end
