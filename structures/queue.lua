--- Queue data structure.

local queue = {}
queue.__index = queue

--- Creates a new queue.
--- @return table queue The new queue.
function queue:new()
	local o = { first = 0, last = -1 }
	setmetatable(o, self)
	return o
end

--- Inserts a new element in the queue.
--- @param value any The value of the element.
function queue:insert(value)
	local last = self.last + 1
	self.last = last
	self[last] = value
end

--- Retrieves the first element in the queue.
--- @return any value The value of the element.
function queue:pop()
	local first = self.first
	if first > self.last then
		error("queue is empty")
	end
	local value = self[first]
	self[first] = nil
	self.first = first + 1
	return value
end

--- Retrieves the first element in the queue without removing it.
--- @return any value The value of the element.
function queue:peek()
	return self[self.first]
end

--- Retrieves the number of elements in the queue.
--- @return number count The number of elements.
function queue:count()
	return self.last - self.first + 1
end

--- Checks if the queue is empty.
--- @return boolean isEmpty True if the queue is empty, false otherwise.
function queue:isEmpty()
	return self.first > self.last
end

return queue
