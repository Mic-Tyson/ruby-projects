#array
#i = idx
#j = idx+1
#while(idx!=array.end)
#    if array[i] > array[j]
#        swap array[i], array[j]

# can add swap checker to make it more efficient

def bubble_sort(arr)
    arr.each_with_index do |_ , i|
        j = i+1
        while j < arr.length
            if arr[i] > arr[j]  
                arr[i], arr[j] = arr[j], arr[i] 
            end
            j+=1
        end
    end
end

array = [4, 3, 105, -2, 4, 78, 2, 0, 2]
p bubble_sort(array)
