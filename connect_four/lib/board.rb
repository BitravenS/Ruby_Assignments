class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(6) { Array.new(7, nil) }
  end

  def drop_piece(column, piece)
    5.downto(0) do |row|
      if @grid[row][column].nil?
        @grid[row][column] = piece
        return true
      end
    end
    false
  end

  def full?
    @grid.all? { |row| row.all? }
  end

  def display
    puts "\n1 2 3 4 5 6 7"
    @grid.each do |row|
      puts row.map { |cell| cell || '.' }.join(' ')
    end
    puts
  end

  def winner?
    check_horizontal || check_vertical || check_diagonal
  end

  private

  def check_horizontal
    @grid.each do |row|
      row.each_cons(4) do |four|
        return four.first if four.uniq.size == 1 && four.first
      end
    end
    nil
  end

  def check_vertical
    (0..6).each do |col|
      column = @grid.map { |row| row[col] }
      column.each_cons(4) do |four|
        return four.first if four.uniq.size == 1 && four.first
      end
    end
    nil
  end

  def check_diagonal # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    (0..2).each do |row|
      (0..3).each do |col|
        if [@grid[row][col], @grid[row + 1][col + 1], @grid[row + 2][col + 2],
            @grid[row + 3][col + 3]].uniq.size == 1 &&
           @grid[row][col]
          return @grid[row][col]
        end

        if [@grid[row][col + 3], @grid[row + 1][col + 2], @grid[row + 2][col + 1],
            @grid[row + 3][col]].uniq.size == 1 &&
           @grid[row][col + 3]
          return @grid[row][col + 3]
        end
      end
    end
    nil
  end
end
