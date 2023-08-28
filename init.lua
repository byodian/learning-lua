-- All numbers are doubles
num = 38
num2 = 39
s = 'walternates'
t = "double quote"
u = [[ Double brackets
	start and end
	multi-line strings.]]
t = nil -- Undefines t; Lua has gargabe collection.

-- Blocks are denoted with keywords like do/end;
while num < 50 do
	num = num + 1 -- No ++ or += type operators
end

-- If clauses
if num2 > 40 then
	print('over 40')
elseif s ~= 'walternate' then -- ~= is not equals.
	-- Equality check is == like Python; ok for strs.
	io.write('not over 40\n') -- Defaults to stdout.
else
	-- Variables are global by default.
	thisIsGlobal = 5 -- Camel case is common.

	-- How to make a variabl local:
	local line = io.read() -- Reads next stdin line.

	-- String concatenation uses the .. operator:
	print('Winter is coming, ' .. line)
end

-- This is not an error
foo = anUnknownVariable -- Now foo = nil
aBoolValue = false

-- Only nil and false are falsy; 0 and '' are true!
if not aBoolValue then print('it was false') end

-- 'or' and 'and' are short-circuited.
-- This is similar to the a?b:c operator in C/js
ans = aBoolValue and 'yes' or 'no' --> 'no'

karlSum = 0
for i = 1, 100 do -- The range includes both ends
	karlSum = karlSum + 1
end

print('karlSum, ' .. karlSum)

-- Use "100, 1, -1" as the range to count down:
-- In gereal, the range is begin, end[, step].
fredSum = 0
for j = 100, 1, -1 do fredSum = fredSum + j end
print('fredSum, ' .. fredSum)

-- Another loop construct:
repeat
	print("the way of the future")
	num = num - 1
until num == 0
