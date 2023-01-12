local stack = {}
stack.__index = stack

function stack.new()
    local new_stack = {}
    setmetatable(new_stack, stack)
    new_stack.data = {}
    return new_stack
end

function stack:push(value)
    table.insert(self.data, value)
end

function stack:pop()
    local value = self.data[#self.data]
    table.remove(self.data, #self.data)
    return value
end

function stack:peek()
    return self.data[#self.data]
end

return stack
