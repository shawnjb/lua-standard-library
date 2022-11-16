--- The node class for the binary tree.
local node = {}

--- Creates a new node.
--- @param value any The value of the node.
--- @return table node The new node.
function node:new(value)
	local o = { value = value, left = nil, right = nil }
	setmetatable(o, self)
	self.__index = self
	return o
end

--- The binary tree class.
local tree = {}

--- Creates a new tree.
--- @return table tree The new tree.
function tree:new()
	local o = { root = nil }
	setmetatable(o, self)
	self.__index = self
	return o
end

--- Inserts a new node in the tree.
--- @param value any The value of the node.
function tree:insert(value)
	local newNode = node:new(value)
	if self.root == nil then
		self.root = newNode
	else
		local current = self.root
		while true do
			if value < current.value then
				if current.left == nil then
					current.left = newNode
					break
				else
					current = current.left
				end
			else
				if current.right == nil then
					current.right = newNode
					break
				else
					current = current.right
				end
			end
		end
	end
end

--- Searches for a node in the tree.
--- @param value any The value of the node.
--- @return table node The node found.
function tree:search(value)
	local current = self.root
	while current ~= nil do
		if value == current.value then
			return current
		elseif value < current.value then
			current = current.left
		else
			current = current.right
		end
	end
	return nil
end

--- Removes a node from the tree.
--- @param value any The value of the node.
function tree:remove(value)
	local current = self.root
	local parent = nil
	while current ~= nil do
		if value == current.value then
			if current.left == nil and current.right == nil then
				if parent == nil then
					self.root = nil
				else
					if parent.left == current then
						parent.left = nil
					else
						parent.right = nil
					end
				end
			elseif current.left == nil then
				if parent == nil then
					self.root = current.right
				else
					if parent.left == current then
						parent.left = current.right
					else
						parent.right = current.right
					end
				end
			elseif current.right == nil then
				if parent == nil then
					self.root = current.left
				else
					if parent.left == current then
						parent.left = current.left
					else
						parent.right = current.left
					end
				end
			else
				local successor = current.right
				local successorParent = current
				while successor.left ~= nil do
					successorParent = successor
					successor = successor.left
				end
				if successorParent.left == successor then
					successorParent.left = successor.right
				else
					successorParent.right = successor.right
				end
				current.value = successor.value
			end
			break
		elseif value < current.value then
			parent = current
			current = current.left
		else
			parent = current
			current = current.right
		end
	end
end

--- Prints the tree in order.
--- @param node table The node to start printing.
function tree:printInOrder(node)
	if node == nil then
		node = self.root
	end
	if node.left ~= nil then
		self:printInOrder(node.left)
	end
	print(node.value)
	if node.right ~= nil then
		self:printInOrder(node.right)
	end
end

return tree
