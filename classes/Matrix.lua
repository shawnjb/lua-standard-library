--- Copyright (c) 2022, Shawn Bragdon
--- All rights reserved.
--- @meta

--- @class Matrix
--- @field private _rows number The number of rows in the matrix.
--- @field private _columns number The number of columns in the matrix.
--- @field private _data table The data in the matrix.
Matrix = {}
Matrix.__index = Matrix

--- Creates a new Matrix.
--- @param rows number The number of rows in the Matrix.
--- @param columns number The number of columns in the Matrix.1
--- @return table Matrix The new Matrix.
function Matrix.new(rows, columns)
	local self = setmetatable({}, Matrix)
	self._rows = rows
	self._columns = columns
	self._data = {}
	for i = 1, rows do
		self._data[i] = {}
		for j = 1, columns do
			self._data[i][j] = 0
		end
	end
	return self
end

--- Creates a new Matrix from a table.
--- @param data table The table to create the Matrix from.
--- @return table Matrix The new Matrix.
function Matrix.fromTable(data)
	local self = setmetatable({}, Matrix)
	self._rows = #data
	self._columns = #data[1]
	self._data = data
	return self
end

--- Creates a new Matrix from a string.
--- @param data string The string to create the Matrix from.
--- @return table Matrix The new Matrix.
function Matrix.fromString(data)
	local self = setmetatable({}, Matrix)
	local rows = {}
	for row in data:gmatch("[^\r\n\n]+") do
		local columns = {}
		for column in row:gmatch("[^%s]+") do
			table.insert(columns, tonumber(column))
		end
		table.insert(rows, columns)
	end
	self._rows = #rows
	self._columns = #rows[1]
	self._data = rows
	return self
end

--- Returns the number of rows in the Matrix.
--- @return number rows The number of rows in the Matrix.
function Matrix:getRows()
	return self._rows
end

--- Returns the number of columns in the Matrix.
--- @return number columns The number of columns in the Matrix.
function Matrix:getColumns()
	return self._columns
end

--- Returns the value at the given row and column.
--- @param row number The row of the value.
--- @param column number The column of the value.
--- @return number value The value at the given row and column.
function Matrix:get(row, column)
	return self._data[row][column]
end

--- Sets the value at the given row and column.
--- @param row number The row of the value.
--- @param column number The column of the value.
--- @param value number The value to set.
function Matrix:set(row, column, value)
	self._data[row][column] = value
end

--- Returns the row at the given index.
--- @param index number The index of the row.
--- @return table row The row at the given index.
function Matrix:getRow(index)
	return self._data[index]
end

--- Sets the row at the given index.
--- @param index number The index of the row.
--- @param row table The row to set.
function Matrix:setRow(index, row)
	self._data[index] = row
end

--- Returns the column at the given index.
--- @param index number The index of the column.
--- @return table column The column at the given index.
function Matrix:getColumn(index)
	local column = {}
	for i = 1, self._rows do
		column[i] = self._data[i][index]
	end
	return column
end

--- Sets the column at the given index.
--- @param index number The index of the column.
--- @param column table The column to set.
function Matrix:setColumn(index, column)
	for i = 1, self._rows do
		self._data[i][index] = column[i]
	end
end

--- Returns the diagonal of the Matrix.
--- @return table diagonal The diagonal of the Matrix.
function Matrix:getDiagonal()
	local diagonal = {}
	for i = 1, math.min(self._rows, self._columns) do
		diagonal[i] = self._data[i][i]
	end
	return diagonal
end

--- Sets the diagonal of the Matrix.
--- @param diagonal table The diagonal to set.
function Matrix:setDiagonal(diagonal)
	for i = 1, math.min(self._rows, self._columns) do
		self._data[i][i] = diagonal[i]
	end
end

--- Returns the submatrix of the Matrix.
--- @param row number The row of the submatrix.
--- @param column number The column of the submatrix.
--- @param rows number The number of rows in the submatrix.
--- @param columns number The number of columns in the submatrix.
--- @return table submatrix The submatrix of the Matrix.
function Matrix:getSubmatrix(row, column, rows, columns)
	local submatrix = Matrix.new(rows, columns)
	for i = 1, rows do
		for j = 1, columns do
			submatrix:set(i, j, self:get(row + i - 1, column + j - 1))
		end
	end
	return submatrix
end

--- Sets the submatrix of the Matrix.
--- @param row number The row of the submatrix.
--- @param column number The column of the submatrix.
--- @param submatrix table The submatrix to set.
function Matrix:setSubmatrix(row, column, submatrix)
	for i = 1, submatrix:getRows() do
		for j = 1, submatrix:getColumns() do
			self:set(row + i - 1, column + j - 1, submatrix:get(i, j))
		end
	end
