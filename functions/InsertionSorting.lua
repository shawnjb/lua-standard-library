--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- Sorts an array using insertion sort.
--- You do not have to store this function in a variable. You can call it directly.
---
--- Requires an existing array.
--- @param array table The array to sort.
function InsertionSort(array)
	for i = 2, #array do
		local value = array[i]
		local j = i - 1
		while j >= 1 and array[j] > value do
			array[j + 1] = array[j]
			j = j - 1
		end
		array[j + 1] = value
	end
end
