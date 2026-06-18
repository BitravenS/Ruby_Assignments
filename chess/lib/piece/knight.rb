# frozen_string_literal: true

class Knight < Piece
  BLOCKABLE_PATH = false
  SYMBOL = 9816
  def moves_offset
    [
      [2, 1], [2, -1], [-2, 1], [-2, -1],
      [1, 2], [1, -2], [-1, 2], [-1, -2]
    ]
  end
end
