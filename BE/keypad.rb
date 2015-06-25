class Keypad

  def initialize(code_length = 4, mode_keys = [1, 2, 3])
    @key_history = []
    @code_bank = create_code_bank(code_length)
    @mode_keys = mode_keys
    @code_length = code_length
  end

  def create_code_bank(code_length)
    cache = {}

    bank = create_bank_recursion(code_length).map { |x| x.split("").map { |y| y.to_i } }

    bank.each { |el| cache[el] = false }

    cache
  end

  def create_bank_recursion(code_length)
    # base case
    return (0..9).to_a if code_length == 1
    array = []

    create_bank_recursion(code_length - 1).each do |number|
      (0..9).to_a.each do |new_number|
        array << number.to_s + new_number.to_s
      end
    end

    array

  end

  def press(pressed_key)
    @key_history << pressed_key
    check_keys if (@key_history.length >= 5 && @mode_keys.include?(pressed_key))
  end

  def check_keys
    code = @key_history[- (1 + @code_length)..-(2)]
    @code_bank[code] = true
  end

  def all_codes_entered?
    @code_bank.all? { |_, v| v == true }
  end

end
