# frozen_string_literal: true

class King < Piece
  BLOCKABLE_PATH = false
  SYMBOL = 9812
  def moves_offset
    [
      [1, 0], [-1, 0], [0, 1], [0, -1],
      [1, 1], [1, -1], [-1, 1], [-1, -1]
    ]
  end

  def capture_offset
    moves_offset
  end
end
