--- Matrix data structure.

local matrix = {}
matrix.__index = matrix

--- Creates a new matrix.
--- @param rows number The number of rows.
--- @param columns number The number of columns.
--- @return table matrix The new matrix.
function matrix:new(rows, columns)
	local o = { data = {}, rows = rows, columns = columns }
	setmetatable(o, self)
	return o
end

--- Inserts a new element in the matrix.
--- @param row number The row of the element.
--- @param column number The column of the element.
--- @param value any The value of the element.
function matrix:insert(row, column, value)
	self.data[row * self.columns + column] = value
end

--- Retrieves the element at the specified row and column.
--- @param row number The row of the element.
--- @param column number The column of the element.
--- @return any value The value of the element.
function matrix:get(row, column)
	return self.data[row * self.columns + column]
end

--- Retrieves the number of elements in the matrix.
--- @return number count The number of elements.
function matrix:count()
	return #self.data
end

--- Checks if the matrix is empty.
--- @return boolean isEmpty True if the matrix is empty, false otherwise.
function matrix:isEmpty()
	return #self.data == 0
end

function matrix:free()
	self.data = nil
end

return matrix
