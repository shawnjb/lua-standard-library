local circular_buffer = {}
circular_buffer.__index = circular_buffer

function circular_buffer.new(size)
    local buffer = {
        data = {},
        first = 1,
        last = 0,
        size = size
    }
    setmetatable(buffer, circular_buffer)
    return buffer
end

function circular_buffer:push(value)
    self.last = (self.last + 1) % self.size + 1
    self.data[self.last] = value
    if self.first == self.last then
        self.first = self.first % self.size + 1
    end
end

function circular_buffer:pop()
    if self:is_empty() then
        return nil
    end
    local value = self.data[self.first]
    self.data[self.first] = nil
    self.first = self.first % self.size + 1
    return value
end

function circular_buffer:is_empty()
    return self.first == self.last
end

function circular_buffer:__tostring()
    local str = ""
    for i = self.first, self.last do
        str = str .. self.data[i] .. " "
    end
    return str
end

return circular_buffer
