# Algorithms

## Binary Search
The `binary_search` function allows you to quickly search for a specific value in a sorted table. The function takes in a table, the value to search for, and an optional compare function, and returns the index of the element if it is present in the table, and `nil` otherwise.

## Dijkstra's Shortest Path
The `dijkstra_path` function calculates the shortest path between two nodes in a graph using Dijkstra's algorithm. The function takes in a graph represented as an adjacency matrix, the start node, and the end node, and returns a table containing the shortest path, or `nil` if there is no path.

### Usage

```lua
local graph = {
    {0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
    {1, 0, 1, 0, 0, 0, 0, 0, 0, 0},
    {0, 1, 0, 1, 0, 0, 0, 0, 0, 0},
    {0, 0, 1, 0, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 1, 0, 1, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 0, 1, 0, 0, 0},
    {0, 0, 0, 0, 0, 1, 0, 1, 0, 0},
    {0, 0, 0, 0, 0, 0, 1, 0, 1, 0},
    {0, 0, 0, 0, 0, 0, 0, 1, 0, 1},
    {0, 0, 0, 0, 0, 0, 0, 0, 1, 0}
}

--- 1 is the start node, 10 is the end node
local path = dijkstra_path(graph, 1, 10)
```


## Get Neighbors
The `get_neighbors` function returns all the neighbors of a given node in a graph represented as an adjacency list. The function takes in the adjacency list, and the node and returns a table of neighboring nodes.

## Deprecated: Tarjan's Connected Components
* The `get_tarjan_components` function is deprecated, and should no longer be used.

## Insertion Sort
The `insertion_sort` function sorts a table of elements in ascending order using the insertion sort algorithm. The function takes in the table, and an optional compare function, and returns the sorted table.

## Knapsack Problem
The `knapsack` function solves the knapsack problem, which is to determine the number of each item to include in a collection so that the total weight is less than a given limit and the total value is as large as possible. The function takes in a table of items, each represented as a table with fields 'value' and 'weight' and the maximum weight, and returns the maximum value that can be achieved and the combination of items achieving that value.

## Merge Sort
The `merge_sort` function sorts a table of elements in ascending order using the merge sort algorithm. The function takes in the table, and an optional compare function, and returns the sorted table.

## Minimum Spanning Tree
The `min_spanning_tree` function calculates the minimum spanning tree of a connected, undirected graph using the Kruskal's algorithm. The function takes in a table representing the edges of the graph, and returns a table of the edges that are part of the minimum spanning tree.

## Quick Sort
The `quick_sort` function sorts a table of elements in ascending order using the quick sort algorithm. The function takes in the table, and an optional compare function, and returns the sorted table.
