class HumanPlayer
  def make_code
    puts "Enter your secret code (4 colors, space-separated)."
    puts "Colors: #{Code::COLORS.join(' ')}"
    prompt_code
  end

  def make_guess(_history)
    puts "Enter your guess:"
    prompt_code
  end

  private

  def prompt_code
    loop do
      print "> "
      input = gets.chomp
      return Code.from_input(input)
    rescue ArgumentError => e
      puts e.message
    end
  end
end
