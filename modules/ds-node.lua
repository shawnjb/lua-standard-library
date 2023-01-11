local Node = {}
Node.__index = Node

function Node.new()
    local self = setmetatable({}, Node)
    self.children = {}
    self.type = 'node'
    self.parent = nil
    self.data = nil
    return self
end

function Node:isRoot()
    return self.parent.type == 'root'
end

function Node:isLeaf()
    return #self.children == 0
end

function Node:isBranch()
    return not self:isLeaf()
end

function Node:isChild()
    return not self:isRoot()
end

function Node:addNode(data)
    local node = Node.new()
    node.data = data
    node.parent = self
    table.insert(self.children, node)
    return node
end

function Node:removeNode(data)
    for i, node in ipairs(self.children) do
        if node.data == data then
            table.remove(self.children, i)
            return
        end
    end
end

function Node:search(data)
    for i, node in ipairs(self.children) do
        if node.data == data then
            return node
        end
    end
end

return Node
