--- TarjanComponents.ex.lua
---
--- This example demonstrates the use of the TarjanComponents class.
--- It reads a graph from a file and computes the strongly connected
--- components of the graph.
---
--- The graph is specified in a file. The first line of the file
--- contains the number of vertices. Each subsequent line contains
--- the number of the vertex followed by the numbers of the vertices
--- adjacent to it.

require "TarjanComponents"

local file = assert(io.open("TarjanComponents.ex.txt", "r"), "Could not open file.")
local n = tonumber(file:read("*l"))
local graph = {}

for i = 1, n do
    graph[i] = {}
end

for line in file:lines() do
    local i = 1
    local v = {}
    for number in line:gmatch("%d+") do
        v[i] = tonumber(number)
        i = i + 1
    end
    local u = v[1]
    for i = 2, #v do
        graph[u][#graph[u] + 1] = v[i]
    end
end

file:close()

local components = TarjanComponents(graph)
local n = components:size()

for i = 1, n do
    local component = components:get(i)
    io.write("{")
    for j = 1, #component do
        io.write(component[j])
        if j < #component then
            io.write(", ")
        end
    end
    io.write("}\n")
end
