def merge(left, right)
  arr = []
  l, r = 0, 0

  until l >= left.length && r >= right.length
    if l >= left.length
      arr << right[r]
      r += 1
    elsif r >= right.length
      arr << left[l]
      l += 1
    elsif left[l] <= right[r]
      arr << left[l]
      l += 1
    else
      arr << right[r]
      r += 1
    end
  end

  arr
end

def merge_sort(arr)
  return arr if arr.length < 2

  n = arr.length / 2
  left = arr.take(n)
  right = arr.drop(n)

  merge(merge_sort(left), merge_sort(right))
end