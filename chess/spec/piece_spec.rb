# frozen_string_literal: true

require 'require_all'
require './lib/piece/piece'
require_all './lib/piece'
require './lib/board'

RSpec.describe Rook do
  board = Board.new
  board.place_piece(Rook.new(:white), [0, 0])
  board.place_piece(Pawn.new(:black), [0, 4])
  black_positions = board.team_positions(:black)
  describe '.valid_moves_from' do
    it 'returns valid moves for a rook at [0, 0] with a black pawn at [0, 4]' do
      valid_moves = Rook.valid_moves_from([0, 0], black_positions)
      p valid_moves
      expect(valid_moves).not_to include([0, 5], [0, 6], [0, 7])
      expect(valid_moves).to include([0, 1], [0, 2], [0, 3], [0, 4])
    end
  end
end
