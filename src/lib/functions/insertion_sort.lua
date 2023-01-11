--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- Perform an in-place insertion sort on an array.
--- @param array table The array to sort.
function insertion_sort(array)
	local len = #array
	for i = 2, len do
		local key = array[i]
		local j = i - 1
		while j > 0 and array[j] > key do
			array[j + 1] = array[j]
			j = j - 1
		end
		array[j + 1] = key
	end
	return array
end
