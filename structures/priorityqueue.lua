--- Priority queue is a data structure that allows to insert elements with a priority and then retrieve them in order of priority.
local priorityqueue = {}
priorityqueue.__index = priorityqueue

--- Creates a new priority queue.
--- @return table priorityqueue The new priority queue.
function priorityqueue:new()
	local o = { heap = {} }
	setmetatable(o, self)
	return o
end

--- Inserts a new element in the priority queue.
--- @param value any The value of the element.
--- @param priority number The priority of the element.
function priorityqueue:insert(value, priority)
	local element = { value = value, priority = priority }
	table.insert(self.heap, element)
	self:heapifyUp(#self.heap)
end

--- Retrieves the element with the highest priority.
--- @return any value The value of the element.
function priorityqueue:pop()
	local element = self.heap[1]
	self.heap[1] = self.heap[#self.heap]
	table.remove(self.heap)
	self:heapifyDown(1)
	return element.value
end

--- Retrieves the element with the highest priority without removing it.
--- @return any value The value of the element.
function priorityqueue:peek()
	return self.heap[1].value
end

--- Retrieves the number of elements in the priority queue.
--- @return number count The number of elements.
function priorityqueue:count()
	return #self.heap
end

--- Checks if the priority queue is empty.
--- @return boolean isEmpty True if the priority queue is empty, false otherwise.
function priorityqueue:isEmpty()
	return #self.heap == 0
end

--- Heapifies the priority queue up.
--- @param index number The index of the element to heapify.
function priorityqueue:heapifyUp(index)
	local parent = math.floor(index / 2)
	if parent >= 1 and self.heap[parent].priority < self.heap[index].priority then
		self:swap(parent, index)
		self:heapifyUp(parent)
	end
end

--- Heapifies the priority queue down.
--- @param index number The index of the element to heapify.
function priorityqueue:heapifyDown(index)
	local left = index * 2
	local right = index * 2 + 1
	local largest = index
	if left <= #self.heap and self.heap[left].priority > self.heap[largest].priority then
		largest = left
	end
	if right <= #self.heap and self.heap[right].priority > self.heap[largest].priority then
		largest = right
	end
	if largest ~= index then
		self:swap(index, largest)
		self:heapifyDown(largest)
	end
end

--- Swaps two elements in the priority queue.
--- @param index1 number The index of the first element.
--- @param index2 number The index of the second element.
function priorityqueue:swap(index1, index2)
	local temp = self.heap[index1]
	self.heap[index1] = self.heap[index2]
	self.heap[index2] = temp
end

function priorityqueue:free()
	self.heap = nil
end

return priorityqueue
