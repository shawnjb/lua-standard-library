--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- Finds a subset of the edges of a weighted graph that connects all the vertices together, without any cycles and with the minimum total edge weight. It is often used in network design and other optimization problems.
--- @param graph table The graph to find the minimum spanning tree of.
---
--- ```lua
--- local graph = {
---     {1, 2, 28},
---     {1, 6, 10},
---     {2, 3, 16},
---     {2, 7, 14},
---     {3, 4, 12},
---     {4, 5, 22},
---     {4, 7, 18},
---     {5, 6, 25},
---     {5, 7, 24},
--- }
--- ```
--- @return table minimum The minimum spanning tree.
function MinimumSpanningTree(graph)
    local function find_set(x)
        if x ~= graph[x] then
            graph[x] = find_set(graph[x])
        end
        return graph[x]
    end

    local function union(x, y)
        local xroot = find_set(x)
        local yroot = find_set(y)
        if xroot ~= yroot then
            graph[xroot] = yroot
        end
    end

    local function kruskal()
        local mst = {}
        local i = 0
        local e = 0
        while e < #graph - 1 do
            local x = graph[i].src
            local y = graph[i].dest
            local xroot = find_set(x)
            local yroot = find_set(y)
            if xroot ~= yroot then
                e = e + 1
                mst[e] = graph[i]
                union(xroot, yroot)
            end
            i = i + 1
        end
        return mst
    end

    local function sort_edges()
        local function compare(a, b)
            return a.weight < b.weight
        end
        table.sort(graph, compare)
    end

    local function make_set()
        for i = 1, #graph do
            graph[i] = {src = graph[i][1], dest = graph[i][2], weight = graph[i][3]}
            graph[i].src = i
            graph[i].dest = i
        end
    end

    make_set()
    sort_edges()
    return kruskal()
end
