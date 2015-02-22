class Cell
  attr_accessor :status

  def initialize(status=' ')
    @status = status
  end

  def to_s
    "#{@status}"
  end
end