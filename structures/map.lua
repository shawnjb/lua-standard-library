--- Map data structure.

local map = {}
map.__index = map

--- Creates a new map.
--- @return table map The new map.
function map:new()
	local o = { data = {} }
	setmetatable(o, self)
	return o
end

--- Inserts a new element in the map.
--- @param key any The key of the element.
--- @param value any The value of the element.
function map:insert(key, value)
	self.data[key] = value
end

--- Retrieves the element with the specified key.
--- @param key any The key of the element.
--- @return any value The value of the element.
function map:get(key)
	return self.data[key]
end

--- Removes the element with the specified key.
--- @param key any The key of the element.
function map:remove(key)
	self.data[key] = nil
end

--- Retrieves the number of elements in the map.
--- @return number count The number of elements.
function map:count()
	local count = 0
	for _ in pairs(self.data) do
		count = count + 1
	end
	return count
end

--- Checks if the map is empty.
--- @return boolean isEmpty True if the map is empty, false otherwise.
function map:isEmpty()
	return self:count() == 0
end

function map:free()
	self.data = nil
end

return map
