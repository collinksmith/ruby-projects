require './keypad'

class KeypadTester
  def initialize(length = 4, mode_keys = [1, 2, 3])
    @keypad = Keypad.new(length, mode_keys)
  end

  def run
    (0..9).each do |i1|
      (0..9).each do |i2|
        (0..9).each do |i3|
          (0..9).each do |i4|
            @keypad.press(i1)
            @keypad.press(i2)
            @keypad.press(i3)
            @keypad.press(i4)
            @keypad.press(rand(3) + 1)
          end
        end
      end
    end

    p @keypad.all_codes_entered?
  end
end

tester = KeypadTester.new
tester.run
