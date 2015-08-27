class ComputerPlayer < Player

  def initialize(name="Computer")
    super(name)
    @direction = nil
  end

  def get_input(current_fragment, dictionary)
    # until (some condition)
    if winning_move_back(current_fragment, dictionary) || winning_move_front(current_fragment, dictionary)
      puts "executed winning move"
      return winning_move_back(current_fragment, dictionary) || winning_move_front(current_fragment, dictionary)
    elsif only_losing_move?(current_fragment, dictionary)
      return losing_move(current_fragment, dictionary)
    else
      puts "executed a random move"
      random_move(current_fragment, dictionary)
    end
  end

  def select_letter(current_fragment)
    only_losing_move?
    get_direction
    letter = ("a".."z").to_a.sample
    temp_fragment = current_fragment
    if @direction == "back"
      temp_fragment + letter
    else
      letter + temp_fragment
    end
  end

  def get_direction
    new_direction = ["front", "back"].sample
    @direction = new_direction
    new_direction
  end

  def winning_move_back(fragment, dictionary)
    # we need to make sure the computer does not select a losing move here with the third condition in the select block
    dict_subset = dictionary.select { |word| word.start_with?(fragment) }
    unique_next_letters = dict_subset.map { |word| word[fragment.length] }.uniq

    unique_next_letters.each do |letter|
      temp_fragment = fragment + letter
      if dict_subset.select { |word| word.start_with?(temp_fragment) }.all? { |new_word| new_word.length.between?(fragment.length + 2, fragment.length + @num_players)}
        return temp_fragment[-1]
      end
    end
    nil
  end

  def winning_move_front(fragment, dictionary)
    # we need to make sure the computer does not select a losing move here with the third condition in the select block
    dict_subset = dictionary.select { |word| word.end_with?(fragment) }
    unique_next_letters = dict_subset.map { |word| word[-(fragment.length + 1)] }.uniq

    unique_next_letters.each do |letter|
      temp_fragment = letter + fragment
      if dict_subset.select { |word| word.end_with?(temp_fragment) }.all? { |new_word| new_word.length.between?(fragment.length + 2, fragment.length + @num_players)}
        return temp_fragment[0]
      end
    end
    nil
  end

  def random_move(fragment, dictionary)
    temp_fragment = select_letter(fragment)
    while dictionary.include?(temp_fragment)
      temp_fragment = select_letter(fragment)
    end
    if @direction == 'front'
      temp_fragment[0]
    else
      temp_fragment[-1]
    end
  end

  def possible_words(fragment, dictionary)
    dictionary.select { |word| word.start_with?(fragment) || word.end_with?(fragment) }
  end

  def only_losing_move?(fragment, dictionary)
    if possible_words(fragment, dictionary).all? { |word| word.length == fragment.length + 1 }
      true
    else
      false
    end
  end

  def losing_move(fragment, dictionary)
    if @direciton == 'front'
      possible_words(fragment, dictionary)[0][0]
    else
      possible_words(fragment, dictionary)[0][-1]
    end
  end
end
