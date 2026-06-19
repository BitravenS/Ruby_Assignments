# frozen_string_literal: true

require_relative 'errors'
require_relative 'utils'

class Board
  attr_reader :captured_pieces

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    @captured_pieces = { white: [], black: [] }
  end

  def place_piece(piece, position, simulate: false)
    x, y = position
    if piece.nil?
      @grid[x][y] = nil
      return
    end
    piece_at_position = get_piece(position)
    if piece_at_position && piece_at_position.color == piece.color
      raise MoveError, "Cannot place piece at #{position.inspect}: position occupied by ally piece"
    end

    if piece_at_position && piece_at_position.color != piece.color && !simulate
      puts "Captured #{piece_at_position.class} at #{coords_to_algebraic(position)}"
      @captured_pieces[piece.color] << piece_at_position
    end
    @grid[x][y] = piece
  end

  def get_piece(position)
    x, y = position
    @grid[x][y]
  end

  def simulate_move(from, to)
    piece = get_piece(from)
    grid_copy = @grid.map(&:dup)
    place_piece(piece, to, simulate: true)
    place_piece(nil, from, simulate: true)
    yield
  ensure
    @grid = grid_copy.map(&:dup)
  end

  def move_piece(from, to)
    piece = get_piece(from)
    color = piece&.color
    raise MoveError, "No piece at #{coords_to_algebraic(from)}" if piece.nil?

    valid_moves = valid_moves_for(piece, from)
    unless valid_moves.include?(to)
      raise MoveError, "Invalid move for #{piece.class} from #{coords_to_algebraic(from)} to #{coords_to_algebraic(to)}"
    end

    is_in_check = check?(color)

    checkmate = false
    begin
      simulate_move(from, to) do
        if checkmate?(color == :black ? :white : :black)
          checkmate = true
          next

        end
        if check?(color)

          if piece.is_a?(King)
            raise MoveError,
                  "Move from #{coords_to_algebraic(from)} to #{coords_to_algebraic(to)} would put #{color} king in check"
          elsif is_in_check
            raise MoveError, "You're in check!"
          end
          raise MoveError,
                "The #{color} #{piece.class} at #{coords_to_algebraic(from)} is pinned"
        end
      end

      place_piece(piece, to)
      place_piece(nil, from)
      checkmate
    rescue MoveError => e
      raise MoveError, e.message
    end
  end

  def valid_moves_for(piece, position)
    all_positions = team_positions(piece.color)
    piece.valid_moves_from(position, all_positions)
  end

  def team_positions(color)
    positions = { ally: [], enemy: [] }
    @grid.each_with_index do |row, x|
      row.each_with_index do |piece, y|
        positions[:ally] << [x, y] if piece && piece.color == color
        positions[:enemy] << [x, y] if piece && piece.color != color
      end
    end
    positions
  end

  def get_king_position(color)
    @grid.each_with_index do |row, x|
      row.each_with_index do |piece, y|
        return [x, y] if piece.is_a?(King) && piece.color == color
      end
    end
    nil
  end

  def check?(color)
    king_position = get_king_position(color)

    return false unless king_position

    enemy_positions = team_positions(color)[:enemy]
    enemy_positions.any? do |enemy_pos|
      enemy_piece = get_piece(enemy_pos)
      valid_moves_for(enemy_piece, enemy_pos).include?(king_position)
    end
  end

  def checkmate?(color)
    return false unless check?(color)

    king_position = get_king_position(color)
    return false unless king_position

    positions = team_positions(color)

    positions[:ally].each do |ally_pos|
      ally_piece = get_piece(ally_pos)
      valid_moves_for(ally_piece, ally_pos).each do |move|
        simulate_move(ally_pos, move) do
          return false unless check?(color)
        end
      end
    end
    true
  end

  def display
    @grid.each_with_index do |row, x|
      print "#{8 - x} "
      puts row.map { |piece| piece || '·' }.join(' ')
    end
    print "  a b c d e f g h\n\n"
  end

  def display_coords
    @grid.each_with_index do |row, x|
      print "#{8 - x} "
      puts row.map.with_index { |_, y| "[#{x},#{y}]" }.join(' ')
    end
    print "  a b c d e f g h\n\n"
  end
end
