def change(amount, coins)
  coins = coins.sort.reverse
  if amount <= 0
    return []
  elsif coins == []
    return nil
  end

  if amount >= coins[0]
    with_first_coin  = [coins[0]] + change(amount - coins[0], coins)
  else
    with_first_coin = nil
  end

  scrap_first_coin = change(amount, coins[1..-1])

  if scrap_first_coin.nil?
    return with_first_coin
  end

  if with_first_coin.nil?
    return scrap_first_coin
  end

  if scrap_first_coin.length < with_first_coin.length
    return scrap_first_coin
  else
    return with_first_coin
  end
end
