class ComputerPlayer
  def make_code
    Code.random
  end

  def make_guess(history)
    @candidates ||= Code::COLORS.repeated_permutation(Code::LENGTH).map { |p| Code.new(p) }

    unless history.empty?
      last_guess, last_feedback = history.last
      @candidates.select! { |c| Feedback.for(c, last_guess).to_s == last_feedback.to_s }
    end

    guess = @candidates.sample
    puts "Computer guesses: #{guess}"
    guess
  end
end
