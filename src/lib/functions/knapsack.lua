--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

local unpack = table.unpack

--- Solves the knapsack problem using dynamic programming
--- @param items table Containing the items and their values and weights
--- @param knapsack_size number The maximum capacity of the knapsack
--- @return number maximum, table selected The maximum value that can be fit into the knapsack and the selected items
function knapsack(items, knapsack_size)
    local n = #items
    local dp = {}
    for i = 0, n do dp[i] = {} for j = 0, knapsack_size do dp[i][j] = 0 end end
    local selected = {}

    for i = 1, n do
        local item = items[i]
        selected[i] = {}
        for j = 1, knapsack_size do
            if item.weight > j then
                dp[i][j] = dp[i-1][j]
                selected[i][j] = selected[i-1][j]
            else
                if item.value + dp[i-1][j-item.weight] > dp[i-1][j] then
                    dp[i][j] = item.value + dp[i-1][j-item.weight]
                    selected[i][j] = {unpack(selected[i-1][j-item.weight]), i}
                else
                    dp[i][j] = dp[i-1][j]
                    selected[i][j] = {unpack(selected[i-1][j])}
                end
            end
        end
    end
    return dp[n][knapsack_size], selected[n][knapsack_size]
end