end

--- Returns the transpose of the Matrix.
--- @return table transpose The transpose of the Matrix.
function Matrix:getTranspose()
	local transpose = Matrix.new(self._columns, self._rows)
	for i = 1, self._rows do
		for j = 1, self._columns do
			transpose:set(j, i, self:get(i, j))
		end
	end
	return transpose
end

--- Returns the determinant of the Matrix.
--- @return number? determinant The determinant of the Matrix.
function Matrix:getDeterminant()
	if self._rows ~= self._columns then
		return nil
	end
	if self._rows == 1 then
		return self:get(1, 1)
	end
	if self._rows == 2 then
		return self:get(1, 1) * self:get(2, 2) - self:get(1, 2) * self:get(2, 1)
	end
	local determinant = 0
	for i = 1, self._columns do
		determinant = determinant + self:get(1, i) * self:getCofactor(1, i)
	end
	return determinant
end

--- Returns the minor of the Matrix.
--- @param row number The row of the minor.
--- @param column number The column of the minor.
--- @return number minor The minor of the Matrix.
function Matrix:getMinor(row, column)
	return self:getSubmatrix(row, column, self._rows - 1, self._columns - 1):getDeterminant()
end

--- Returns the cofactor of the Matrix.
--- @param row number The row of the cofactor.
--- @param column number The column of the cofactor.
--- @return number cofactor The cofactor of the Matrix.
function Matrix:getCofactor(row, column)
	return (-1) ^ (row + column) * self:getMinor(row, column)
end

--- Returns the adjugate of the Matrix.
--- @return table adjugate The adjugate of the Matrix.
function Matrix:getAdjugate()
	local adjugate = Matrix.new(self._rows, self._columns)
	for i = 1, self._rows do
		for j = 1, self._columns do
			adjugate:set(i, j, self:getCofactor(j, i))
		end
	end
	return adjugate
end

--- Returns the trace of the Matrix.
--- @return number trace The trace of the Matrix.
function Matrix:getTrace()
	local trace = 0
	for i = 1, math.min(self._rows, self._columns) do
		trace = trace + self:get(i, i)
	end
	return trace
end

--- Returns the norm of the Matrix.
--- @return number norm The norm of the Matrix.
function Matrix:getNorm()
	local norm = 0
	for i = 1, self._rows do
		for j = 1, self._columns do
			norm = norm + self:get(i, j) ^ 2
		end
	end
	return math.sqrt(norm)
end

--- Returns the rank of the Matrix.
--- @return number rank The rank of the Matrix.
function Matrix:getRank()
	local rank = 0
	local pivot = 1
	local Matrix = self:getCopy()
	for i = 1, self._rows do
		if pivot > self._columns then
			break
		end
		local j = i
		while Matrix:get(j, pivot) == 0 do
			j = j + 1
			if j > self._rows then
				j = i
				pivot = pivot + 1
				if pivot > self._columns then
					break
				end
			end
		end
		if pivot > self._columns then
			break
		end
		if j ~= i then
			Matrix:swapRows(i, j)
		end
		local value = Matrix:get(i, pivot)
		for j = 1, self._columns do
			Matrix:set(i, j, Matrix:get(i, j) / value)
		end
		for j = 1, self._rows do
			if j ~= i then
				value = Matrix:get(j, pivot)
				for k = 1, self._columns do
					Matrix:set(j, k, Matrix:get(j, k) - value * Matrix:get(i, k))
				end
			end
		end
		pivot = pivot + 1
		rank = rank + 1
	end
	return rank
end

--- Returns the condition number of the Matrix.
--- @return number conditionNumber The condition number of the Matrix.
function Matrix:getConditionNumber()
	return self:getNorm() * self:getInverse():getNorm()
end

