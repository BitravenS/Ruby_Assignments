require_relative 'board'
require_relative 'player'

class Game
  def initialize
    @board = Board.new
    @players = [
      Player.new(prompt_name('Player 1'), 'X'),
      Player.new(prompt_name('Player 2'), 'O')
    ]
    @current = 0
  end

  def play
    loop do
      @board.display
      player = @players[@current]
      position = prompt_move(player)
      next unless @board.place(position, player.marker)

      if @board.winner?(player.marker)
        @board.display
        puts "#{player.name} wins!"
        break
      elsif @board.full?
        @board.display
        puts "It's a draw!"
        break
      end

      @current = (@current + 1) % 2
    end
  end

  private

  def prompt_name(label)
    print "#{label}, enter your name: "
    gets.chomp
  end

  def prompt_move(player)
    print "#{player.name} (#{player.marker}), choose a position (1-9): "
    input = gets.chomp
    return prompt_move(player) unless input.match?(/^[1-9]$/)

    input.to_i
  end
end
