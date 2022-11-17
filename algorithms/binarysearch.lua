--- Search an array using the binary search algorithm. Also known as half-interval search, logarithmic search, or binary chop, it is an efficient algorithm for finding the position of a target value within a sorted array.
---
--- It compares the target value to the middle element of the array. If they are not equal, the half in which the target cannot lie is eliminated and the search continues on the remaining half, again taking the middle element to compare to the target value, and repeating this until the target value is found.
---
--- If the search ends with the remaining half being empty, the target is not in the array.
---
--- Although there are many variations on this algorithm, the one implemented here is the standard binary search algorithm.
---
--- @param array table
--- @param value any
--- @return number? index
local function binarysearch(array, value)
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
end

return binarysearch