class Tile
  attr_reader :revealed
  attr_accessor :value

  def initialize(value, given=false)
    @value = value
    @given = given
    @revealed = given
  end

  def change_value(value)
    @value = value unless value == 0
    value == 0 ? erase : @revealed = true
  end

  def to_s
    revealed ? @value : "_"
  end

  private

    def erase
      @revealed = false unless @given
    end
end
