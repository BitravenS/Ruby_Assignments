# frozen_string_literal: true

def stock_picker(prices)
  best_profit = 0
  best_days = [0, 0]

  prices.each_with_index do |price, buy_idx|
    (buy_idx + 1...prices.length).each do |sell_idx|
      sell_price = prices[sell_idx]
      profit = sell_price - price

      if profit > best_profit
        best_profit = profit
        best_days = [buy_idx, sell_idx]
      end
    end
  end

  [best_days, best_profit]
end

prices = [17, 3, 6, 9, 15, 8, 6, 1, 10]
days, profit = stock_picker(prices)
puts "Best days to buy and sell: #{days}, Profit: #{profit}"
