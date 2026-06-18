# frozen_string_literal: true

class Queen < Piece
  SYMBOL = 9813
  def moves_offset
    offsets = []
    (-7..7).each do |i|
      offsets << [i, 0] unless i.zero?
      offsets << [0, i] unless i.zero?
      offsets << [i, i] unless i.zero?
      offsets << [i, -i] unless i.zero?
    end
    offsets
  end
end
