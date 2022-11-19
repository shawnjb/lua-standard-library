-- In computer science, a binary tree is a k-ary {\displaystyle k=2}k=2 tree data structure in which each node has at most two children, which are referred to as the left child and the right child. A recursive definition using just set theory notions is that a (non-empty) binary tree is a tuple (L, S, R), where L and R are binary trees or the empty set and S is a singleton set containing the root.[1] Some authors allow the binary tree to be the empty set as well.[2]
--
-- From a graph theory perspective, binary (and K-ary) trees as defined here are arborescences.[3] A binary tree may thus be also called a bifurcating arborescence[3]—a term which appears in some very old programming books,[4] before the modern computer science terminology prevailed. It is also possible to interpret a binary tree as an undirected, rather than a directed graph, in which case a binary tree is an ordered, rooted tree.[5] Some authors use rooted binary tree instead of binary tree to emphasize the fact that the tree is rooted, but as defined above, a binary tree is always rooted.[6] A binary tree is a special case of an ordered K-ary tree, where K is 2.
--
-- In mathematics, what is termed binary tree can vary significantly from author to author. Some use the definition commonly used in computer science,[7] but others define it as every non-leaf having exactly two children and don't necessarily order (as left/right) the children either.[8]
--
-- In computing, binary trees are used in two very different ways:
--
-- * First, as a means of accessing nodes based on some value or label associated with each node.[9] Binary trees labelled this way are used to implement binary search trees and binary heaps, and are used for efficient searching and sorting. The designation of non-root nodes as left or right child even when there is only one child present matters in some of these applications, in particular, it is significant in binary search trees.[10] However, the arrangement of particular nodes into the tree is not part of the conceptual information. For example, in a normal binary search tree the placement of nodes depends almost entirely on the order in which they were added, and can be re-arranged (for example by balancing) without changing the meaning.
-- * Second, as a representation of data with a relevant bifurcating structure. In such cases, the particular arrangement of nodes under and/or to the left or right of other nodes is part of the information (that is, changing it would change the meaning). Common examples occur with Huffman coding and cladograms. The everyday division of documents into chapters, sections, paragraphs, and so on is an analogous example with n-ary rather than binary trees.

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
