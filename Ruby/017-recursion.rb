def fibs(n)
  return n > 2 ? fibs(n-1) + fibs(n-2) : 1
end

#p fibs(10)

arr = [2, 5, 604, 54, 3, 123, 40, 6, 123456, 6, 342, 4, 324, 678, 9, 567, 18]

def merge_sort(arr)
  result = []
  return arr if arr.length < 2
  left = merge_sort(arr[0, (arr.length/2)])
  right = merge_sort(arr[(arr.length/2), arr.length])
  until left.empty? || right.empty?
    result.push(left.first < right.first ? left.shift : right.shift)
  end
  return result + left + right
end

p merge_sort(arr)