# frozen_string_literal: true

require_relative 'board'
require_relative 'errors'
require_relative 'utils'
require_relative 'piece/piece'
require 'colorize'
require 'require_all'
require_all './lib/piece'

class Game
  attr_reader :board, :current_player

  def initialize
    @board = Board.new
    place_pieces
    @current_player = :white
  end

  def place_pieces
    (0..7).each do |x|
      @board.place_piece(Pawn.new(:black), [1, x])
      @board.place_piece(Pawn.new(:white), [6, x])
    end
    @board.place_piece(Rook.new(:black), [0, 0])
    @board.place_piece(Rook.new(:black), [0, 7])
    @board.place_piece(Rook.new(:white), [7, 0])
    @board.place_piece(Rook.new(:white), [7, 7])
    @board.place_piece(Knight.new(:black), [0, 1])
    @board.place_piece(Knight.new(:black), [0, 6])
    @board.place_piece(Knight.new(:white), [7, 1])
    @board.place_piece(Knight.new(:white), [7, 6])
    @board.place_piece(King.new(:black), [0, 4])
    @board.place_piece(King.new(:white), [7, 4])
    @board.place_piece(Bishop.new(:black), [0, 2])
    @board.place_piece(Bishop.new(:black), [0, 5])
    @board.place_piece(Bishop.new(:white), [7, 2])
    @board.place_piece(Bishop.new(:white), [7, 5])
    @board.place_piece(Queen.new(:black), [0, 3])
    @board.place_piece(Queen.new(:white), [7, 3])
  end

  def switch_player
    @current_player = @current_player == :white ? :black : :white
  end

  def play
    puts 'Welcome to Chess by Bitraven!'.blue
    puts 'Enter moves in algebraic notation (e.g., e2 e4). Type "save" to save the game.'
    puts 'Do you want to load a saved game? (y/n)'
    load_game = gets.chomp == 'y'
    if load_game
      puts 'Enter filename to load game:'
      filename = gets.chomp
      begin
        saved_game = self.class.load_game(filename)
        @board = saved_game.board
        @current_player = saved_game.current_player
      rescue StandardError => e
        puts "Error loading game: #{e.message}".red
        puts 'Starting a new game instead.'
      end
    end

    loop do
      clear_screen
      puts "\n#{@current_player.capitalize}'s turn"
      puts "Captured pieces: #{@board.captured_pieces.values.flatten.map(&:to_s).join(' ')}"
      puts "\n"
      @board.display

      loop do
        print('> ')
        move = gets.chomp

        if move == 'save'
          begin
            puts 'Enter filename to save game:'
            filename = gets.chomp
            save_game(filename)
            puts "Game successfully saved to #{filename}".green
            next
          rescue StandardError => e
            puts "Error saving game: #{e.message}".red
            next
          end
        end

        next unless move =~ /^[a-h][1-8] [a-h][1-8]$/

        from, to = get_move(move)
        piece = @board.get_piece(from)
        if piece.nil?
          puts "No piece at #{coords_to_algebraic(from)}".red
        elsif piece.color != @current_player
          puts "It's not your piece.".red
          puts "You are playing as #{@current_player.capitalize}.".red
          puts "The piece at #{coords_to_algebraic(from)} is #{piece.color.capitalize}.".red
        else
          begin
            win = @board.move_piece(from, to)
            if win
              puts "#{@current_player.capitalize} wins!".green
              @board.display
              exit(0)
            end
            break
          rescue MoveError => e
            puts e.message.red
          end
        end
      end

      switch_player
    end
  end

  def get_move(move)
    from, to = move.split(' ')
    from_coords = algebraic_to_coords(from)
    to_coords = algebraic_to_coords(to)
    [from_coords, to_coords]
  end

  def save_game(filename)
    File.open(filename, 'w') do |file|
      file.puts Marshal.dump(self)
    end
  end

  def self.load_game(filename)
    File.open(filename, 'r') do |file|
      Marshal.load(file.read) # rubocop:disable Security/MarshalLoad
    end
  end

  private :place_pieces, :switch_player
end
