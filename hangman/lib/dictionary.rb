# frozen_string_literal: true

class Dictionary # rubocop:disable Style/Documentation
  DICT_FILE = File.join(__dir__, '..', 'google-10000-english-no-swears.txt')
  MIN_LENGTH = 5
  MAX_LENGTH = 12

  def self.random_word
    words = File.readlines(DICT_FILE, chomp: true)
                .select { |w| w.length.between?(MIN_LENGTH, MAX_LENGTH) }
    words.sample
  end
end
