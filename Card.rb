class Card
  attr_reader :value, :hidden

  def initialize(value)
    @value = value
    @hidden = true
  end

  def to_s
    if hidden
      "#"
    else
      @value.to_s.ljust(4)
    end
  end

  def hide
    @hidden = true
  end

  def reveal
    @hidden = false
  end

  def ==(card_object)
    self.value == card_object.value
  end

end
