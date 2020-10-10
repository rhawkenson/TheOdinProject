def bubble_sort(arr)
  is_sorted = false
  until is_sorted
    is_sorted = true
    arr[0,arr.length-1].each_with_index do |nb, idx|
      if arr[idx] > arr[idx+1]
        is_sorted = false
        arr[idx], arr[idx+1] = arr[idx+1], arr[idx]
      end
    end
  end
  p arr
end

bubble_sort([4,3,78,2,0,2])