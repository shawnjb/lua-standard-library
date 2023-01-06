--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- @class DoubleEndedQueue
--- @field private _head number
--- @field private _tail number
DoubleEndedQueue = {}
DoubleEndedQueue.__index = DoubleEndedQueue

--- Creates a new double-ended queue.
--- @return table DoubleEndedQueue The new double-ended queue.
function DoubleEndedQueue.new()
	local self = setmetatable({}, DoubleEndedQueue)
	self._head = 1
	self._tail = 1
	return self
end

--- Adds a value to the front of the double-ended queue.
--- @param value any The value to add.
--- @return table DoubleEndedQueue The double-ended queue.
function DoubleEndedQueue:addFront(value)
	self._head = self._head - 1
	if self._head < 1 then
		self._head = self._head + #self._buffer
	end
	self._buffer[self._head] = value
	return self
end

--- Adds a value to the back of the double-ended queue.
--- @param value any The value to add.
--- @return table DoubleEndedQueue The double-ended queue.
function DoubleEndedQueue:addBack(value)
	self._buffer[self._tail] = value
	self._tail = self._tail + 1
	if self._tail > #self._buffer then
		self._tail = self._tail - #self._buffer
	end
	return self
end

--- Returns the value at the front of the double-ended queue.
--- @return any value The value at the front of the double-ended queue.
function DoubleEndedQueue:peekFront()
	return self._buffer[self._head]
end

--- Returns the value at the back of the double-ended queue.
--- @return any value The value at the back of the double-ended queue.
function DoubleEndedQueue:peekBack()
	return self._buffer[self._tail - 1]
end

--- Removes the value at the front of the double-ended queue.
--- @return any value The value at the front of the double-ended queue.
function DoubleEndedQueue:removeFront()
	local value = self._buffer[self._head]
	self._buffer[self._head] = nil
	self._head = self._head + 1
	if self._head > #self._buffer then
		self._head = self._head - #self._buffer
	end
	return value
end

--- Removes the value at the back of the double-ended queue.
--- @return any value The value at the back of the double-ended queue.
function DoubleEndedQueue:removeBack()
	self._tail = self._tail - 1
	if self._tail < 1 then
		self._tail = self._tail + #self._buffer
	end
	local value = self._buffer[self._tail]
	self._buffer[self._tail] = nil
	return value
end

--- Returns the number of values in the double-ended queue.
--- @return number values The number of values in the double-ended queue.
function DoubleEndedQueue:size()
	if self._tail >= self._head then
		return self._tail - self._head
	else
		return #self._buffer - (self._head - self._tail)
	end
end

--- Checks if the double-ended queue contains a value.
--- @param value any The value to check.
--- @return boolean contained True if the value is in the double-ended queue, false otherwise.
function DoubleEndedQueue:contains(value)
	for i = self._head, self._tail - 1 do
		if self._buffer[i] == value then
			return true
		end
	end
	return false
end

--- Clears the double-ended queue.
--- @return table DoubleEndedQueue The double-ended queue.
function DoubleEndedQueue:clear()
	self._head = 1
	self._tail = 1
	self._buffer = {}
	return self
end

return DoubleEndedQueue
