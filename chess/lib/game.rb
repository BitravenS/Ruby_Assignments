# frozen_string_literal: true

require_relative 'board'
require_relative 'errors'
require_relative 'piece/piece'
require 'require_all'
require_all './lib/piece'

class Game
  attr_reader :board

  def initialize
    @board = Board.new
    place_pieces
    @current_player = :white
  end

  def place_pieces
    (0..7).each do |x|
      @board.place_piece(Pawn.new(:black), [1, x])
      @board.place_piece(Pawn.new(:white), [6, x])
    end
    @board.place_piece(Rook.new(:black), [0, 0])
    @board.place_piece(Rook.new(:black), [0, 7])
    @board.place_piece(Rook.new(:white), [7, 0])
    @board.place_piece(Rook.new(:white), [7, 7])
    @board.place_piece(Knight.new(:black), [0, 1])
    @board.place_piece(Knight.new(:black), [0, 6])
    @board.place_piece(Knight.new(:white), [7, 1])
    @board.place_piece(Knight.new(:white), [7, 6])
    @board.place_piece(King.new(:black), [0, 4])
    @board.place_piece(King.new(:white), [7, 4])
    @board.place_piece(Bishop.new(:black), [0, 2])
    @board.place_piece(Bishop.new(:black), [0, 5])
    @board.place_piece(Bishop.new(:white), [7, 2])
    @board.place_piece(Bishop.new(:white), [7, 5])
    @board.place_piece(Queen.new(:black), [0, 3])
    @board.place_piece(Queen.new(:white), [7, 3])
  end

  def switch_player
    @current_player = @current_player == :white ? :black : :white
  end

  def play
    loop do
      puts "\n#{@current_player.capitalize}'s turn"
      puts "Captured pieces: #{@board.captured_pieces.values.flatten.map(&:to_s).join(' ')}"
      puts "\n"
      @board.display

      loop do
        puts "Enter  move (e.g. 'e2 e4'):"
        move = gets.chomp

        next unless move =~ /^[a-h][1-8] [a-h][1-8]$/

        from, to = get_move(move)
        piece = @board.get_piece(from)
        if piece.nil?
          puts "No piece at #{from.inspect}"
        elsif piece.color != @current_player
          puts "It's not your piece."
          puts "You are playing as #{@current_player.capitalize}."
          puts "The piece at #{from.inspect} is #{piece.color.capitalize}."
        else
          begin
            @board.move_piece(from, to)
            break
          rescue MoveError => e
            puts e.message
          end
        end
      end

      switch_player
    end
  end

  def get_move(move)
    from, to = move.split(' ')
    from_coords = [8 - from[1].to_i, from[0].ord - 'a'.ord]
    to_coords = [8 - to[1].to_i, to[0].ord - 'a'.ord]
    [from_coords, to_coords]
  end

  private :place_pieces, :switch_player
end
