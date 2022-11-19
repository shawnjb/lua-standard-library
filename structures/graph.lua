-- In computer science, a graph is an abstract data type that is meant to implement the undirected graph and directed graph concepts from the field of graph theory within mathematics.
--
-- A graph data structure consists of a finite (and possibly mutable) set of vertices (also called nodes or points), together with a set of unordered pairs of these vertices for an undirected graph or a set of ordered pairs for a directed graph. These pairs are known as edges (also called links or lines), and for a directed graph are also known as edges but also sometimes arrows or arcs. The vertices may be part of the graph structure, or may be external entities represented by integer indices or references.
--
-- A graph data structure may also associate to each edge some edge value, such as a symbolic label or a numeric attribute (cost, capacity, length, etc.).

local graph = {}
graph.__index = graph

--- Creates a new graph.
--- @param directed boolean If true, the graph will be directed.
--- @return table graph The new graph.
function graph.new(directed)
	local self = setmetatable({}, graph)
	self.directed = directed
	self.vertices = {}
	self.edges = {}
	return self
end

--- Adds a vertex to the graph.
--- @param vertex any The vertex to add.
--- @return table vertex The vertex added.
function graph:addVertex(vertex)
	if self.vertices[vertex] then
		return self.vertices[vertex]
	end
	self.vertices[vertex] = vertex
	self.edges[vertex] = {}
	return vertex
end

--- Adds an edge to the graph.
--- @param from any The vertex to add the edge from.
--- @param to any The vertex to add the edge to.
--- @param weight number The weight of the edge.
--- @return table edge The edge added.
function graph:addEdge(from, to, weight)
	self:addVertex(from)
	self:addVertex(to)
	self.edges[from][to] = weight
	if not self.directed then
		self.edges[to][from] = weight
	end
	return {from = from, to = to, weight = weight}
end

--- Removes a vertex from the graph.
--- @param vertex any The vertex to remove.
--- @return table? vertex The vertex removed.
function graph:removeVertex(vertex)
	if not self.vertices[vertex] then
		return nil
	end
	self.vertices[vertex] = nil
	for v, _ in pairs(self.edges[vertex]) do
		self.edges[v][vertex] = nil
	end
	self.edges[vertex] = nil
	return vertex
end

--- Removes an edge from the graph.
--- @param from any The vertex to remove the edge from.
--- @param to any The vertex to remove the edge to.
--- @return table? edge The edge removed.
function graph:removeEdge(from, to)
	if not self.edges[from] or not self.edges[from][to] then
		return nil
	end
	local weight = self.edges[from][to]
	self.edges[from][to] = nil
	if not self.directed then
		self.edges[to][from] = nil
	end
	return {from = from, to = to, weight = weight}
end

--- Returns the weight of an edge.
--- @param from any The vertex to get the edge from.
--- @param to any The vertex to get the edge to.
--- @return number weight The weight of the edge.
function graph:getEdgeWeight(from, to)
	return self.edges[from][to]
end

--- Returns the vertices of the graph.
--- @return table vertices The vertices of the graph.
function graph:getVertices()
	return self.vertices
end

--- Returns the edges of the graph.
--- @return table edges The edges of the graph.
function graph:getEdges()
	local edges = {}
	for from, edges in pairs(self.edges) do
		for to, weight in pairs(edges) do
			table.insert(edges, {from = from, to = to, weight = weight})
		end
	end
	return edges
end

--- Returns the neighbors of a vertex.
--- @param vertex any The vertex to get the neighbors of.
--- @return table neighbors The neighbors of the vertex.
function graph:getNeighbors(vertex)
	return self.edges[vertex]
end

--- Returns the degree of a vertex.
--- @param vertex any The vertex to get the degree of.
--- @return number degree The degree of the vertex.
function graph:getDegree(vertex)
	return #self.edges[vertex]
end

--- Returns the number of vertices in the graph.
--- @return number size The number of vertices in the graph.
function graph:getSize()
	return #self.vertices
end

--- Returns the number of edges in the graph.
--- @return number size The number of edges in the graph.
function graph:getEdgeSize()
	local size = 0
	for _, edges in pairs(self.edges) do
		size = size + #edges
	end
	if not self.directed then
		size = size / 2
	end
	return size
end

--- Returns the adjacency matrix of the graph.
--- @return table matrix The adjacency matrix of the graph.
function graph:getAdjacencyMatrix()
	local matrix = {}
	for from, edges in pairs(self.edges) do
		matrix[from] = {}
		for to, weight in pairs(edges) do
			matrix[from][to] = weight
		end
	end
	return matrix
end

--- Returns the adjacency list of the graph.
--- @return table list The adjacency list of the graph.
function graph:getAdjacencyList()
	local list = {}
	for from, edges in pairs(self.edges) do
		list[from] = {}
		for to, weight in pairs(edges) do
			table.insert(list[from], {to = to, weight = weight})
		end
	end
	return list
end

--- Find the given value in the array, and return the index of the value.
--- Nothing is returned if the value is not found.
--- @param array table The array to search.
--- @param value any The value to search for.
--- @return number? index The index of the value.
function table.find(array, value)
	for i, v in ipairs(array) do
		if v == value then
			return i
		end
	end
end

--- Returns a copy of an array in reverse order.
--- @param array table The array to reverse.
--- @return table reversed The reversed array.
function table.reverse(array)
	local reversed = {}
	for i = #array, 1, -1 do
		table.insert(reversed, array[i])
	end
	return reversed
end

--- Returns the shortest path between two vertices.
--- @param from any The vertex to get the path from.
--- @param to any The vertex to get the path to.
--- @return table path The shortest path between the vertices.
function graph:getShortestPath(from, to)
	local distances = {}
	local previous = {}
	local nodes = self.vertices
	for vertex, _ in pairs(nodes) do
		if vertex == from then
			distances[vertex] = 0
		else
			distances[vertex] = math.huge
		end
		previous[vertex] = nil
	end
	local unvisited = {}
	for vertex, _ in pairs(nodes) do
		table.insert(unvisited, vertex)
	end
	while #unvisited > 0 do
		local current = nil
		for _, vertex in ipairs(unvisited) do
			if current == nil or distances[vertex] < distances[current] then
				current = vertex
			end
		end
		if current == to then
			break
		end
		table.remove(unvisited, table.find(unvisited, current))
		for neighbor, _ in pairs(self.edges[current]) do
			local alt = distances[current] + self.edges[current][neighbor]
			if alt < distances[neighbor] then
				distances[neighbor] = alt
				previous[neighbor] = current
			end
		end
	end
	local path = {to}
	local u = previous[to]
	while u do
		table.insert(path, u)
		u = previous[u]
	end
	path = table.reverse(path)
	return path
end

return graph