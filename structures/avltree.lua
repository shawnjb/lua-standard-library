--- An AVLNode is a node in an AVL tree.
--- @field value any The value of the node.
--- @field left AVLNode The left child of the node.
--- @field right AVLNode The right child of the node.
--- @field height number The height of the node.
--- @field balance number The balance of the node.
--- @field parent AVLNode The parent of the node.
--- @field tree AVLTree The tree the node belongs to.
local AVLNode = {}
AVLNode.__index = AVLNode

--- Creates a new AVLNode.
--- @param tree AVLTree The tree the node belongs to.
--- @param value any The value of the node.
--- @return AVLNode AVLNode The new node.
function AVLNode.new(tree, value)
	local self = setmetatable({}, AVLNode)
	self.value = value
	self.left = nil
	self.right = nil
	self.height = 1
	self.balance = 0
	self.parent = nil
	self.tree = tree
	return self
end

--- Rotates the node to the left.
function AVLNode:rotateLeft()
	local right = self.right
	local parent = self.parent
	local tree = self.tree
	if right == nil then
		return
	end
	self.right = right.left
	if self.right ~= nil then
		self.right.parent = self
	end
	right.left = self
	right.parent = parent
	self.parent = right
	if parent ~= nil then
		if parent.left == self then
			parent.left = right
		else
			parent.right = right
		end
	else
		tree.root = right
	end
	self:updateHeight()
	right:updateHeight()
end

--- Rotates the node to the right.
function AVLNode:rotateRight()
	local left = self.left
	local parent = self.parent
	local tree = self.tree
	if left == nil then
		return
	end
	self.left = left.right
	if self.left ~= nil then
		self.left.parent = self
	end
	left.right = self
	left.parent = parent
	self.parent = left
	if parent ~= nil then
		if parent.left == self then
			parent.left = left
		else
			parent.right = left
		end
	else
		tree.root = left
	end
	self:updateHeight()
	left:updateHeight()
end

--- Updates the height of the node.
function AVLNode:updateHeight()
	local leftHeight = 0
	local rightHeight = 0
	if self.left ~= nil then
		leftHeight = self.left.height
	end
	if self.right ~= nil then
		rightHeight = self.right.height
	end
	self.height = math.max(leftHeight, rightHeight) + 1
	self.balance = rightHeight - leftHeight
end

--- Balances the node.
function AVLNode:balanceNode()
	self:updateHeight()
	if self.balance == -2 then
		if self.left.balance <= 0 then
			self:rotateRight()
		else
			self.left:rotateLeft()
			self:rotateRight()
		end
	elseif self.balance == 2 then
		if self.right.balance >= 0 then
			self:rotateLeft()
		else
			self.right:rotateRight()
			self:rotateLeft()
		end
	end
	if self.parent ~= nil then
		self.parent:balanceNode()
	end
end

--- Inserts a value into the tree.
--- @param value any The value to insert.
function AVLNode:insert(value)
	if value < self.value then
		if self.left == nil then
			self.left = AVLNode.new(self.tree, value)
			self.left.parent = self
			self.left:balanceNode()
		else
			self.left:insert(value)
		end
	else
		if self.right == nil then
			self.right = AVLNode.new(self.tree, value)
			self.right.parent = self
			self.right:balanceNode()
		else
			self.right:insert(value)
		end
	end
end

--- Removes a value from the tree.
--- @param value any The value to remove.
function AVLNode:remove(value)
	if value < self.value then
		if self.left ~= nil then
			self.left:remove(value)
		end
	elseif value > self.value then
		if self.right ~= nil then
			self.right:remove(value)
		end
	else
		if self.left ~= nil and self.right ~= nil then
			local successor = self.right
			while successor.left ~= nil do
				successor = successor.left
			end
			self.value = successor.value
			successor:remove(successor.value)
		elseif self.left ~= nil then
			if self == self.tree.root then
				self.tree.root = self.left
			else
				if self.parent.left == self then
					self.parent.left = self.left
				else
					self.parent.right = self.left
				end
				self.left.parent = self.parent
				self.parent:balanceNode()
			end
		elseif self.right ~= nil then
			if self == self.tree.root then
				self.tree.root = self.right
			else
				if self.parent.left == self then
					self.parent.left = self.right
				else
					self.parent.right = self.right
				end
				self.right.parent = self.parent
				self.parent:balanceNode()
			end
		else
			if self == self.tree.root then
				self.tree.root = nil
			else
				if self.parent.left == self then
					self.parent.left = nil
				else
					self.parent.right = nil
				end
				self.parent:balanceNode()
			end
		end
	end
end

--- Returns the node with the smallest value.
--- @return AVLNode AVLNode The node with the smallest value.
function AVLNode:minimum()
	local node = self
	while node.left ~= nil do
		node = node.left
	end
	return node
end

--- Returns the node with the largest value.
--- @return AVLNode AVLNode The node with the largest value.
function AVLNode:maximum()
	local node = self
	while node.right ~= nil do
		node = node.right
	end
	return node
end

--- Returns the node with the next largest value.
--- @return AVLNode AVLNode The node with the next largest value.
function AVLNode:successor()
	if self.right ~= nil then
		return self.right:minimum()
	end
	local node = self
	local parent = self.parent
	while parent ~= nil and node == parent.right do
		node = parent
		parent = parent.parent
	end
	return parent
