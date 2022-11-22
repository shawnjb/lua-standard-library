--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- @class Stack The stack data structure class.
--- @field private _list table<number, any> The list.
Stack = {}
Stack.__index = Stack

--- Creates a new stack.
--- @return table Stack The new stack.
function Stack.new()
	local self = setmetatable({}, Stack)
	self._list = {}
	return self
end

--- Adds a value to the stack.
--- @param value any The value to add.
--- @return table Stack The stack.
function Stack:add(value)
	table.insert(self._list, value)
	return self
end

--- Returns the value at the top of the stack.
--- @return any value The value at the top of the stack.
function Stack:peek()
	return self._list[#self._list]
end

--- Removes and returns the value at the top of the stack.
--- @return any value The value at the top of the stack.
function Stack:pop()
	return table.remove(self._list)
end

--- Returns the number of values in the stack.
--- @return number values The number of values in the stack.
function Stack:size()
	return #self._list
end

--- Checks if the stack contains a value.
--- @param value any The value to check.
--- @return boolean contained True if the value is in the stack, false otherwise.
function Stack:contains(value)
	for i = 1, #self._list do
		if self._list[i] == value then
			return true
		end
	end
	return false
end

--- Returns the stack as a string.
--- @return string string The stack as a string.
function Stack:__tostring()
	return table.concat(self._list, ", ")
end

return Stack
