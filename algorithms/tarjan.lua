--- Tarjan's algorithm is a graph theory algorithm for finding the strongly connected components of a graph. It is a linear-time algorithm that is useful for many graph algorithms.
--- @param graph table
--- @return table components
local function tarjan(graph)
	local index = 0
	local stack = {}
	local components = {}
	local function strongconnect(node)
		node.index = index
		node.lowlink = index
		index = index + 1
		table.insert(stack, node)
		node.onstack = true
		for _, neighbor in ipairs(node.neighbors) do
			if neighbor.index == nil then
				strongconnect(neighbor)
				node.lowlink = math.min(node.lowlink, neighbor.lowlink)
			elseif neighbor.onstack then
				node.lowlink = math.min(node.lowlink, neighbor.index)
			end
		end
		if node.lowlink == node.index then
			local component = {}
			while true do
				local element = table.remove(stack)
				element.onstack = false
				table.insert(component, element)
				if element == node then
					break
				end
			end
			table.insert(components, component)
		end
	end
	for _, node in ipairs(graph) do
		if node.index == nil then
			strongconnect(node)
		end
	end
	return components
end

return tarjan