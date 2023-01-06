--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- @class Edge
--- @field private _from Vertex
--- @field private _to Vertex
--- @field private _weight number
Edge = {}
Edge.__index = Edge

--- Creates a new edge.
--- @param from Vertex
--- @param to Vertex
--- @param weight number
--- @return table Edge The new edge.
function Edge.new(from, to, weight)
	local self = setmetatable({}, Edge)
	self._from = from
	self._to = to
	self._weight = weight
	return self
end

--- Returns the vertex the edge is from.
--- @return table Vertex The vertex the edge is from.
function Edge:getFrom()
	return self._from
end

--- Returns the vertex the edge is to.
--- @return table Vertex The vertex the edge is to.
function Edge:getTo()
	return self._to
end

--- Returns the weight of the edge.
--- @return number weight The weight of the edge.
function Edge:getWeight()
	return self._weight
end

return Edge
