--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- Finds the shortest path between two points using Dijkstra's algorithm.
--- @param map table The map to search.
--- @param start table The starting point.
--- @param goal table The goal point.
--- @return table path The path from start to goal.
function dijkstra_path(map, start, goal)
	local path = {}
	local queue = {}
	local visited = {}
	local cameFrom = {}
	local costSoFar = {}
	local current = start
	local neighbors = {}
	local newCost = 0

	table.insert(queue, current)
	costSoFar[current] = 0

	while #queue > 0 do
		current = table.remove(queue, 1)
		if current == goal then
			break
		end

		neighbors = get_neighbors(map, current)
		for _, neighbor in ipairs(neighbors) do
			newCost = costSoFar[current] + 1
			if costSoFar[neighbor] == nil or newCost < costSoFar[neighbor] then
				costSoFar[neighbor] = newCost
				table.insert(queue, neighbor)
				cameFrom[neighbor] = current
			end
		end
	end

	current = goal
	while current ~= start do
		table.insert(path, 1, current)
		current = cameFrom[current]
	end
	table.insert(path, 1, start)

	return path
end
