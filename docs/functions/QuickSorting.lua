--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- Used by QuickSort; this partitions the array for sorting.
--- @param array table The array to partition.
--- @param low number The low index.
--- @param high number The high index.
function Partition(array, low, high)
	local pivot = array[high]
	local i = low - 1
	for j = low, high - 1 do
		if array[j] <= pivot then
			i = i + 1
			array[i], array[j] = array[j], array[i]
		end
	end
	array[i + 1], array[high] = array[high], array[i + 1]
	return i + 1
end

--- Used by QuickSort; sort an array with a low and high index.
--- @param array table The array to sort.
--- @param low number The low index.
--- @param high number The high index.
function Sort(array, low, high)
	if low < high then
		local pi = Partition(array, low, high)
		Sort(array, low, pi - 1)
		Sort(array, pi + 1, high)
	end
end

--- Sorts an array using quick sort.
--- You do not have to store this function in a variable. You can call it directly.
---
--- Requires an existing array.
--- @param array table The array to sort.
function QuickSort(array)
	Sort(array, 1, #array)
end
