local priority_queue = require("src.data_structures.priority_queue")
local dijkstra = {}

function dijkstra.shortest_path(graph, start, goal)
    local distance = {}
    local previous = {}
    local queue = priority_queue.new()

    for vertex, _ in pairs(graph.adj_list) do
        distance[vertex] = math.huge
        previous[vertex] = nil
    end

    distance[start] = 0
    queue:push(0, start)

    while queue:size() > 0 do
        local vertex = queue:pop()
        if vertex == goal then
            return dijkstra.reconstruct_path(previous, goal)
        end
        for neighbor in pairs(graph.adj_list[vertex]) do
            local new_distance = distance[vertex] + graph:get_edge_weight(vertex, neighbor)
            if new_distance < distance[neighbor] then
                distance[neighbor] = new_distance
                previous[neighbor] = vertex
                queue:push(new_distance, neighbor)
            end
        end
    end

    return nil
end

function dijkstra.reconstruct_path(previous, goal)
    local path = {goal}
    local current = goal
    while previous[current] do
        current = previous[current]
        table.insert(path, 1, current)
    end
    return path
end

return dijkstra
