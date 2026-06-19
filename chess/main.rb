# frozen_string_literal: true

require_relative 'lib/game'

def main
  game = Game.new
  puts 'Game initialized'
  begin
    game.play
  rescue Interrupt
    puts "\nGame interrupted. Exiting..."
  end
end

main
