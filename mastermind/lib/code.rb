class Code
  COLORS = %w[R G B Y O P].freeze
  LENGTH = 4

  attr_reader :pegs

  def initialize(pegs)
    @pegs = pegs
  end

  def self.random
    new(Array.new(LENGTH) { COLORS.sample })
  end

  def self.from_input(input)
    pegs = input.upcase.split
    raise ArgumentError, "Enter exactly #{LENGTH} colors." unless pegs.length == LENGTH
    raise ArgumentError, "Invalid color(s). Use: #{COLORS.join(' ')}" unless pegs.all? { |p| COLORS.include?(p) }

    new(pegs)
  end

  def to_s
    pegs.join(' ')
  end
end
