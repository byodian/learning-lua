-- Another file can us mod.lua's functionality:
local mod = require('mod') -- Run the file mod.lua

-- This workds because mod here = M in mod.lua
mod.sayHello()

-- This is wrong; sayName only exists in mod.lua
-- mod.sayName() -- error

-- require's return values are cached so a file is
-- run at most once, even when require'd many times.

-- Suppose mod1.lua contains "print('Hi!')"
local a = require('mod2') -- Hi!
local b = require('mod2') -- Doesn't print; a = b

-- dofile is like require without caching
dofile('mod2.lua') --> Hi!
dofile('mod2.lua') --> Hi! （run it again)

-- loadfile loads a lua file but doesn't run it yet
f = loadfile('mod2.lua') -- call f() to run it
f()

-- load is loadfile for strings
-- (loadstring is deprecated, use load instead)
g = load('print(344)') -- Returns a function
g() -- Prints out 344; noting printed before now.


