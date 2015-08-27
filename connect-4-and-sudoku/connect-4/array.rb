class Array
  def join
    res = ''
    self.each do |char|
      if char.nil?
        res << " "
      else
        res << char.to_s
      end
    end
    res
  end
end
