--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- Returns the neighbors of a point.
--- @param map table The map to search.
--- @param point table The point to search.
--- @return table neighbors The neighbors of the point.
function get_neighbors(map, point)
	local neighbors = {}
	local x = point.x
	local y = point.y

	if map[x - 1] ~= nil and map[x - 1][y] ~= nil then
		table.insert(neighbors, map[x - 1][y])
	end
	if map[x + 1] ~= nil and map[x + 1][y] ~= nil then
		table.insert(neighbors, map[x + 1][y])
	end
	if map[x][y - 1] ~= nil then
		table.insert(neighbors, map[x][y - 1])
	end
	if map[x][y + 1] ~= nil then
		table.insert(neighbors, map[x][y + 1])
	end

	return neighbors
end
