require 'set'

class WordChainer
  attr_accessor :current_words
  attr_reader :all_seen_words, :dict

  def initialize(file_name = 'dictionary.txt')
    @dict = Set.new(File.readlines(file_name).map(&:chomp))
  end

  def set_variables(source)
    @current_words = [source]
    @all_seen_words = { source => nil }
  end

  def run(source, target)
    set_variables(source)

    until current_words.empty? || all_seen_words.include?(target)
      new_current_words = []
      explore_current_words(new_current_words)     
    end

    p build_path(target)
  end

  def explore_current_words(new_current_words)
    current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        next if all_seen_words.include?(adjacent_word)
        new_current_words << adjacent_word
        all_seen_words[adjacent_word] = current_word
      end

      @current_words = new_current_words
    end
  end

  def build_path(target)
    if all_seen_words[target].nil?
      return "No valid path!"
    end

    path = []

    next_word = target
    until next_word == nil
      path.unshift(next_word)
      next_word = all_seen_words[next_word]
    end

    path
  end

  def adjacent_words(word)
    adjacent_words = Set.new

    (0...word.length).each do |i|
      ('a'..'z').each do |letter|
        test_word = word.dup
        test_word[i] = letter
        if dict.include?(test_word)
          adjacent_words << test_word
        end
      end
    end

    adjacent_words
  end
end

if __FILE__ == $PROGRAM_NAME
  chainer = WordChainer.new()
  chainer.run('market', 'farmer')
end