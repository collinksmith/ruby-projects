def range(start_num, end_num)
  return [] if start_num > end_num
  range(start_num, (end_num-1)) << end_num
end
# p range(1,10)

def sum_iterative(arr)
  arr.inject(:+)
end

def sum_recurs(arr)
  return 0 if arr.empty?

  arr.first + sum_recurs(arr[1..-1])
end
# p sum_recurs([1,2,3,4,5])

def exp1(b, pow)
  return 1 if pow == 0
  b * exp1(b, pow - 1)
end

def exp2(b, pow)
  if pow == 0
    return 1
  elsif pow == 1
    return b
  end

  if pow.even?
    root = exp2(b, pow/2)
    return root * root
  else
    root = exp2(b, (pow-1)/2)
    return b * root * root
  end

end

def deep_copy(obj)
  if !obj.is_a?(Array)
    return obj
  end

  obj.map {|elem| deep_copy(elem)}
end

def fib(n)
  if !n.is_a?(Fixnum) || n < 0
    raise "'n' must be a positive integer"
  end

  return [1] if n == 1
  return [1, 1] if n == 2

  arr = fib(n-1)
  arr << arr[-2] + arr[-1]
end

def binary_search(arr, target)
  return nil if arr.empty?
  n = arr.length / 2

  if target == arr[n]
    return n

  elsif target < arr[n]
    left = arr[0...n]
    return binary_search(left, target)

  elsif target > arr[n]
    right = arr[(n+1)..-1]
    idx = binary_search(right, target)
    if idx.nil?
      return nil
    else
      return idx + (n + 1)
    end

  end

end

def subsets(arr)
  return [[]] if arr.empty?

  one_less = subsets(arr[0...-1])
  one_less + one_less.map {|s| s + [arr[-1]]}
end


def recombine(left, right)
  arr = []
  l, r = 0, 0

  until l >= left.length && r >= right.length
    if l >= left.length
      if r < right.length #If right in bounds but not left
        arr << right[r]
        r += 1
      end

    else
      if r < right.length #If both in bounds
        if left[l] <= right[r]
          arr << left[l]
          l += 1
        else
          arr << right[r]
          r += 1
        end

      else #If Left in bounds but not right
        arr << left[l]
        l += 1

      end
    end

  end

  arr
end

def merge_sort(arr)
  return arr if arr.length < 2

  n = arr.length / 2
  left = arr.take(n)
  right = arr.drop(n)

  recombine(merge_sort(left), merge_sort(right))
end
