# frozen_string_literal: true

module Display # rubocop:disable Style/Documentation
  def self.render(game)
    puts "\nWord: #{game.display_word}"
    puts "Wrong guesses (#{game.wrong_count}/#{Game::MAX_WRONG}): #{game.wrong_letters.join(', ')}"
    puts "Remaining guesses: #{game.remaining_guesses}"
  end

  def self.prompt
    print "\nGuess a letter (or 'save' to save): "
  end

  def self.won(word)
    puts "\nYou won! The word was: #{word}"
  end

  def self.lost(word)
    puts "\nYou lost! The word was: #{word}"
  end
end
