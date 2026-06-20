# frozen_string_literal: true

require 'require_all'
require './lib/piece/piece'
require_all './lib/piece'
require './lib/board'

RSpec.describe Board do
  board1 = Board.new
  board1.place_piece(Queen.new(:black), [0, 3])
  board1.place_piece(King.new(:white), [7, 3])
  puts 'Initial board setup for king in check:'
  board1.display

  board2 = Board.new
  board2.place_piece(Queen.new(:black), [0, 3])
  board2.place_piece(Bishop.new(:black), [4, 3])
  board2.place_piece(Pawn.new(:white), [5, 3])
  board2.place_piece(King.new(:white), [7, 3])
  puts 'Initial board setup for king not in check:'
  board2.display

  board3 = Board.new
  board3.place_piece(King.new(:white), [7, 3])
  board3.place_piece(Rook.new(:black), [6, 0])
  puts 'Initial board setup for king cannot move into check:'
  board3.display

  board4 = Board.new
  board4.place_piece(King.new(:white), [7, 3])
  board4.place_piece(Rook.new(:black), [0, 3])
  board4.place_piece(Knight.new(:white), [4, 3])
  puts 'Initial board setup for pinned piece:'
  board4.display

  describe '.check?' do
    it 'detects check for white king at [7, 3] with a black queen at [0, 3]' do
      expect(board1.check?(:white)).to be true
    end
    it 'detects no check for white king at [7, 3] with a black queen at [0, 3] if bishop blocks' do
      expect(board2.check?(:white)).to be false
    end

    it 'will not let the king move into check' do
      expect do
        board3.move_piece([7, 3], [6, 3])
      end.to raise_error(MoveError)
    end

    it 'will not let a pinned piece move' do
      expect do
        board4.move_piece([4, 3], [5, 1])
      end.to raise_error(MoveError)
    end
  end

  board5 = Board.new
  board5.place_piece(King.new(:white), [7, 3])
  board5.place_piece(Rook.new(:black), [6, 6])

  describe '.checkmate?' do
    it 'detects checkmate for white king at [7, 3] with a black rook at [6, 6] and [7, 7]' do
      board5.place_piece(Rook.new(:black), [5, 7])

      puts 'Initial board setup for checkmate:'
      board5.display
      puts "Positions: #{board5.team_positions(:white)}"

      board5.move_piece([5, 7], [7, 7]) # Move the rook to [7, 7] to create a checkmate scenario

      expect(board5.checkmate?(:white)).to be true
    end
  end
end
