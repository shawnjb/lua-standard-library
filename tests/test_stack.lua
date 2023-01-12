local stack = require("src.data_structures.stack")

local test_stack = stack.new()

test_stack:push(1)
test_stack:push(2)
test_stack:push(3)

assert(test_stack:pop() == 3)
assert(test_stack:pop() == 2)
assert(test_stack:pop() == 1)

print("All tests passed!")

return true
