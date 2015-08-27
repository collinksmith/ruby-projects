class Array
  def my_each(&prc)
    i = 0
    while i < length
      prc.call(self[i])
      i += 1
    end
  end

  def my_map(&prc)
    new_arr = []

    my_each do |e|
      new_arr << prc.call(e)
    end

    new_arr
  end

  def my_select(&prc)
    new_arr = []

    my_each do |e|
      new_arr << e if prc.call(e)
    end

    new_arr
  end

  def my_inject(&prc)
    res = first

    my_each do |e|
      next if e == 1
      res = prc.call(res, e)
    end

    res
  end

  def my_sort!(&prc)
    
    sorted = false
    until sorted
      sorted = true
      i = 0
      while i < length - 1
        e, next_e = self[i], self[i + 1]
        if prc.call(e, next_e) > 0
          self[i], self[i + 1] = next_e, e
          sorted = false
        end

        i += 1
      end
    end

    self
  end

  def my_sort(&prc)
    self.dup.my_sort!(&prc)
  end
end