--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- @class PriorityQueue
--- @field private _heap table<number, any> The heap.
--- @field private _size number The size of the heap.
--- @field private _comparator function The comparator function.
PriorityQueue = {}
PriorityQueue.__index = PriorityQueue

--- Creates a new priority queue.
--- @param comparator function The comparator function.
--- @return table PriorityQueue The new priority queue.
function PriorityQueue.new(comparator)
	local self = setmetatable({}, PriorityQueue)
	self._heap = {}
	self._size = 0
	self._comparator = comparator
	return self
end

--- Adds a value to the priority queue.
--- @param value any The value to add.
--- @return table PriorityQueue The priority queue.
function PriorityQueue:add(value)
	self._size = self._size + 1
	self._heap[self._size] = value
	self:_bubbleUp(self._size)
	return self
end

--- Returns the value with the highest priority.
--- @return any value The value with the highest priority.
function PriorityQueue:peek()
	return self._heap[1]
end

--- Removes and returns the value with the highest priority.
--- @return any value The value with the highest priority.
function PriorityQueue:poll()
	local value = self._heap[1]
	self._heap[1] = self._heap[self._size]
	self._heap[self._size] = nil
	self._size = self._size - 1
	self:_bubbleDown(1)
	return value
end

--- Returns the number of values in the priority queue.
--- @return number values The number of values in the priority queue.
function PriorityQueue:size()
	return self._size
end

--- Checks if the priority queue contains a value.
--- @param value any The value to check.
--- @return boolean contained True if the value is in the priority queue, false otherwise.
function PriorityQueue:contains(value)
	for i = 1, self._size do
		if self._heap[i] == value then
			return true
		end
	end
	return false
end

--- Bubbles a value up the heap.
--- @param index number The index of the value.
function PriorityQueue:_bubbleUp(index)
	local parent = math.floor(index / 2)
	if parent >= 1 and self._comparator(self._heap[index], self._heap[parent]) then
		self._heap[index], self._heap[parent] = self._heap[parent], self._heap[index]
		self:_bubbleUp(parent)
	end
end

--- Bubbles a value down the heap.
--- @param index number The index of the value.
function PriorityQueue:_bubbleDown(index)
	local left = index * 2
	local right = left + 1
	local smallest = index
	if left <= self._size and self._comparator(self._heap[left], self._heap[smallest]) then
		smallest = left
	end
	if right <= self._size and self._comparator(self._heap[right], self._heap[smallest]) then
		smallest = right
	end
	if smallest ~= index then
		self._heap[index], self._heap[smallest] = self._heap[smallest], self._heap[index]
		self:_bubbleDown(smallest)
	end
end

return PriorityQueue
