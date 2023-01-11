--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- Searches an array for a value using binary search.
--- @param array table A sorted array to search.
--- @param value any The value to search for.
--- @return number index The index of the value in the array. Returns -1 if the value is not found.
function binary_search(array, value)
	local left = 1
	local right = #array
	while left <= right do
		local middle = math.floor((left + right) / 2)
		if array[middle] == value then
			return middle
		elseif array[middle] < value then
			left = middle + 1
		else
			right = middle - 1
		end
	end
	return -1
end
