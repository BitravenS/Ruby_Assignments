# frozen_string_literal: true

require 'require_all'
require './lib/piece/piece'
require_all './lib/piece'
require './lib/board'

RSpec.describe Board do
  board = Board.new
  board.place_piece(Rook.new(:white), [0, 0])
  board.place_piece(Pawn.new(:black), [0, 4])
  puts 'Initial board setup for rook:'
  board.display
  describe '.valid_moves_for' do
    it 'returns valid moves for a rook at [0, 0] with a black pawn at [0, 4]' do
      valid_moves = board.valid_moves_for(board.get_piece([0, 0]), [0, 0])
      expect(valid_moves).not_to include([0, 5], [0, 6], [0, 7])
      expect(valid_moves).to include([0, 1], [0, 2], [0, 3], [0, 4])
    end
  end
end

RSpec.describe Board do
  board = Board.new
  board.place_piece(Queen.new(:black), [0, 3])
  board.place_piece(Pawn.new(:white), [4, 7])
  board.place_piece(Pawn.new(:black), [5, 5])
  board.place_piece(Pawn.new(:white), [6, 5])
  board.place_piece(Bishop.new(:black), [5, 6])
  board.place_piece(King.new(:white), [7, 3])
  puts 'Initial board setup for queen:'
  board.display
  describe '.valid_moves_for' do
    it 'returns valid moves for a queen at [0, 3] with a white pawn at [4, 7]' do
      valid_moves = board.valid_moves_for(board.get_piece([0, 3]), [0, 3])
      expect(valid_moves).not_to include([5, 8], [6, 9], [7, 10])
      expect(valid_moves).to include([1, 4], [2, 5], [3, 6], [4, 7])
      board.place_piece(Bishop.new(:black), [0, 2])
      valid_moves = board.valid_moves_for(board.get_piece([0, 3]), [0, 3])
      expect(valid_moves).not_to include([0, 2], [0, 1], [0, 0])
    end
    it 'returns valid moves for pawn at [6, 5] with a black pawn at [5, 5]' do
      valid_moves = board.valid_moves_for(board.get_piece([6, 5]), [6, 5])
      expect(valid_moves).not_to include([5, 5], [5, 4])
      expect(valid_moves).to include([5, 6])
    end
  end
end
