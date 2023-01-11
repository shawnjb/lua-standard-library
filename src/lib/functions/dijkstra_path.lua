--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- Finds the shortest path between two points using Dijkstra's algorithm.
--- @param map table The map to search.
--- @param start_node number The starting point.
--- @param end_node number The goal point.
--- @return table? path The path from start to goal.
function dijkstra_path(map, start_node, end_node)
	local path = {}
	local visited = {}
	local queue = {}
	local distances = {}
	local previous = {}

	for i = 1, #map do
		distances[i] = math.huge
		previous[i] = nil
	end

	distances[start_node] = 0
	queue[start_node] = start_node

	while next(queue) do
		local current = nil
		local current_distance = math.huge

		for node, _ in pairs(queue) do
			if distances[node] < current_distance then
				current = node
				current_distance = distances[node]
			end
		end

		if current == end_node then
			while previous[current] do
				table.insert(path, 1, current)
				current = previous[current]
			end

			return path
		end

		visited[current] = true
		queue[current] = nil

		for _, node in ipairs(map[current]) do
			if not visited[node] then
				local alt = distances[current] + 1

				if alt < distances[node] then
					distances[node] = alt
					previous[node] = current
					queue[node] = node
				end
			end
		end
	end
end
