--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- A double-ended queue.
--- @class DoubleEndedQueue
--- @field queue table The queue.
--- @field first number The first index.
--- @field last number The last index.
local DoubleEndedQueue = {}
DoubleEndedQueue.__index = DoubleEndedQueue

--- Creates a new double-ended queue.
--- @return DoubleEndedQueue
function DoubleEndedQueue.new()
	local self = setmetatable({}, DoubleEndedQueue)
	self.queue = {}
	self.first = 1
	self.last = 0
	return self
end

--- Add an element to the front of the queue.
--- @param value any The value to add.
function DoubleEndedQueue:PushFront(value)
	local first = self.first - 1
	self.first = first
	self.queue[first] = value
end

--- Add an element to the back of the queue.
--- @param value any The value to add.
function DoubleEndedQueue:PushBack(value)
	local last = self.last + 1
	self.last = last
	self.queue[last] = value
end


--- Retrieve the first element in the queue.
--- @return any value The first element in the queue.
function DoubleEndedQueue:PopFront()
	local first = self.first
	if first > self.last then return end
	local value = self.queue[first]
	self.queue[first] = nil
	self.first = first + 1
	return value
end

--- Retrieve the last element in the queue.
--- @return any value The last element in the queue.
function DoubleEndedQueue:PopBack()
	local last = self.last
	if self.first > last then return end
	local value = self.queue[last]
	self.queue[last] = nil
	self.last = last - 1
	return value
end

--- Retrieve the first element in the queue.
--- @return any value The first element in the queue.
function DoubleEndedQueue:PeekFront()
	return self.queue[self.first]
end

--- Retrieve the last element in the queue.
--- @return any value The last element in the queue.
function DoubleEndedQueue:PeekBack()
	return self.queue[self.last]
end

--- Returns the current number of elements in the queue.
--- @return number count The number of elements in the queue.
function DoubleEndedQueue:Count()
	return self.last - self.first + 1
end

--- Returns whether or not the queue is empty.
--- @return boolean empty Whether or not the queue is empty.
function DoubleEndedQueue:IsEmpty()
	return self:Count() == 0
end

return DoubleEndedQueue
