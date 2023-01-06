--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- Searches an array for a value using binary search.
--- @param array table The array to search.
--- @param value any The value to search for.
function BinarySearch(array, value)
	local low = 1
	local high = #array
	while low <= high do
		local mid = math.floor((low + high) / 2)
		if array[mid] < value then
			low = mid + 1
		elseif array[mid] > value then
			high = mid - 1
		else
			return mid
		end
	end
	return nil
end
