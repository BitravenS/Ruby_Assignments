# frozen_string_literal: true

require_relative 'errors'
class Board
  attr_reader :captured_pieces

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    @captured_pieces = { white: [], black: [] }
  end

  def place_piece(piece, position)
    x, y = position
    if piece.nil?
      @grid[x][y] = nil
      return
    end
    piece_at_position = get_piece(position)
    if piece_at_position && piece_at_position.color == piece.color
      raise MoveError, "Cannot place piece at #{position.inspect}: position occupied by ally piece"
    end

    if piece_at_position && piece_at_position.color != piece.color
      puts "Captured #{piece_at_position.class} at #{position.inspect}"
      @captured_pieces[piece.color] << piece_at_position
    end
    @grid[x][y] = piece
  end

  def get_piece(position)
    x, y = position
    @grid[x][y]
  end

  def move_piece(from, to)
    piece = get_piece(from)
    if piece.nil?
      raise MoveError, "No piece at #{from.inspect}"
    elsif valid_moves_for(piece, from).none? { |move| move == to }
      if piece.respond_to?(:capture_offset) && valid_capture_moves_for(piece, from).include?(to)
        begin
          place_piece(piece, to)
          place_piece(nil, from)
        rescue MoveError => e
          raise MoveError, e.message
        end
        return
      end
      raise MoveError, "Invalid move for #{piece.class} from #{from.inspect} to #{to.inspect}"
    end

    begin
      place_piece(piece, to)
      place_piece(nil, from)
    rescue MoveError => e
      raise MoveError, e.message
    end
  end

  def valid_moves_for(piece, position)
    all_positions = team_positions(piece.color == :white ? :black : :white)
    piece.valid_moves_from(position, all_positions)
  end

  def valid_capture_moves_for(piece, position) # rubocop:disable Metrics/MethodLength
    if piece.respond_to?(:capture_offset)
      piece.capture_offset.map do |dx, dy|
        x, y = position
        target_x = x + dx
        target_y = y + dy
        if target_x.between?(0, 7) && target_y.between?(0, 7)
          target_piece = get_piece([target_x, target_y])
          [target_x, target_y] if target_piece && target_piece.color != piece.color
        end
      end.compact
    else
      []
    end
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

  def display
    @grid.each_with_index do |row, x|
      print "#{8 - x} "
      puts row.map { |piece| piece || '.' }.join(' ')
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
