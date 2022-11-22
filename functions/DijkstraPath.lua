--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- Reconstructs the path from the start to the goal. You can find an example of this function in the source code.
--- @param cameFrom table The table of nodes that were visited.
--- @param start table The start node.
--- @param goal table The goal node.
--- @return table path The path from the start to the goal.
function ReconstructPath(cameFrom, start, goal)
	local current = goal
	local path = {current}
	while current ~= start do
		current = cameFrom[current]
		table.insert(path, current)
	end
	return path
end

--- Search for the shortest path between two nodes using Dijkstra's algorithm.
---
--- ### Example
--- ```lua
--- local graph = {
--- 	["A"] = {B = 7, C = 9, F = 14},
--- 	["B"] = {A = 7, C = 10, D = 15},
--- 	["C"] = {A = 9, B = 10, D = 11, F = 2},
--- 	["D"] = {B = 15, C = 11, E = 6},
--- 	["E"] = {D = 6, F = 9},
--- 	["F"] = {A = 14, C = 2, E = 9}
--- }
---
--- local function printPath(path)
--- 	local result = ""
--- 	for i = 1, #path do
--- 		result = result .. path[i]
--- 		if i < #path then
--- 			result = result .. " -> "
--- 		end
--- 	end
--- 	print(result)
--- end
---
--- local path = DijkstraPath(graph, "A", "E")
--- printPath(path)
--- ```
--- @param graph table The graph to search.
--- @param start any The starting node.
--- @param goal any The goal node.
--- @return table path The shortest path between the start and goal nodes.
function DijkstraPath(graph, start, goal)
	local frontier = PriorityQueue.new(function(a, b) return a.cost < b.cost end)
	frontier:add(start, 0)
	local cameFrom = {}
	local costSoFar = {}
	cameFrom[start] = nil
	costSoFar[start] = 0
	while not frontier:isEmpty() do
		local current = frontier:pop()
		if current == goal then
			break
		end
		for next, cost in pairs(graph[current]) do
			local newCost = costSoFar[current] + cost
			if costSoFar[next] == nil or newCost < costSoFar[next] then
				costSoFar[next] = newCost
				local priority = newCost
				frontier:add(next, priority)
				cameFrom[next] = current
			end
		end
	end
	return ReconstructPath(cameFrom, start, goal)
end
