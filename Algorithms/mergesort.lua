--- Merge sort algorithm.
--- @param array table
--- @return table array
local function mergesort(array)
	if #array <= 1 then
		return array
	end

	local middle = math.floor(#array / 2)
	local left = {}
	local right = {}
	for i = 1, middle do
		table.insert(left, array[i])
	end
	for i = middle + 1, #array do
		table.insert(right, array[i])
	end

	left = mergesort(left)
	right = mergesort(right)

	local result = {}
	while #left > 0 and #right > 0 do
		if left[1] < right[1] then
			table.insert(result, table.remove(left, 1))
		else
			table.insert(result, table.remove(right, 1))
		end
	end
	while #left > 0 do
		table.insert(result, table.remove(left, 1))
	end
	while #right > 0 do
		table.insert(result, table.remove(right, 1))
	end
	return result
end

return mergesort