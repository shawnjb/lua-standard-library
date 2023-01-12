local priority_queue = {}
priority_queue.__index = priority_queue

function priority_queue.new()
    local new_priority_queue = {}
    setmetatable(new_priority_queue, priority_queue)
    new_priority_queue.heap = {}
    new_priority_queue.size = 0
    return new_priority_queue
end

function priority_queue:push(priority, value)
    local item = {priority = priority, value = value}
    self.size = self.size + 1
    self.heap[self.size] = item
    self:bubble_up(self.size)
end

function priority_queue:pop()
    local item = self.heap[1]
    self.heap[1] = self.heap[self.size]
    self.heap[self.size] = nil
    self.size = self.size - 1
    self:bubble_down(1)
    return item.value
end

function priority_queue:peek()
    return self.heap[1].value
end

function priority_queue:bubble_up(index)
    local parent_index = math.floor(index / 2)
    if parent_index < 1 then
        return
    end
    if self.heap[parent_index].priority > self.heap[index].priority then
        self.heap[parent_index], self.heap[index] = self.heap[index], self.heap[parent_index]
        self:bubble_up(parent_index)
    end
end

function priority_queue:bubble_down(index)
    local left_child_index = index * 2
    local right_child_index = index * 2 + 1
    local smallest_child_index = nil
    if left_child_index <= self.size then
        smallest_child_index = left_child_index
    end
    if right_child_index <= self.size and self.heap[right_child_index].priority < self.heap[left_child_index].priority then
        smallest_child_index = right_child_index
    end
    if smallest_child_index ~= nil and self.heap[index].priority > self.heap[smallest_child_index].priority then
        self.heap[index], self.heap[smallest_child_index] = self.heap[smallest_child_index], self.heap[index]
        self:bubble_down(smallest_child_index)
    end
end

return priority_queue
