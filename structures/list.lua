--- List data structure.
local list = {}
list.__index = list

--- Creates a new list.
--- @return table list The new list.
function list:new()
	local o = { data = {} }
	setmetatable(o, self)
	return o
end

--- Inserts a new element in the list.
--- @param value any The value of the element.
function list:insert(value)
	table.insert(self.data, value)
end

--- Retrieves the element at the specified index.
--- @param index number The index of the element.
--- @return any value The value of the element.
function list:get(index)
	return self.data[index]
end

--- Removes the element at the specified index.
--- @param index number The index of the element.
function list:remove(index)
	table.remove(self.data, index)
end

--- Retrieves the number of elements in the list.
--- @return number count The number of elements.
function list:count()
	return #self.data
end

--- Checks if the list is empty.
--- @return boolean isEmpty True if the list is empty, false otherwise.
function list:isEmpty()
	return #self.data == 0
end

function list:free()
	self.data = nil
end

return list