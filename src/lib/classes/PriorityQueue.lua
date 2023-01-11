--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- @class PriorityQueue
--- @field queue table The queue.
--- @field comparator function A function that compares two elements and returns a boolean indicating which one has a higher priority.
local PriorityQueue = {}
PriorityQueue.__index = PriorityQueue

--- Create a new PriorityQueue
--- @param comparator function A function that compares two elements and returns a boolean indicating which one has a higher priority.
function PriorityQueue.new(comparator)
    local self = setmetatable({}, PriorityQueue)
    self.queue = {}
    self.comparator = comparator
    return self
end

--- Add an element to the queue.
--- @param value any the element to be added
function PriorityQueue:Push(value)
    local i = #self.queue + 1
    self.queue[i] = value
    while i > 1 and self.comparator(self.queue[i], self.queue[i // 2]) do
        self.queue[i], self.queue[i // 2] = self.queue[i // 2], self.queue[i]
        i = i // 2
    end
end

--- Retrieve the element with the highest priority in the queue.
--- @return any element The element with the highest priority in the queue
function PriorityQueue:Pop()
    local value = self.queue[1]
    self.queue[1] = self.queue[#self.queue]
    self.queue[#self.queue] = nil
    self:_heapify(1)
    return value
end

--- Returns the current number of elements in the queue
-- @return the number of elements in the queue
function PriorityQueue:Count()
    return #self.queue
end

--- Returns whether or not the queue is empty
--- @return boolean empty Whether or not the queue is empty
function PriorityQueue:IsEmpty()
    return #self.queue == 0
end

--- Reorder the queue to maintain the heap property
--- @param i number The current position being heapified
function PriorityQueue:_heapify(i)
    local smallest = i
    local l = 2 * i
    local r = 2 * i + 1
    if l <= #self.queue and self.comparator(self.queue[l], self.queue[smallest]) then
        smallest = l
    end
    if r <= #self.queue and self.comparator(self.queue[r], self.queue[smallest]) then
        smallest = r
    end
    if i ~= smallest then
        self.queue[i], self.queue[smallest] = self.queue[smallest], self.queue[i]
        self:_heapify(smallest)
    end
end
