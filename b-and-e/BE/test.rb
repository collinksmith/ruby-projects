def create_bank_recurs(code_length)
  # base case
  return (0..9).to_a if code_length == 1
  array = []

  create_bank_recurs(code_length - 1).each do |number|
    (0..9).to_a.each do |new_number|
      array << number.to_s + new_number.to_s
    end
  end

  array

end

p create_bank_recurs(4).map { |x| x.split("").map { |y| y.to_i } }
