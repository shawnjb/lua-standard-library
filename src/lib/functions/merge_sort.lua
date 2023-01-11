--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- Sorts an array using merge sort.
--- You do not have to store this function in a variable. You can call it directly.
---
--- Requires an existing array.
--- @param array table The array to sort.
function merge_sort(array)
	if #array > 1 then
		local mid = math.floor(#array / 2)
		local left = {}
		local right = {}
		for i = 1, mid do
			left[i] = array[i]
		end
		for i = mid + 1, #array do
			right[i - mid] = array[i]
		end
		merge_sort(left)
		merge_sort(right)
		local i = 1
		local j = 1
		local k = 1
		while i <= #left and j <= #right do
			if left[i] < right[j] then
				array[k] = left[i]
				i = i + 1
			else
				array[k] = right[j]
				j = j + 1
			end
			k = k + 1
		end
		while i <= #left do
			array[k] = left[i]
			i = i + 1
			k = k + 1
		end
		while j <= #right do
			array[k] = right[j]
			j = j + 1
			k = k + 1
		end
	end
end
