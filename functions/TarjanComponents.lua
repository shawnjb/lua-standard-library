--- @meta

--- Find the strongly connected components of a directed graph.
--- @param graph table The graph.
--- @return table components The strongly connected components.
function TarjanComponents(graph)
	local index = 0
	local stack = {}
	local components = {}
	local function strongConnect(node)
		node.index = index
		node.lowlink = index
		index = index + 1
		table.insert(stack, node)
		node.onStack = true
		for _, neighbor in ipairs(graph[node]) do
			if neighbor.index == nil then
				strongConnect(neighbor)
				node.lowlink = math.min(node.lowlink, neighbor.lowlink)
			elseif neighbor.onStack then
				node.lowlink = math.min(node.lowlink, neighbor.index)
			end
		end
		if node.lowlink == node.index then
			local component = {}
			local neighbor
			repeat
				neighbor = table.remove(stack)
				neighbor.onStack = false
				table.insert(component, neighbor)
			until neighbor == node
			table.insert(components, component)
		end
	end
	for node in pairs(graph) do
		if node.index == nil then
			strongConnect(node)
		end
	end
	return components
end
