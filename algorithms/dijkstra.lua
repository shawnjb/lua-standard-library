--- Search for the shortest path between two nodes in a graph using Dijkstra's algorithm.
---
--- @param graph table
--- @param start table
--- @param goal table
--- @return table path
local function dijkstra(graph, start, goal)
	local frontier = {}
	frontier[start] = 0
	local came_from = {}
	came_from[start] = nil

	while next(frontier) do
		local current = nil
		local current_cost = nil
		for node, cost in pairs(frontier) do
			if not current_cost or cost < current_cost then
				current = node
				current_cost = cost
			end
		end

		if current == goal then
			break
		end

		frontier[current] = nil

		for neighbor, cost in pairs(graph[current]) do
			local new_cost = current_cost + cost
			if not frontier[neighbor] or new_cost < frontier[neighbor] then
				frontier[neighbor] = new_cost
				came_from[neighbor] = current
			end
		end
	end

	local path = {}
	local current = goal
	while current do
		table.insert(path, 1, current)
		current = came_from[current]
	end

	return path
end

return dijkstra