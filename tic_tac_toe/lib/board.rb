# frozen_string_literal: true

class Board # rubocop:disable Style/Documentation
  WIN_CONDITIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ].freeze

  def initialize
    @cells = Array.new(9) { |i| (i + 1).to_s }
  end

  def display
    puts "\n"
    @cells.each_slice(3) do |row|
      puts " #{row.join(' | ')} "
      puts '-----------' unless row == @cells.last(3)
    end
    puts "\n"
  end

  def place(position, marker)
    index = position - 1
    return false unless available?(index)

    @cells[index] = marker
    true
  end

  def winner?(marker)
    WIN_CONDITIONS.any? { |combo| combo.all? { |i| @cells[i] == marker } }
  end

  def full?
    @cells.none? { |cell| cell.match?(/\d/) }
  end

  private

  def available?(index)
    @cells[index].match?(/\d/)
  end
end
