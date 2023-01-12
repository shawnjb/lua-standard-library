local priority_queue = require("src.data_structures.priority_queue")

local test_queue = priority_queue.new()

test_queue:push(1, "Value1")
test_queue:push(2, "Value2")
test_queue:push(3, "Value3")

assert(test_queue:pop() == "Value1")
assert(test_queue:pop() == "Value2")
assert(test_queue:pop() == "Value3")

print("All tests passed!")

return true
