--- Insertion sort algorithm.
--- @param array table
--- @return table array
local function insertionsort(array)
	for i = 2, #array do
		local j = i
		while j > 1 and array[j] < array[j - 1] do
			array[j], array[j - 1] = array[j - 1], array[j]
			j = j - 1
		end
	end
	return array
end

return insertionsort