end

--- Returns the node with the next smallest value.
--- @return AVLNode AVLNode The node with the next smallest value.
function AVLNode:predecessor()
	if self.left ~= nil then
		return self.left:maximum()
	end
	local node = self
	local parent = self.parent
	while parent ~= nil and node == parent.left do
		node = parent
		parent = parent.parent
	end
	return parent
end

--- Returns the node with the given value.
--- @param value any The value to search for.
--- @return AVLNode? AVLNode The node with the given value.
function AVLNode:find(value)
	if value < self.value then
		if self.left ~= nil then
			return self.left:find(value)
		end
	elseif value > self.value then
		if self.right ~= nil then
			return self.right:find(value)
		end
	else
		return self
	end
end

--- Returns the node with the given value, or the next largest value if the given value is not found.
--- @param value any The value to search for.
--- @return AVLNode AVLNode The node with the given value, or the next largest value if the given value is not found.
function AVLNode:findNearest(value)
	local node = self:find(value)
	if node == nil then
		node = self:successor()
	end
	return node
end

--- Returns the node with the given value, or the next smallest value if the given value is not found.
--- @param value any The value to search for.
--- @return AVLNode AVLNode The node with the given value, or the next smallest value if the given value is not found.
function AVLNode:findNearestReverse(value)
	local node = self:find(value)
	if node == nil then
		node = self:predecessor()
	end
	return node
end

--- Returns the height of the node.
--- @return number number The height of the node.
function AVLNode:getHeight()
	local leftHeight = 0
	local rightHeight = 0
	if self.left ~= nil then
		leftHeight = self.left:height()
	end
	if self.right ~= nil then
		rightHeight = self.right:height()
	end
	return math.max(leftHeight, rightHeight) + 1
end

--- Returns the balance factor of the node.
--- @return number number The balance factor of the node.
function AVLNode:balanceFactor()
	local leftHeight = 0
	local rightHeight = 0
	if self.left ~= nil then
		leftHeight = self.left:height()
	end
	if self.right ~= nil then
		rightHeight = self.right:height()
	end
	return leftHeight - rightHeight
end

--- AVL Trees are a type of self-balancing binary search tree.
local AVLTree = {}
AVLTree.__index = AVLTree

--- Creates a new AVLTree.
--- @return AVLTree AVLTree The new AVLTree.
function AVLTree.new()
	local self = setmetatable({}, AVLTree)
	self.root = nil
	return self
end

--- Returns the node with the smallest value.
--- @return AVLNode? AVLNode The node with the smallest value.
function AVLTree:minimum()
	if self.root ~= nil then
		return self.root:minimum()
	end
end

--- Returns the node with the largest value.
--- @return AVLNode? AVLNode The node with the largest value.
function AVLTree:maximum()
	if self.root ~= nil then
		return self.root:maximum()
	end
end

--- Returns the node with the next largest value.
--- @param value any The value to search for.
--- @return AVLNode? AVLNode The node with the next largest value.
function AVLTree:successor(value)
	local node = self.root:find(value)
	if node ~= nil then
		return node:successor()
	end
end

--- Returns the node with the next smallest value.
--- @param value any The value to search for.
--- @return AVLNode? AVLNode The node with the next smallest value.
function AVLTree:predecessor(value)
	local node = self.root:find(value)
	if node ~= nil then
		return node:predecessor()
	end
end

--- Returns the node with the given value.
--- @param value any The value to search for.
--- @return AVLNode? AVLNode The node with the given value.
function AVLTree:find(value)
	if self.root ~= nil then
		return self.root:find(value)
	end
end

--- Returns the node with the given value, or the next largest value if the given value is not found.
--- @param value any The value to search for.
--- @return AVLNode? AVLNode The node with the given value, or the next largest value if the given value is not found.
function AVLTree:findNearest(value)
	if self.root ~= nil then
		return self.root:findNearest(value)
	end
end

--- Returns the node with the given value, or the next smallest value if the given value is not found.
--- @param value any The value to search for.
--- @return AVLNode? AVLNode The node with the given value, or the next smallest value if the given value is not found.
function AVLTree:findNearestReverse(value)
	if self.root ~= nil then
		return self.root:findNearestReverse(value)
	end
end

--- Inserts a new node with the given value.
--- @param value any The value to insert.
function AVLTree:insert(value)
	if self.root == nil then
		self.root = AVLNode.new(value)
	else
		self.root:insert(value)
	end
end

--- Removes the node with the given value.
--- @param value any The value to remove.
function AVLTree:remove(value)
	if self.root ~= nil then
		self.root:remove(value)
	end
end

--- Returns the height of the tree.
--- @return number number The height of the tree.
function AVLTree:height()
	if self.root ~= nil then
		return self.root:height()
	end
	return 0
end

--- Returns the balance factor of the tree.
--- @return number number The balance factor of the tree.
function AVLTree:balanceFactor()
	if self.root ~= nil then
		return self.root:balanceFactor()
	end
	return 0
end

--- Balances the tree.
function AVLTree:balanceTree()
	if self.root ~= nil then
		self.root:balanceNode()
	end
end

return AVLTree
