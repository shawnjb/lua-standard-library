--- Binary search algorithm
--- @param array table
--- @param value any
--- @return number index
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
	return nil
end

return binarysearch