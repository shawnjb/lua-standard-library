local circularbuffer = require("structures.circularbuffer")
local doubleendedqueue = require("structures.doubleendedqueue")
local priorityqueue = require("structures.priorityqueue")

--- @class queue: table
--- @field private _type string
--- @field private _data table
local queue = {}
queue.__index = queue

--- Creates a new queue.
--- @param type string The type of queue to create.
--- @return table queue The new queue.
function queue.new(type)
	if type == "circularbuffer" then
		return circularbuffer:new()
	elseif type == "doubleendedqueue" then
		return doubleendedqueue:new()
	elseif type == "priorityqueue" then
		return priorityqueue:new()
	end
end

return queue