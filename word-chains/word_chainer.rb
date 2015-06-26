require 'set'

class WordChainer
  DICT = Set.new(File.readlines('dictionary.txt').map(&:chomp))

  def initialize(source)
    @current_words = [source]
    @all_seen_words = Set.new([source])
  end

  def run(source, target)
    until current_words.empty?
      new_current_words = Set.new
      current_words.each do |current_word|
        adj_words = get_adjacent_words(current_word)
        new_words = adj_words - all_seen_words
        new_current_words.merge(new_words)
        all_seen_words.merge(new_words)
      end

    current_words = new_current_words
    end
  end

  def get_adjacent_words(word)
    adjacent_words = Set.new

    (0...word.length).each do |i|
      ('a'..'z').each do |letter|
        test_word = word.dup
        test_word[i] = letter
        if DICT.include?(test_word)
          adjacent_words << test_word
        end
      end
    end

    adjacent_words
  end

  private

  attr_accessor :current_words
  attr_reader :all_seen_words, :dictionary

end

chainer = WordChainer.new('ruby')
p chainer.get_adjacent_words('duck')
