# first solution - more verbose and allows reaccess of data

def stock_picker(stockprices)
  result_array = Hash.new(0)
  start_day_array = stockprices[0, stockprices.length-1]
  start_day_array.each_with_index do |start, startidx|
    last_day_array = stockprices[startidx+1, stockprices.length]
    last_day_array.each_with_index do |last, lastidx|
      result_array[last-start] = 
      {
        firstday: start,
        firstdayidx: startidx,
        lastday: last,
        lastdayidx: lastidx+startidx+1
      }
    end
  end
  print "for values #{stockprices} index : "
  print "[#{result_array.sort.last[1][:firstdayidx]},"
  puts "#{result_array.sort.last[1][:lastdayidx]}]"
end

# second solution - direct result no access to data

def stock_picker2(stocks)
  max = 0
  result = [0, 0]
  stocks.each_with_index do |a, i|
    stocks.each_with_index do |b, j|
      if b - a > max && j > i
        max = b - a
        result[0] = i
        result[1] = j
      end
    end
  end
  p result
end

stock_picker([17,3,6,9,15,8,6,1,10])
stock_picker([3,6,9,17,15,8,6,12,3,5,1,10])

stock_picker2([17,3,6,9,15,8,6,1,10])
stock_picker2([3,6,9,17,15,8,6,12,3,5,1,10])