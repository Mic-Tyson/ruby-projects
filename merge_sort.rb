#sort lhs
#sort rhs
#merge

# if lhs[0] < rhs[0]
# append lhs.shift - shift allows us to simulate iterating through the array
# else append rhs.shift
# when one side is done, add the remainder without comparing


def merge(lhs, rhs)
  merged = []
  until lhs.empty? || rhs.empty?
    if lhs.first <= rhs.first
      merged << lhs.shift
    else
      merged << rhs.shift
    end
  end
  merged.concat(lhs).concat(rhs)
end


def my_merge_sort(array)
  return array if array.length == 1
  midpoint = (array.length/2.0).ceil
  lhs = my_merge_sort(array.slice(0...midpoint))
  rhs = my_merge_sort(array.slice(midpoint...array.length))
  merge(lhs, rhs)
end

p my_merge_sort([1, 21, 5, 6 ,67])