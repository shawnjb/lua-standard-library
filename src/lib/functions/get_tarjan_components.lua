--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

local function dfs(v, dfn, low, s, on_stack, idx, components)
	dfn[v] = idx
	low[v] = idx
	idx = idx + 1
	table.insert(s, v)
	on_stack[v] = true

	for _, w in ipairs(v.neighbors) do
		if dfn[w] == -1 then
			dfs(w, dfn, low, s, on_stack, idx, components)
			low[v] = math.min(low[v], low[w])
		elseif on_stack[w] then
			low[v] = math.min(low[v], dfn[w])
		end
	end

	if dfn[v] == low[v] then
		local component = {}
		local w
		repeat
			w = table.remove(s)
			on_stack[w] = false
			table.insert(component, w)
		until w == v
		table.insert(components, component)
	end

	return idx
end

--- Returns the strongly connected components of a directed graph
--- represented as an adjacency list.
--- @param graph table The graph to search.
--- @return table components A list of lists, where each list represents
--- a strongly connected component of the graph.
--- @deprecated
function get_tarjan_components(graph)
	local s = {}
	local dfn = {}
	local low = {}
	local idx = 1
	local on_stack = {}
	local components = {}

	for v in pairs(graph) do
		if not dfn[v] then
			idx = dfs(v, dfn, low, s, on_stack, idx, components)
		end
	end

	return components
end
