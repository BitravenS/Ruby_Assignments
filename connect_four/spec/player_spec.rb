require './lib/player'

RSpec.describe Player do
  describe '#initialize' do
    it 'initializes a player with a name and color' do
      player = Player.new('Malek', 'R')
      expect(player.name).to eq('Malek')
      expect(player.color).to eq('R')
    end
  end
end
