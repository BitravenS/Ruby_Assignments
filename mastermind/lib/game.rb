# frozen_string_literal: true

class Game # rubocop:disable Style/Documentation
  MAX_TURNS = 12

  def initialize(codemaker, codebreaker)
    @codemaker = codemaker
    @codebreaker = codebreaker
  end

  def play # rubocop:disable Metrics/MethodLength
    secret = @codemaker.make_code
    puts "\nGame start! #{MAX_TURNS} turns to crack the code."
    puts "Colors: #{Code::COLORS.join(' ')}\n\n"

    history = []

    MAX_TURNS.times do |turn|
      puts "Turn #{turn + 1}/#{MAX_TURNS}"
      guess = @codebreaker.make_guess(history)
      feedback = Feedback.for(secret, guess)
      history << [guess, feedback]

      puts "  Guess:    #{guess}"
      puts "  Feedback: #{feedback}\n\n"

      if feedback.win?
        puts "Code cracked in #{turn + 1} turn(s)! The code was: #{secret}"
        return # rubocop:disable Lint/NonLocalExitFromIterator
      end
    end

    puts "Out of turns! The secret code was: #{secret}"
  end
end
