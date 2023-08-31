--
-- 4. Modules
--

-- [[ I'm commenting out this section so the rest of 
-- shis script remains runable
-- ]]

local message = 'Chese for everyone!'
-- Suppose the file mod.lua looks like this:
local M = {}

local function sayMyName()
  print("Hello")
end

function M.sayHello()
  print('Why hello there')
  sayMyName()
end

print(message)

return M
