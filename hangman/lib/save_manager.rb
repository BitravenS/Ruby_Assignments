# frozen_string_literal: true

require 'json'

module SaveManager # rubocop:disable Style/Documentation
  SAVES_DIR = File.join(__dir__, '..', 'saves')

  def self.save(game, name)
    FileUtils.mkdir_p(SAVES_DIR)
    data = {
      secret_word: game.secret_word,
      guessed_letters: game.guessed_letters,
      wrong_count: game.wrong_count
    }
    File.write(File.join(SAVES_DIR, "#{name}.json"), JSON.generate(data))
    puts "Game saved as '#{name}'."
  end

  def self.load(name)
    path = File.join(SAVES_DIR, "#{name}.json")
    unless File.exist?(path)
      puts "Save '#{name}' not found."
      return nil
    end
    data = JSON.parse(File.read(path), symbolize_names: true)
    game = Game.new(data[:secret_word])
    game.instance_variable_set(:@guessed_letters, data[:guessed_letters])
    game.instance_variable_set(:@wrong_count, data[:wrong_count])
    game
  end

  def self.list_saves
    Dir.glob(File.join(SAVES_DIR, '*.json')).map { |f| File.basename(f, '.json') }
  end
end
