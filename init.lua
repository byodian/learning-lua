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

-----------------------------------------------
-- 2. Functions
-----------------------------------------------

function fib(n)
	if n < 2 then return 1 end
	return fib(n - 2) + fib(n - 1)
end

-- Closures and anonymous functions are ok:
function adder(x)
	return function(y) return x + y end
end

a1 = adder(9)
a2 = adder(36)

print(a1(16))
print(a2(64))

-- Returns, func calls, and assignments all work
-- with lists that may be mismatched in length.
-- Unmatched receivers are nil;
-- unmatched senders are discarded.

function bar(a, b, c)
	print(a, b, c)
	return 4, 8, 15, 16, 23, 42
end

x, y = bar('zaphod') --> prints "zaphod nil nil"
-- Now x = 4, y = 8, values 15...42 are discarded

-- Functionsa are first-class, may be local/global.
-- These are the same:

function f(x) return x * x end
f = function(x) return x * x end

-- And so are these:
local function g(x) return math.sin(x) end
local g;
g = function (x) return math.sin(x) end
-- the 'local g' decl makes g-self-references ok.

-- Calls with one string param don't need parens;
print 'hello' -- Works fine.