--- Returns the eigenvalues of the Matrix.
--- @return table? eigenvalues The eigenvalues of the Matrix.
function Matrix:getEigenvalues()
	if self._rows ~= self._columns then
		return nil
	end
	local eigenvalues = {}
	local Matrix = self:getCopy()
	local n = self._rows
	for i = 1, n - 1 do
		local k = i
		for j = i + 1, n do
			if math.abs(Matrix:get(j, i)) > math.abs(Matrix:get(k, i)) then
				k = j
			end
		end
		if k ~= i then
			Matrix:swapRows(i, k)
			Matrix:swapColumns(i, k)
		end
		for j = i + 1, n do
			local value = Matrix:get(j, i) / Matrix:get(i, i)
			for k = i + 1, n do
				Matrix:set(j, k, Matrix:get(j, k) - value * Matrix:get(i, k))
			end
		end
	end
	local determinant = 1
	for i = 1, n do
		determinant = determinant * Matrix:get(i, i)
	end
	if determinant == 0 then
		return eigenvalues
	end
	local a = Matrix.new(n, n)
	local b = Matrix.new(n, n)
	for i = 1, n do
		for j = 1, n do
			a:set(i, j, Matrix:get(i, j))
			b:set(i, j, 0)
		end
		b:set(i, i, 1)
	end
	local epsilon = 1e-10
	while true do
		local k = 1
		for i = 2, n do
			if math.abs(a:get(i, i - 1)) > math.abs(a:get(k, k - 1)) then
				k = i
			end
		end
		local l = k - 1
		if math.abs(a:get(k, l)) <= epsilon * (math.abs(a:get(k, k)) + math.abs(a:get(l, l))) then
			break
		end
		local m = k + 1
		for i = k + 2, n do
			if math.abs(a:get(i, i - 1)) > math.abs(a:get(m, m - 1)) then
				m = i
			end
		end
		local theta = (a:get(l, l) - a:get(m, m)) / (2 * a:get(k, l))
		local t
		if theta >= 0 then
			t = 1 / (theta + math.sqrt(1 + theta ^ 2))
		else
			t = -1 / (-theta + math.sqrt(1 + theta ^ 2))
		end
		local c = 1 / math.sqrt(1 + t ^ 2)
		local s = t * c
		local tau = s / (1 + c)
		local temp = a:get(k, l)
		a:set(k, l, temp - t * temp)
		a:set(l, k, a:get(k, l))
		a:set(m, l, 0)
		a:set(l, m, 0)
		for i = 1, k - 1 do
			temp = a:get(i, k)
			a:set(i, k, temp - s * (a:get(i, l) + tau * temp))
			a:set(i, l, a:get(i, l) + s * (temp - tau * a:get(i, l)))
		end
		for i = k + 1, l - 1 do
			temp = a:get(k, i)
			a:set(k, i, temp - s * (a:get(i, l) + tau * a:get(k, i)))
			a:set(i, l, a:get(i, l) + s * (temp - tau * a:get(i, l)))
		end
		for i = l + 1, m - 1 do
			temp = a:get(k, i)
			a:set(k, i, temp - s * (a:get(m, i) + tau * a:get(k, i)))
			a:set(m, i, a:get(m, i) + s * (temp - tau * a:get(m, i)))
		end
		for i = m + 1, n do
			temp = a:get(k, i)
			a:set(k, i, temp - s * (a:get(i, m) + tau * temp))
			a:set(i, m, a:get(i, m) + s * (temp - tau * a:get(i, m)))
		end
		for i = 1, n do
			temp = b:get(i, k)
			b:set(i, k, temp - s * (b:get(i, l) + tau * temp))
			b:set(i, l, b:get(i, l) + s * (temp - tau * b:get(i, l)))
		end
	end
	for i = 1, n do
		eigenvalues[i] = a:get(i, i)
	end
	return eigenvalues
end

--- Returns the inverse of the Matrix.
--- @return Matrix? inverse The inverse of the Matrix.
function Matrix:getInverse()
	if self._rows ~= self._columns then
		return nil
	end
	local n = self._rows
	local inverse = Matrix.new(n, n)
	for i = 1, n do
		inverse:set(i, i, 1)
	end
	local Matrix = self:getCopy()
	for i = 1, n do
		local k = i
		for j = i + 1, n do
			if math.abs(Matrix:get(j, i)) > math.abs(Matrix:get(k, i)) then
				k = j
			end
		end
		if k ~= i then
			Matrix:swapRows(i, k)
			inverse:swapRows(i, k)
		end
		local value = Matrix:get(i, i)
		for j = 1, n do
			Matrix:set(i, j, Matrix:get(i, j) / value)
			inverse:set(i, j, inverse:get(i, j) / value)
		end
		for j = 1, n do
			if j ~= i then
				value = Matrix:get(j, i)
				for k = 1, n do
					Matrix:set(j, k, Matrix:get(j, k) - value * Matrix:get(i, k))
					inverse:set(j, k, inverse:get(j, k) - value * inverse:get(i, k))
				end
			end
		end
	end
	return inverse
end

