# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/player'
def main
  print 'Player 1, enter your name: '
  player1_name = gets.chomp
  print 'Player 2, enter your name: '
  player2_name = gets.chomp

  player1 = Player.new(player1_name, 'R')
  player2 = Player.new(player2_name, 'Y')

  game = Game.new(player1, player2)
  game.play
end

main
