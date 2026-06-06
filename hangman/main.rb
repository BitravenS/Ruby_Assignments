# frozen_string_literal: true

require 'fileutils'
require_relative 'lib/dictionary'
require_relative 'lib/game'
require_relative 'lib/display'
require_relative 'lib/save_manager'

def play(game) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
  until game.over?
    Display.render(game)
    Display.prompt
    input = gets.chomp.strip.downcase

    if input == 'save'
      print 'Enter save name: '
      name = gets.chomp.strip
      SaveManager.save(game, name)
      next
    end

    if input.length != 1 || !input.match?(/[a-z]/)
      puts 'Please enter a single letter.'
      next
    end

    result = game.guess(input)
    puts 'Already guessed that letter.' if result == :already_guessed
  end

  if game.won?
    Display.won(game.secret_word)
  else
    Display.lost(game.secret_word)
  end
end

def start_menu # rubocop:disable Metrics/MethodLength
  saves = SaveManager.list_saves
  if saves.any?
    puts "Saved games: #{saves.join(', ')}"
    print 'Load a save or press Enter for a new game: '
    input = gets.chomp.strip
    unless input.empty?
      game = SaveManager.load(input)
      return game if game
    end
  end

  puts 'Starting a new game...'
  Game.new(Dictionary.random_word)
end

game = start_menu
play(game)
