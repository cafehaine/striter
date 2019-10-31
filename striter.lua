---
-- The striter module.
-- It allows creating striter objects, which can be used to iterate through a
-- string or file.
-- @classmod striter
---

local m = {}
m.__index = m

--- Create a new striter object.
-- @function striter.new
-- @tparam string|file arg the source of data for the striter
-- @treturn striter the striter object
function m.new(arg)
	if io.type(arg) == "file" then
		local file = arg
		arg = file:read("a*")
		file:close()
	end

	if type(arg) ~= "string" then
		return nil, "Input must be an open file or a string."
	end

	local self = setmetatable({}, m)
	self.__index = 0
	self.__string = arg
	return self
end

--- Advance characters in the iterator
-- @function striter:next
-- @tparam[opt] int n the characters to advance (default is 1)
-- @treturn string|nil the next characters
function m:next(n)
	if n == nil then
		n = 1
	end

	local value = self.__string:sub(self.__index + 1, self.__index + n)
	self.__index = self.__index + n
	return #value ~= 0 and value or nil
end

--- Peek the next characters
-- @function striter:peek
-- @tparam[opt] int n the characters to peek (default is 1)
-- @treturn string|nil the peeked characters
function m:peek(n)
	if n == nil then
		n = 1
	end

	local value = self.__string:sub(self.__index+1, self.__index+n)
	return #value ~= 0 and value or nil
end

--- Peek the next characters up to and including the specified pattern
-- @function striter:peek_pattern
-- @tparam string pattern the pattern to find
-- @treturn string|nil the peeked characters
function m:next_pattern(pattern)
	local start, ending = self.__string:find(pattern, self.__index+1)
	if not start then
		return nil
	end
	local value = self.__string:sub(self.__index+1, ending)
	self.__index = ending
	return value
end

function m:next_line(keepnewline)
	--TODO handle keepnewline
	local result = self:next_pattern("\r?\n")
	if not result then
		local to_end = self.__string:sub(self.__index+1)
		self.__index = #self.__string
		if #to_end == 0 then
			return nil
		else
			return to_end
		end
	end
	return result

end

--- Peek the next characters up to and including the specified pattern
-- @function striter:peek_pattern
-- @tparam string pattern the pattern to find
-- @treturn string|nil the peeked characters
function m:peek_pattern(pattern)
	local start, ending = self.__string:find(pattern, self.__index+1)
	if not start then
		return nil
	end
	local value = self.__string:sub(self.__index+1, ending)
	return value
end

--- Peek the next characters up to the next new line (or EOF)
-- @function striter:peek_line
-- @tparam[opt] bool keepnewline keep the newline characters (default is false)
-- @treturn string|nil the peeked characters
function m:peek_line(keepnewline)
	--TODO handle keepnewline
	local result = self:peek_pattern("\r?\n")
	if not result then
		local to_end = self.__string:sub(self.__index+1)
		if #to_end == 0 then
			return nil
		else
			return to_end
		end
	end
	return result
end

return m
