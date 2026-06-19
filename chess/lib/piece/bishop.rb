# frozen_string_literal: true

class Bishop < Piece
  SYMBOL = 9815
  def moves_offset
    offsets = []
    (-7..7).each do |i|
      offsets << [i, i] unless i.zero?
      offsets << [i, -i] unless i.zero?
    end
    offsets
  end

  def capture_offset
    moves_offset
  end
end
