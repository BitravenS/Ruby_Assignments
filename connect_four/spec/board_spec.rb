# frozen_string_literal: true

require './lib/board'
RSpec.describe Board do # rubocop:disable Metrics/BlockLength
  describe '#initialize' do
    it 'creates a 6x7 grid' do
      board = Board.new
      expect(board.grid).to have_attributes(length: 6)
      board.grid.each { |row| expect(row).to have_attributes(length: 7) }
    end
  end

  describe '#drop_piece' do
    it 'drops a piece into the specified column' do
      board = Board.new
      expect(board.drop_piece(0, 'R')).to be true
      expect(board.grid[5][0]).to eq('R')
    end

    it 'returns false if the column is full' do
      board = Board.new
      6.times { board.drop_piece(0, 'R') }
      expect(board.drop_piece(0, 'Y')).to be false
    end
  end

  describe '#full?' do
    it 'returns true if the board is full' do
      board = Board.new
      6.times { 7.times { |j| board.drop_piece(j, 'R') } }
      expect(board.full?).to be true
    end

    it 'returns false if the board is not full' do
      board = Board.new
      expect(board.full?).to be false
    end
  end

  describe '#winner?' do
    it 'detects a horizontal win' do
      board = Board.new
      4.times { |i| board.drop_piece(i, 'R') }
      expect(board.winner?).to eq('R')
    end

    it 'detects a vertical win' do
      board = Board.new
      4.times { board.drop_piece(0, 'R') }
      expect(board.winner?).to eq('R')
    end

    it 'detects a diagonal win' do
      board = Board.new
      board.drop_piece(0, 'R')
      board.drop_piece(1, 'Y')
      board.drop_piece(1, 'R')
      board.drop_piece(2, 'Y')
      board.drop_piece(2, 'Y')
      board.drop_piece(2, 'R')
      board.drop_piece(3, 'Y')
      board.drop_piece(3, 'Y')
      board.drop_piece(3, 'Y')
      board.drop_piece(3, 'R')
      expect(board.winner?).to eq('R')
    end
  end
end
