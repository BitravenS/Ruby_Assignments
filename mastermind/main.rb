require_relative 'lib/code'
require_relative 'lib/feedback'
require_relative 'lib/human_player'
require_relative 'lib/computer_player'
require_relative 'lib/game'

puts 'Do you want to be the (g)uesser or the (c)odemaker?'
print '> '

role = gets.chomp.downcase

case role
when 'g', 'guesser'
  game = Game.new(ComputerPlayer.new, HumanPlayer.new)
when 'c', 'codemaker'
  game = Game.new(HumanPlayer.new, ComputerPlayer.new)
else
  puts 'Invalid choice. You\'re the guesser lol'
  game = Game.new(ComputerPlayer.new, HumanPlayer.new)
end

game.play
