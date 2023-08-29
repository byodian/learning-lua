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
	-- print("the way of the future")
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

-----------------------------------------------------
-- 3. Tables
-----------------------------------------------------

-- Tables = lua's only compound data structures;
-- they are associative arrays.
-- Similarly to php arrays or js objects, they are
-- hash-lookup dicts that can also be used as lists.

-- Using tables as dictionaries / maps:

-- Dict literals have string keys by default:
t = { key1 = 'value1', key2 = false }

-- String keys can use js-like dot notation:
print(t.key1)
t.newKey = {} -- Adds a new key/value pair.
t.key2 = nil  -- Remove key2 from the table.

-- Literal notation for any (non-nil) value as key:
u = { ['@!#'] = 'qbert', [{}] = 1729, [6.28] = 'tau' }
print(u[6.28]) -- prints "tau"
print(u[{}])   -- prints nil

-- Key matching is basically by value for numbers and strings
-- but by identity for tables.
a = u['@!#'] -- Now a = 'qbert'
b = u[{}]    -- We might expect 1729, but its nil:
-- b = nil since the lookup fails. It fails 
-- because the key we used is not the same object
-- as the one used to store the original value. So
-- string & numbers are more portable keys.

-- A one-table-param function call needs no parens:
function h(x) print(x.key1) end

-- Prints 'Sonmi-451'.
h{key1 = 'Sonmi-451'} 

-- Table iteration
for key, val in pairs(u) do
	print(key, val)
end

-- _G is a special table of all globals
print(_G['_G'] == _G)  -- prints 'true'

-- Using tables as lists / arrays:
-- List literals implicitly set up int keys:
v = { 'value1', 'value2', 1.21, 'gigawatts' }
for i = 1, #v do -- #v is the size of v for lists.
	print(v[i])
end
-- A 'list' is not a real type. v is just a table
-- with consecutive integer keys, treated as a list.

----------------------------------------------------
-- 3.1 Metatables and metamethods.
----------------------------------------------------
-- A table can have a metatable that gives the table 
-- operator-overloadish behavior. Later we'll see
-- how metatables support js-prototype behavior.

f1 = { a = 1, b = 2 }
f2 = { a = 2, b = 3 }

-- This would fail:
-- s = f1 + f2

metafraction = {}

function metafraction.__add(f1, f2)
	sum = {}
	sum.b = f1.b * f2.b
	sum.a = f1.a * f2.b + f2.a * f1.b
	return sum
end

setmetatable(f1, metafraction)
setmetatable(f2, metafraction)

s = f1 + f2 -- call __add(f1, f2) on f1's metatable

for key, val in pairs(s) do
	print(key, val)
end

-- f1, f2 have no keys for their metatable, unlike 
-- prototype in js, so you must retrieve it as in
-- getmetatable(f1). The metatable is a normal table
-- with keys that Lua knows about, like __add.

-- But the next line fails since s has no metatable.
-- t = s + s
-- Class-like patterns given below would fix this.

-- An __index on a metatable overloads dot lookups:
defaultFavs = { animal = 'gru', food = 'donuts' }
myFavs = { food = 'pizza' }

setmetatable(myFavs, { __index = defaultFavs })
eatenBy = myFavs.animal -- works! thanks, metatable
print('eatenBy: ' .. eatenBy)

-- Direct table lookups that fails will retry using
-- the metatable's __index value, and this recurses.

-- Values of __index, add, ... are called metamethods.
-- Full list. Here a is a table with the metamethod.
-- __add(a, b)                     for a + b
-- __sub(a, b)                     for a - b
-- __mul(a, b)                     for a * b
-- __div(a, b)                     for a / b
-- __mod(a, b)                     for a % b
-- __pow(a, b)                     for a ^ b
-- __unm(a)                        for -a
-- __concat(a, b)                  for a .. b
-- __len(a)                        for #a
-- __eq(a, b)                      for a == b
-- __lt(a, b)                      for a < b
-- __le(a, b)                      for a <= b
-- __index(a, b)  <fn or a table>  for a.b
-- __newindex(a, b, c)             for a.b = c
-- __call(a, ...)                  for a(...)
