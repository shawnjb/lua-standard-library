--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- Selects a subset of items that have the highest value, but whose total weight is less than or equal to a given limit.
--- @param items table The items to choose from.
--- @param limit number The maximum weight.
--- @return table selection The selected items.
function Knapsack(items, limit)
    local function recurse(i, size)
        if i == 0 then
            return {value = 0, size = 0, chosen = {}}
        elseif size == 0 then
            return {value = 0, size = 0, chosen = {}}
        elseif items[i].size > size then
            return recurse(i - 1, size)
        else
            local r0 = recurse(i - 1, size)
            local r1 = recurse(i - 1, size - items[i].size)
            r1.value = r1.value + items[i].value
            if r1.value > r0.value then
                r1.size = r1.size + items[i].size
                r1.chosen[i] = true
                return r1
            else
                return r0
            end
        end
    end
    return recurse(#items, limit)
end
