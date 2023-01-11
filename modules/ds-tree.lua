local Node = require("modules.ds-node")

local Tree = {}
Tree.__index = Tree

function Tree.new()
    local self = setmetatable({}, Tree)
    self.root = Node.new()
    self.root.type = 'root'
    self.root.parent = self.root
    self.root.children = {}
    self.root.data = nil
    return self
end

function Tree:isRoot(node)
    return node.parent.type == 'root'
end

function Tree:isLeaf(node)
    return #node.children == 0
end

function Tree:isBranch(node)
    return not self:isLeaf(node)
end

function Tree:isChild(node)
    return not self:isRoot(node)
end

function Tree:addNode(data)
    local node = Node.new()
    node.data = data
    node.parent = self.root
    table.insert(self.root.children, node)
    return node
end

function Tree:removeNode(data)
    for i, node in ipairs(self.root.children) do
        if node.data == data then
            table.remove(self.root.children, i)
            return
        end
    end
end

function Tree:search(data)
    for i, node in ipairs(self.root.children) do
        if node.data == data then
            return node
        end
    end
end

return Tree
