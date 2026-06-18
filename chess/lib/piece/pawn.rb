# frozen_string_literal: true

class Pawn < Piece
  SYMBOL = 9817
  def moves_offset
    case @color
    when :white
      [[-1, 0], [-2, 0]]
    when :black
      [[1, 0], [2, 0]]
    end
  end

  def capture_offset
    case @color
    when :white
      [[-1, 1], [-1, -1]]
    when :black
      [[1, 1], [1, -1]]
    end
  end
end
