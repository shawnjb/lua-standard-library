local queue = require("src.data_structures.queue")

local test_queue = queue.new()

test_queue:enqueue(1)
test_queue:enqueue(2)
test_queue:enqueue(3)

assert(test_queue:dequeue() == 1)
assert(test_queue:dequeue() == 2)
assert(test_queue:dequeue() == 3)

print("All tests passed!")

return true
