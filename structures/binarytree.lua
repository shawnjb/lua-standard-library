local binarytree = {}
binarytree.__index = binarytree

--- Creates a new binary tree.
--- @param value any The value of the root node.
--- @return table binarytree The new binary tree.
function binarytree.new(value)
	local self = setmetatable({}, binarytree)
	self.value = value
	self.left = nil
	self.right = nil
	return self
end

--- Adds a value to the binary tree.
--- @param value any The value to add.
--- @return table binarytree The binary tree.
function binarytree:add(value)
	if value < self.value then
		if self.left then
			self.left:add(value)
		else
			self.left = binarytree.new(value)
		end
	else
		if self.right then
			self.right:add(value)
		else
			self.right = binarytree.new(value)
		end
	end
	return self
end

--- Checks if the binary tree contains a value.
--- @param value any The value to check.
--- @return boolean contained True if the value is in the binary tree, false otherwise.
function binarytree:contains(value)
	if value == self.value then
		return true
	elseif value < self.value then
		if self.left then
			return self.left:contains(value)
		else
			return false
		end
	else
		if self.right then
			return self.right:contains(value)
		else
			return false
		end
	end
end

--- Returns the number of nodes in the binary tree.
--- @return number nodes The number of nodes in the binary tree.
function binarytree:size()
	local size = 1
	if self.left then
		size = size + self.left:size()
	end
	if self.right then
		size = size + self.right:size()
	end
	return size
end

--- Returns the height of the binary tree.
--- @return number height The height of the binary tree.
function binarytree:height()
	local height = 0
	if self.left then
		height = math.max(height, self.left:height())
	end
	if self.right then
		height = math.max(height, self.right:height())
	end
	return height + 1
end

--- Returns the depth of a value in the binary tree.
--- @param value any The value to check.
--- @return number? depth The depth of the value in the binary tree.
function binarytree:depth(value)
	if value == self.value then
		return 0
	elseif value < self.value then
		if self.left then
			return self.left:depth(value) + 1
		else
			return nil
		end
	else
		if self.right then
			return self.right:depth(value) + 1
		else
			return nil
		end
	end
end

--- Returns the minimum value in the binary tree.
--- @return any min The minimum value in the binary tree.
function binarytree:min()
	if self.left then
		return self.left:min()
	else
		return self.value
	end
end

--- Returns the maximum value in the binary tree.
--- @return any max The maximum value in the binary tree.
function binarytree:max()
	if self.right then
		return self.right:max()
	else
		return self.value
	end
end

--- Returns the values in the binary tree in order.
--- @return table values The values in the binary tree in order.
function binarytree:inorder()
	local values = {}
	if self.left then
		for _, value in ipairs(self.left:inorder()) do
			table.insert(values, value)
		end
	end
	table.insert(values, self.value)
	if self.right then
		for _, value in ipairs(self.right:inorder()) do
			table.insert(values, value)
		end
	end
	return values
end

--- Returns the values in the binary tree in preorder.
--- @return table values The values in the binary tree in preorder.
function binarytree:preorder()
	local values = { self.value }
	if self.left then
		for _, value in ipairs(self.left:preorder()) do
			table.insert(values, value)
		end
	end
	if self.right then
		for _, value in ipairs(self.right:preorder()) do
			table.insert(values, value)
		end
	end
	return values
end

--- Returns the values in the binary tree in postorder.
--- @return table values The values in the binary tree in postorder.
function binarytree:postorder()
	local values = {}
	if self.left then
		for _, value in ipairs(self.left:postorder()) do
			table.insert(values, value)
		end
	end
	if self.right then
		for _, value in ipairs(self.right:postorder()) do
			table.insert(values, value)
		end
	end
	table.insert(values, self.value)
	return values
end

--- Returns the values in the binary tree in level order.
--- @return table values The values in the binary tree in level order.
function binarytree:levelorder()
	local values = {}
	local queue = { self }
	while #queue > 0 do
		local node = table.remove(queue, 1)
		table.insert(values, node.value)
		if node.left then
			table.insert(queue, node.left)
		end
		if node.right then
			table.insert(queue, node.right)
		end
	end
	return values
end

--- Returns the values in the binary tree in reverse level order.
--- @return table values The values in the binary tree in reverse level order.
function binarytree:reverselevelorder()
	local values = {}
	local queue = { self }
	while #queue > 0 do
		local node = table.remove(queue, 1)
		table.insert(values, 1, node.value)
		if node.right then
			table.insert(queue, node.right)
		end
		if node.left then
			table.insert(queue, node.left)
		end
	end
	return values
end

--- Returns the values in the binary tree in zigzag order.
--- @return (table|string) values The values in the binary tree in zigzag order.
function binarytree:zigzagorder()
	local values = {}
	local queue = { self }
	local level = 0
	while #queue > 0 do
		local node = table.remove(queue, 1)
		if not values[level] then
			values[level] = {}
		end
		table.insert(values[level], node.value)
		if node.left then
			table.insert(queue, node.left)
		end
		if node.right then
			table.insert(queue, node.right)
		end
		if #queue == 0 then
			level = level + 1
		end
	end
	for i = 1, #values do
		if i % 2 == 0 then
			values[i] = table.reverse(values[i])
		end
	end
	return table.concat(values)
end

--- Returns the values in the binary tree in spiral order.
--- @return (table|string) values The values in the binary tree in spiral order.
function binarytree:spiralorder()
	local values = {}
	local queue = { self }
	local level = 0
	while #queue > 0 do
		local node = table.remove(queue, 1)
		if not values[level] then
			values[level] = {}
		end
		table.insert(values[level], node.value)
		if node.right then
			table.insert(queue, node.right)
		end
		if node.left then
			table.insert(queue, node.left)
		end
		if #queue == 0 then
			level = level + 1
		end
	end
	return table.concat(values)
end

--- Returns the values in the binary tree in breadth first order.
--- @return table values The values in the binary tree in breadth first order.
--- @deprecated Use levelorder instead.
function binarytree:breadthfirstorder()
	return self:levelorder()
end

--- Returns the values in the binary tree in depth first order.
--- @return table values The values in the binary tree in depth first order.
--- @deprecated Use preorder instead.
function binarytree:depthfirstorder()
	return self:preorder()
end

return binarytree
