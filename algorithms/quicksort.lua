--- Quick sort algorithm.
--- @param array table
--- @return table array
local function quicksort(array)
	if #array <= 1 then
		return array
	end

	local pivot = array[1]
	local left = {}
	local right = {}
	for i = 2, #array do
		if array[i] < pivot then
			table.insert(left, array[i])
		else
			table.insert(right, array[i])
		end
	end

	left = quicksort(left)
	right = quicksort(right)

	local result = {}
	for i = 1, #left do
		table.insert(result, left[i])
	end
	table.insert(result, pivot)
	for i = 1, #right do
		table.insert(result, right[i])
	end
	return result
end

return quicksort