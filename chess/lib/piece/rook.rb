# frozen_string_literal: true

class Rook < Piece
  SYMBOL = 9814
  def moves_offset
    offsets = []
    (-7..7).each do |i|
      offsets << [i, 0] unless i.zero?
      offsets << [0, i] unless i.zero?
    end
    offsets
  end

  def capture_offset
    moves_offset
  end
end