--- Returns the LUP decomposition of the Matrix.
--- @return Matrix L The lower triangular Matrix.
--- @return Matrix U The upper triangular Matrix.
--- @return table P The permutation Matrix.
function Matrix:getLUPDecomposition()
	local n = self._rows
	local L = Matrix.new(n, n)
	local U = Matrix.new(n, n)
	local P = {}
	for i = 1, n do
		P[i] = i
	end
	local Matrix = self:getCopy()
	for i = 1, n do
		local k = i
		for j = i + 1, n do
			if math.abs(Matrix:get(j, i)) > math.abs(Matrix:get(k, i)) then
				k = j
			end
		end
		if k ~= i then
			Matrix:swapRows(i, k)
			P[i], P[k] = P[k], P[i]
		end
		L:set(i, i, 1)
		for j = i, n do
			local sum = 0
			for k = 1, i - 1 do
				sum = sum + L:get(i, k) * U:get(k, j)
			end
			U:set(i, j, Matrix:get(i, j) - sum)
		end
		for j = i + 1, n do
			local sum = 0
			for k = 1, i - 1 do
				sum = sum + L:get(j, k) * U:get(k, i)
			end
			L:set(j, i, (Matrix:get(j, i) - sum) / U:get(i, i))
		end
	end
	return L, U, P
end

--- Returns the LU decomposition of the Matrix.
--- @return Matrix L The lower triangular Matrix.
--- @return Matrix U The upper triangular Matrix.
function Matrix:getLU()
	local n = self._rows
	local L = Matrix.new(n, n)
	local U = Matrix.new(n, n)
	local Matrix = self:getCopy()
	for i = 1, n do
		L:set(i, i, 1)
		for j = i, n do
			local sum = 0
			for k = 1, i - 1 do
				sum = sum + L:get(i, k) * U:get(k, j)
			end
			U:set(i, j, Matrix:get(i, j) - sum)
		end
		for j = i + 1, n do
			local sum = 0
			for k = 1, i - 1 do
				sum = sum + L:get(j, k) * U:get(k, i)
			end
			L:set(j, i, (Matrix:get(j, i) - sum) / U:get(i, i))
		end
	end
	return L, U
end

--- Returns the QR decomposition of the Matrix.
--- @return Matrix Q The orthogonal Matrix.
--- @return Matrix R The upper triangular Matrix.
function Matrix:getQR()
	local n = self._rows
	local m = self._columns
	local Q = Matrix.new(n, n)
	local R = Matrix.new(n, m)
	local Matrix = self:getCopy()
	for i = 1, n do
		local norm = 0
		for j = 1, m do
			norm = norm + Matrix:get(i, j) ^ 2
		end
		norm = math.sqrt(norm)
		for j = 1, m do
			Matrix:set(i, j, Matrix:get(i, j) / norm)
		end
		Q:set(i, i, 1)
		for j = i + 1, n do
			local sum = 0
			for k = 1, m do
				sum = sum + Matrix:get(i, k) * Matrix:get(j, k)
			end
			for k = 1, m do
				Matrix:set(j, k, Matrix:get(j, k) - sum * Matrix:get(i, k))
			end
			Q:set(j, i, sum)
		end
	end
	for i = 1, n do
		for j = 1, m do
			R:set(i, j, Matrix:get(i, j))
		end
	end
	return Q, R
end

--- Returns the Cholesky decomposition of the Matrix.
--- @return Matrix L The lower triangular Matrix.
function Matrix:getCholesky()
	local n = self._rows
	local L = Matrix.new(n, n)
	local Matrix = self:getCopy()
	for i = 1, n do
		local sum = 0
		for k = 1, i - 1 do
			sum = sum + L:get(i, k) ^ 2
		end
		L:set(i, i, math.sqrt(Matrix:get(i, i) - sum))
		for j = i + 1, n do
			local sum = 0
			for k = 1, i - 1 do
				sum = sum + L:get(i, k) * L:get(j, k)
			end
			L:set(j, i, (Matrix:get(j, i) - sum) / L:get(i, i))
		end
	end
	return L
end

--- Returns a copy of the Matrix.
--- @return Matrix copy The copy of the Matrix.
function Matrix:getCopy()
	local copy = Matrix.new(self._rows, self._columns)
	for i = 1, self._rows do
		for j = 1, self._columns do
			copy:set(i, j, self:get(i, j))
		end
	end
	return copy
end

--- Swaps two rows of the Matrix.
--- @param i number The index of the first row.
--- @param j number The index of the second row.
function Matrix:swapRows(i, j)
	for k = 1, self._columns do
		self:set(i, k, self:get(i, k) + self:get(j, k))
		self:set(j, k, self:get(i, k) - self:get(j, k))
		self:set(i, k, self:get(i, k) - self:get(j, k))
	end
end

--- Swaps two columns of the Matrix.
--- @param i number The index of the first column.
--- @param j number The index of the second column.
function Matrix:swapColumns(i, j)
	for k = 1, self._rows do
		self:set(k, i, self:get(k, i) + self:get(k, j))
		self:set(k, j, self:get(k, i) - self:get(k, j))
		self:set(k, i, self:get(k, i) - self:get(k, j))
	end
end
