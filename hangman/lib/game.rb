# frozen_string_literal: true

class Game # rubocop:disable Style/Documentation
  MAX_WRONG = 6

  attr_reader :secret_word, :guessed_letters, :wrong_count

  def initialize(secret_word)
    @secret_word = secret_word
    @guessed_letters = []
    @wrong_count = 0
  end

  def guess(letter)
    letter = letter.downcase
    return :already_guessed if @guessed_letters.include?(letter)

    @guessed_letters << letter

    if @secret_word.include?(letter)
      :correct
    else
      @wrong_count += 1
      :wrong
    end
  end

  def display_word
    @secret_word.chars.map { |c| @guessed_letters.include?(c) ? c : '_' }.join(' ')
  end

  def wrong_letters
    @guessed_letters.reject { |l| @secret_word.include?(l) }
  end

  def remaining_guesses
    MAX_WRONG - @wrong_count
  end

  def won?
    @secret_word.chars.all? { |c| @guessed_letters.include?(c) }
  end

  def lost?
    @wrong_count >= MAX_WRONG
  end

  def over?
    won? || lost?
  end
end
