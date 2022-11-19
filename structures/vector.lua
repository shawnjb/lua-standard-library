local vector = {}
vector.__index = vector

--- Creates a new vector.
--- @return table vector The new vector.
function vector:new()
	local o = { data = {} }
	setmetatable(o, self)
	return o
end

--- Inserts a new element in the vector.
--- @param value any The value of the element.
function vector:insert(value)
	table.insert(self.data, value)
end

--- Retrieves the element at the specified index.
--- @param index number The index of the element.
--- @return any value The value of the element.
function vector:get(index)
	return self.data[index]
end

--- Retrieves the number of elements in the vector.
--- @return number count The number of elements.
function vector:count()
	return #self.data
end

--- Checks if the vector is empty.
--- @return boolean isEmpty True if the vector is empty, false otherwise.
function vector:isEmpty()
	return #self.data == 0
end

function vector:free()
	self.data = nil
end

return vector
