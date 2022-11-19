local priorityqueue = {}
priorityqueue.__index = priorityqueue

--- Creates a new priority queue.
--- @return table priorityqueue The new priority queue.
function priorityqueue.new()
	local self = setmetatable({}, priorityqueue)
	self._queue = {}
	return self
end

--- Adds a value to the priority queue.
--- @param value any The value to add.
--- @return table priorityqueue The priority queue.
function priorityqueue:add(value)
	table.insert(self._queue, value)
	return self
end

--- Returns the number of values in the priority queue.
--- @return number values The number of values in the priority queue.
function priorityqueue:size()
	return #self._queue
end

--- Checks if the priority queue contains a value.
--- @param value any The value to check.
--- @return boolean contained True if the value is in the priority queue, false otherwise.
function priorityqueue:contains(value)
	for _, v in ipairs(self._queue) do
		if v == value then
			return true
		end
	end
	return false
end

--- Returns the value with the highest priority.
--- @return any value The value with the highest priority.
function priorityqueue:peek()
	local highest = 1
	for i = 2, #self._queue do
		if self._queue[i] > self._queue[highest] then
			highest = i
		end
	end
	return self._queue[highest]
end

--- Removes and returns the value with the highest priority.
--- @return any value The value with the highest priority.
function priorityqueue:pop()
	local highest = 1
	for i = 2, #self._queue do
		if self._queue[i] > self._queue[highest] then
			highest = i
		end
	end
	return table.remove(self._queue, highest)
end

return priorityqueue