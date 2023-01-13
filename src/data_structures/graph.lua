local graph = {}
graph.__index = graph

function graph.new()
    local graph = setmetatable({}, graph)
    graph.adj_list = {}
    return graph
end

function graph:add_vertex(vertex)
    if not self.adj_list[vertex] then
        self.adj_list[vertex] = {}
    end
end

function graph:add_edge(vertex1, vertex2, weight)
    weight = weight or 1
    self:add_vertex(vertex1)
    self:add_vertex(vertex2)
    self.adj_list[vertex1][vertex2] = weight
    self.adj_list[vertex2][vertex1] = weight
end

function graph:get_edge_weight(vertex1, vertex2)
    return self.adj_list[vertex1][vertex2]
end

function graph:remove_edge(vertex1, vertex2)
    self.adj_list[vertex1][vertex2] = nil
    self.adj_list[vertex2][vertex1] = nil
end

function graph:remove_vertex(vertex)
    for neighbor in pairs(self.adj_list[vertex]) do
        self.adj_list[neighbor][vertex] = nil
    end
    self.adj_list[vertex] = nil
end

function graph:__tostring()
    local str = ""
    for vertex, neighbors in pairs(self.adj_list) do
        str = str .. vertex .. " -> "
        for neighbor in pairs(neighbors) do
            str = str .. neighbor .. " "
        end
        str = str .. "\n"
    end
    return str
end

return graph
