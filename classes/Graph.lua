--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- @class Graph
--- @field private _vertices table<number, Vertex> The vertices in the graph.
--- @field private _edges table<number, table<number, Edge>> The edges in the graph.
Graph = {}
Graph.__index = Graph

--- Creates a new graph.
--- @return table Graph The new graph.
function Graph.new()
	local self = setmetatable({}, Graph)
	self._vertices = {}
	self._edges = {}
	return self
end

--- Returns the vertices in the graph.
--- @return table<number, Vertex> vertices The vertices in the graph.
function Graph:getVertices()
	return self._vertices
end

--- Returns the edges in the graph.
--- @return table<number, table<number, Edge>> edges The edges in the graph.
function Graph:getEdges()
	return self._edges
end

--- Adds a vertex to the graph.
--- @param value any The value of the vertex.
--- @return table Vertex The vertex.
function Graph:addVertex(value)
	local vertex = Vertex.new(value)
	self._vertices[#self._vertices + 1] = vertex
	self._edges[#self._edges + 1] = {}
	return vertex
end

--- Adds an edge to the graph.
--- @param from Vertex The vertex the edge is from.
--- @param to Vertex The vertex the edge is to.
--- @param weight number The weight of the edge.
--- @return table Edge The edge.
function Graph:addEdge(from, to, weight)
	local edge = Edge.new(from, to, weight)
	from:addEdge(edge)
	to:addEdge(edge)
	self._edges[from][to] = edge
	return edge
end

--- Removes a vertex from the graph.
--- @param vertex Vertex The vertex to remove.
--- @return table Graph The graph.
function Graph:removeVertex(vertex)
	for i = 1, #self._vertices do
		if self._vertices[i] == vertex then
			table.remove(self._vertices, i)
			break
		end
	end
	for i = 1, #self._edges do
		if self._edges[i] == vertex then
			table.remove(self._edges, i)
			break
		end
	end
	return self
end

--- Removes an edge from the graph.
--- @param edge Edge The edge to remove.
--- @return table Graph The graph.
function Graph:removeEdge(edge)
	local from = edge:getFrom()
	local to = edge:getTo()
	from:removeEdge(edge)
	to:removeEdge(edge)
	self._edges[from][to] = nil
	return self
end

--- Returns the edge between two vertices.
--- @param from Vertex The vertex the edge is from.
--- @param to Vertex The vertex the edge is to.
--- @return table Edge The edge.
function Graph:getEdge(from, to)
	return self._edges[from][to]
end

--- Returns the shortest path between two vertices.
--- @param from Vertex The vertex the path is from.
--- @param to Vertex The vertex the path is to.
--- @return table<number, Vertex> path The shortest path.
function Graph:getShortestPath(from, to)
	local distances = {}
	local previous = {}
	local queue = {}
	for i = 1, #self._vertices do
		local vertex = self._vertices[i]
		distances[vertex] = math.huge
		previous[vertex] = nil
		queue[i] = vertex
	end
	distances[from] = 0
	while #queue > 0 do
		local min = math.huge
		local minIndex = 1
		for i = 1, #queue do
			local vertex = queue[i]
			if distances[vertex] < min then
				min = distances[vertex]
				minIndex = i
			end
		end
		local vertex = queue[minIndex]
		table.remove(queue, minIndex)
		if vertex == to then
			break
		end
		local edges = vertex:getEdges()
		for i = 1, #edges do
			local edge = edges[i]
			local alt = distances[vertex] + edge:getWeight()
			local other = edge:getFrom() == vertex and edge:getTo() or edge:getFrom()
			if alt < distances[other] then
				distances[other] = alt
				previous[other] = vertex
			end
		end
	end
	local path = {}
	local vertex = to
	while vertex ~= nil do
		path[#path + 1] = vertex
		vertex = previous[vertex]
	end
	return path
end

return Graph
