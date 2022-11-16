--- Hash data structure.
local hash = {}
hash.__index = hash

--- Creates a new hash.
--- @return table hash The new hash.
function hash:new()
	local o = { data = {} }
	setmetatable(o, self)
	return o
end

--- Inserts a new element in the hash.
--- @param key any The key of the element.
--- @param value any The value of the element.
function hash:insert(key, value)
	self.data[key] = value
end

--- Retrieves the element with the specified key.
--- @param key any The key of the element.
--- @return any value The value of the element.
function hash:get(key)
	return self.data[key]
end

--- Removes the element with the specified key.
--- @param key any The key of the element.
function hash:remove(key)
	self.data[key] = nil
end

--- Retrieves the number of elements in the hash.
--- @return number count The number of elements.
function hash:count()
	local count = 0
	for _ in pairs(self.data) do
		count = count + 1
	end
	return count
end

--- Checks if the hash is empty.
--- @return boolean isEmpty True if the hash is empty, false otherwise.
function hash:isEmpty()
	return self:count() == 0
end

function hash:free()
	self.data = nil
end

return hash