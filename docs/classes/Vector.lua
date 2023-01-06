--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- @class Vector
--- @field private _x number The x component.
--- @field private _y number The y component.
Vector = {}
Vector.__index = Vector

--- Creates a new vector.
--- @param x number The x component.
--- @param y number The y component.
--- @return table Vector The new vector.
function Vector.new(x, y)
	local self = setmetatable({}, Vector)
	self._x = x
	self._y = y
	return self
end

--- Returns the x component.
--- @return number x The x component.
function Vector:x()
	return self._x
end

--- Returns the y component.
--- @return number y The y component.
function Vector:y()
	return self._y
end

--- Returns the magnitude of the vector.
--- @return number magnitude The magnitude of the vector.
function Vector:magnitude()
	return math.sqrt(self._x * self._x + self._y * self._y)
end

--- Returns the normalized vector.
--- @return table Vector The normalized vector.
function Vector:normalize()
	local magnitude = self:magnitude()
	return Vector.new(self._x / magnitude, self._y / magnitude)
end

--- Returns the vector as a string.
--- @return string string The vector as a string.
function Vector:__tostring()
	return "(" .. self._x .. ", " .. self._y .. ")"
end
