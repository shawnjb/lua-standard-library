local avlnode = {}
avlnode.__index = avlnode

--- Creates a new AVL node.
--- @param value any The value of the node.
--- @return table avlnode The new AVL node.
function avlnode.new(value)
	local self = setmetatable({}, avlnode)
	--- The value of the node.
	self.value = value
	--- The left child of the node.
	self.left = nil
	--- The right child of the node.
	self.right = nil
	return self
end

--- Returns the height of the node.
--- @return number height The height of the node.
function avlnode:height()
	if not self.left and not self.right then
		return 0
	end
	return 1 + math.max(self.left and self.left:height() or 0, self.right and self.right:height() or 0)
end

--- Returns the balance factor of the node.
--- @return number balance The balance factor of the node.
function avlnode:balance()
	local left = self.left and self.left:height() or -1
	local right = self.right and self.right:height() or -1
	return right - left
end

local avltree = {}
avltree.__index = avltree

--- Creates a new AVL tree.
--- @param value any The value of the root node.
--- @return table avltree The new AVL tree.
function avltree.new(value)
	local self = setmetatable({}, avltree)
	--- The root node of the tree.
	self.root = avlnode.new(value)
	return self
end

--- Adds a value to the AVL tree.
--- @param value any The value to add.
--- @return table avltree The AVL tree.
function avltree:add(value)
	local function add(node, value)
		if not node then
			return avlnode.new(value)
		elseif value < node.value then
			node.left = add(node.left, value)
		else
			node.right = add(node.right, value)
		end
		return self:balance(node)
	end
	self.root = add(self.root, value)
	return self
end

--- Balances the AVL tree.
--- @param node table The node to balance.
--- @return table node The balanced node.
function avltree:balance(node)
	local balance = node:balance()
	if balance > 1 then
		if node.right:balance() < 0 then
			node.right = self:rotateRight(node.right)
		end
		return self:rotateLeft(node)
	elseif balance < -1 then
		if node.left:balance() > 0 then
			node.left = self:rotateLeft(node.left)
		end
		return self:rotateRight(node)
	end
	return node
end

--- Returns the height of the AVL tree.
--- @return number height The height of the AVL tree.
function avltree:height()
	return self.root:height()
end

--- Rotates the AVL tree to the left.
--- @param node table The node to rotate.
--- @return table node The rotated node.
function avltree:rotateLeft(node)
	local right = node.right
	node.right = right.left
	right.left = node
	return right
end

--- Rotates the AVL tree to the right.
--- @param node table The node to rotate.
--- @return table node The rotated node.
function avltree:rotateRight(node)
	local left = node.left
	node.left = left.right
	left.right = node
	return left
end

--- Returns the values of the AVL tree in order.
--- @return table values The values of the AVL tree in order.
function avltree:values()
	local values = {}
	local function traverse(node)
		if node.left then
			traverse(node.left)
		end
		table.insert(values, node.value)
		if node.right then
			traverse(node.right)
		end
	end
	traverse(self.root)
	return values
end

return avltree