require_relative 'board'
require_relative 'player'
class Game
  attr_reader :board, :players, :current_player

  def initialize(player1, player2)
    @board = Board.new
    @players = [player1, player2]
    @current_player = @players[0]
  end

  def play
    loop do
      board.display
      puts "#{current_player.name}'s turn (#{current_player.color})."
      column = gets.chomp.to_i - 1
      valid = board.drop_piece(column, current_player.color)

      if valid
        if board.winner?
          board.display
          puts "#{current_player.name} wins!"
          break
        elsif board.full?
          board.display
          puts "It's a draw!"
          break
        else
          switch_player
        end
      else
        puts 'Invalid move. Try again.'
      end
    end
  end

  private

  def switch_player
    @current_player = players.find { |player| player != current_player }
  end
end
