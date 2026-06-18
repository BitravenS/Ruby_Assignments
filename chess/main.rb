# frozen_string_literal: true

require_relative 'lib/game'

def main
  game = Game.new
  puts 'Game initialized'
  game.play
end

main
