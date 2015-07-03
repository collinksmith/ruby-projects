class Hand
  attr_accessor :cards

  VALUE = {
    :ace => 14, :two => 2, :three => 3, :four  => 4,
    :five  => 5, :six   => 6, :seven => 7, :eight => 8,
    :nine  => 9, :ten   => 10, :jack  => 11, :queen => 12, :king  => 13
  }

  PRECEDENCE = [ :straight_flush?, :four_of_a_kind?, :full_house?, :flush?,
                 :straight?, :three_of_a_kind?, :two_pair?, :pair? ]

  def initialize(cards = [])
    @cards = cards
  end

  def values
    cards.map { |card| VALUE[card.value] }
  end

  def suits
    cards.map(&:suit)
  end

  def all_same_suit?
    suits.all? { |suit| suit == suits.first }
  end

  def all_sequential?
    sorted_vals = values.sort
    (0...sorted_vals.length - 1).each_with_index do |sorted_val, idx|
      return false unless sorted_vals[idx + 1] == sorted_vals[idx] + 1
    end

    true
  end

  def amount_of_value(value)
    values.select { |card_value| card_value == value }.size
  end

  def hand_type
    
  end

  # ------------------------------

  def beats?(other_hand)

  end

  def straight_flush?
    all_same_suit? && all_sequential?
  end

  def four_of_a_kind?
    values.uniq.each do |value|
      return true if amount_of_value(value) == 4
    end

    false
  end

  def full_house?
    card_vals = []
    values.uniq.each { |value| card_vals << amount_of_value(value) }
    card_vals.sort == [2, 3] ? true : false
  end

  def straight?
    all_sequential?
  end

  def flush?
    all_same_suit?
  end

  def three_of_a_kind?
    values.uniq.each do |value|
      return true if amount_of_value(value) == 3
    end

    false
  end

  def two_pair?
    card_vals = []
    values.uniq.each { |value| card_vals << amount_of_value(value) }
    card_vals.sort == [1, 2, 2] ? true : false
  end

  def pair?
    card_vals = []
    values.uniq.each { |value| card_vals << amount_of_value(value) }
    card_vals.include?(2) ? true : false
  end
end
