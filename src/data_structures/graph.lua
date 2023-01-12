local graph = {}
graph.__index = graph

function graph.new(num_vertices)
    local new_graph = {}
    setmetatable(new_graph, graph)
    new_graph.num_vertices = num_vertices
    new_graph.adjacency_list = {}
    for i = 1, num_vertices do
        new_graph.adjacency_list[i] = {}
    end
    return new_graph
end

function graph:add_edge(from, to)
    table.insert(self.adjacency_list[from], to)
end

function graph:remove_edge(from, to)
    for i, v in ipairs(self.adjacency_list[from]) do
        if v == to then
            table.remove(self.adjacency_list[from], i)
            return
        end
    end
end

function graph:__tostring()
    local str = ""
    for i = 1, self.num_vertices do
        str = str .. i .. " -> "
        for j = 1, #self.adjacency_list[i] do
            str = str .. self.adjacency_list[i][j] .. " "
        end
        str = str .. "\n"
    end
    return str
end

return graph
