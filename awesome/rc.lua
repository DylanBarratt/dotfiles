-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- error handling
require("errors")

-- themes including all styling
require("theme")

require("rules")

require("signals")
