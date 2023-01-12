local queue = {}
queue.__index = queue

function queue.new()
    local new_queue = {}
    setmetatable(new_queue, queue)
    new_queue.first = 0
    new_queue.last = -1
    return new_queue
end

function queue:enqueue(value)
    local last = self.last + 1
    self.last = last
    self[last] = value
end

function queue:dequeue()
    local first = self.first
    if first > self.last then error("queue is empty") end
    local value = self[first]
    self[first] = nil
    self.first = first + 1
    return value
end

function queue:peek()
    local first = self.first
    if first > self.last then error("queue is empty") end
    return self[first]
end

return queue
