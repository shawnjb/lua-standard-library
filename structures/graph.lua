--- Graph data structure.
local graph = {}
graph.__index = graph

--- Creates a new graph.
--- @return table graph The new graph.
function graph:new()
	local o = { nodes = {}, edges = {} }
	setmetatable(o, self)
	return o
end

--- Inserts a new node in the graph.
--- @param value any The value of the node.
function graph:insertNode(value)
	local newNode = node:new(value)
	table.insert(self.nodes, newNode)
end

--- Inserts a new edge in the graph.
--- @param value any The value of the edge.
--- @param node1 table The first node.
--- @param node2 table The second node.
function graph:insertEdge(value, node1, node2)
	local newEdge = edge:new(value, node1, node2)
	table.insert(self.edges, newEdge)
end

--- Retrieves the node at the specified index.
--- @param index number The index of the node.
--- @return table node The node found.
function graph:getNode(index)
	return self.nodes[index]
end

--- Retrieves the edge at the specified index.
--- @param index number The index of the edge.
--- @return table edge The edge found.
function graph:getEdge(index)
	return self.edges[index]
end

--- Retrieves the number of nodes in the graph.
--- @return number count The number of nodes.
function graph:countNodes()
	return #self.nodes
end

--- Retrieves the number of edges in the graph.
--- @return number count The number of edges.
function graph:countEdges()
	return #self.edges
end

--- Checks if the graph is empty.
--- @return boolean isEmpty True if the graph is empty, false otherwise.
function graph:isEmpty()
	return #self.nodes == 0 and #self.edges == 0
end

function graph:free()
	self.nodes = nil
	self.edges = nil
end

return graph