--- @meta

--- @class Vertex
--- @field private _edges table<number, Edge> The edges of the vertex.
--- @field private _value any The value of the vertex.
Vertex = {}
Vertex.__index = Vertex

--- Creates a new vertex.
--- @param value any The value of the vertex.
--- @return table Vertex The new vertex.
function Vertex.new(value)
	local self = setmetatable({}, Vertex)
	self._edges = {}
	self._value = value
	return self
end

--- Returns the value of the vertex.
--- @return any value The value of the vertex.
function Vertex:getValue()
	return self._value
end

--- Returns the edges of the vertex.
--- @return table<number, Edge> edges The edges of the vertex.
function Vertex:getEdges()
	return self._edges
end

--- Adds an edge to the vertex.
--- @param edge Edge The edge to add.
--- @return table Vertex The vertex.
function Vertex:addEdge(edge)
	self._edges[#self._edges + 1] = edge
	return self
end

--- Removes an edge from the vertex.
--- @param edge Edge The edge to remove.
--- @return table Vertex The vertex.
function Vertex:removeEdge(edge)
	for i = 1, #self._edges do
		if self._edges[i] == edge then
			table.remove(self._edges, i)
			break
		end
	end
	return self
end

return Vertex
