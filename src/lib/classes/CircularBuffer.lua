--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- @class CircularBuffer
--- @field buffer table The buffer.
--- @field start number The start index.
--- @field finish number The finish index.
--- @field size number The size of the buffer.
local CircularBuffer = {}
CircularBuffer.__index = CircularBuffer

--- Create a new CircularBuffer.
--- @param size number The size of the buffer.
function CircularBuffer.new(size)
	local self = setmetatable({}, CircularBuffer)
	self.buffer = {}
	self.start = 1
	self.finish = 1
	self.size = size
	return self
end

--- Add an element to the buffer.
--- @param value any The value to add.
function CircularBuffer:Push(value)
	self.buffer[self.finish] = value
	self.finish = (self.finish % self.size) + 1
	if self.finish == self.start then
		self.start = (self.start % self.size) + 1
	end
end

--- Retrieve the oldest element in the buffer.
--- @return any value The oldest element in the buffer.
function CircularBuffer:Pop()
	local value = self.buffer[self.start]
	self.buffer[self.start] = nil
	self.start = (self.start % self.size) + 1
	return value
end

--- Retrieve the most recent element in the buffer.
--- @return any value The most recent element in the buffer.
function CircularBuffer:Peek()
	local i = self.finish - 1
	if i < self.start then
		i = self.start
	end
	return self.buffer[i]
end

--- Returns the current number of elements in the buffer.
--- @return number count The number of elements in the buffer.
function CircularBuffer:Count()
	return self.finish - self.start
end

--- Returns whether or not the buffer is full.
--- @return boolean full Whether or not the buffer is full.
function CircularBuffer:IsFull()
	return self:Count() == self.size
end

function CircularBuffer:__len()
	return self:Count()
end

function CircularBuffer:__eq(other)
	return self.buffer == other.buffer
		and self.start == other.start
		and self.finish == other.finish
		and self.size == other.size
end

function CircularBuffer:__tostring()
	return string.format("CircularBuffer: %s", table.concat(self.buffer, ", "))
end
