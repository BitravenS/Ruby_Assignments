# frozen_string_literal: true

class Feedback # rubocop:disable Style/Documentation
  attr_reader :exact, :color

  def initialize(exact, color)
    @exact = exact
    @color = color
  end

  def self.for(secret, guess) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    exact = secret.pegs.zip(guess.pegs).count { |s, g| s == g }

    secret_remaining = []
    guess_remaining = []
    secret.pegs.zip(guess.pegs).each do |s, g|
      unless s == g
        secret_remaining << s
        guess_remaining << g
      end
    end

    color = guess_remaining.sum do |g|
      secret_remaining.include?(g) ? secret_remaining.delete_at(secret_remaining.index(g)) && 1 : 0
    end

    new(exact, color)
  end

  def win?
    exact == Code::LENGTH
  end

  def to_s
    "Exact: #{exact} | Color only: #{color}"
  end
end
