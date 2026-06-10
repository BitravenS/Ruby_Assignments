# frozen_string_literal: true

require './lib/game'

RSpec.describe Game do
  describe '#initialize' do
    it 'initializes a new game with two players' do
      player1 = Player.new('Malek', 'R')
      player2 = Player.new('John', 'Y')
      game = Game.new(player1, player2)

      expect(game.board).to be_a(Board)
      expect(game.players).to eq([player1, player2])
      expect(game.current_player).to eq(player1)
    end
  end

  describe '#switch_player' do
    it 'switches the current player' do
      player1 = Player.new('Malek', 'R')
      player2 = Player.new('John', 'Y')
      game = Game.new(player1, player2)

      game.send(:switch_player)
      expect(game.current_player).to eq(player2)

      game.send(:switch_player)
      expect(game.current_player).to eq(player1)
    end
  end
end
