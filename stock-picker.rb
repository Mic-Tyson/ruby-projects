#find the best day based on the current index

=begin
array
best_profit
best_days = [0, 0]

while(next_idx != array.eof)
    curr_profit = array[next_idx] - array[curr_idx]
    if(best_profit < curr_profit) 
        best_profit = curr_profit
        best_days = [curr_idx, next_idx]
    end
    ++next_idx
end
=end

def stock_picker(stock_prices)
    stock_prices.each_with_index.reduce([0,0]) do |a, (price, idx)| 
        next_idx = idx+1
        while next_idx < stock_prices.length
            if(stock_prices[a[1]] - stock_prices[a[0]] < stock_prices[next_idx] - price)
                a[0] = idx 
                a[1] = next_idx
            end 
            next_idx +=1 
        end
        a
    end
end


stocks = [17,3,6,9,15,8,6,1,10]
p stock_picker(stocks) #returns [1,4] correctly for a profit of $15 - $3 == $12