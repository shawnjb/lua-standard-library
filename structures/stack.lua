--- Stack data structure.

local stack = {}
stack.__index = stack

--- Creates a new stack.
--- @return table stack The new stack.
function stack:new()
	local o = { data = {} }
	setmetatable(o, self)
	return o
end

--- Inserts a new element in the stack.
--- @param value any The value of the element.
function stack:push(value)
	table.insert(self.data, value)
end

--- Retrieves the last element in the stack.
--- @return any value The value of the element.
function stack:pop()
	return table.remove(self.data)
end

--- Retrieves the last element in the stack without removing it.
--- @return any value The value of the element.
function stack:peek()
	return self.data[#self.data]
end

--- Retrieves the number of elements in the stack.
--- @return number count The number of elements.
function stack:count()
	return #self.data
end

--- Checks if the stack is empty.
--- @return boolean isEmpty True if the stack is empty, false otherwise.
function stack:isEmpty()
	return #self.data == 0
end

function stack:free()
	self.data = nil
end

return stack
