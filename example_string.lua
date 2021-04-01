local jsp = require("./jspower.lua")
local String = jsp.String


print(String.fromCharCode(97)) -- a

print(String.charAt("hello, world!",8)) -- w
print(String.charCodeAt("hello, world!",8)) -- 119
print(String.concat("hello,", " lua!")) -- hello, lua!
print(String.startsWith("banana", "ba")) -- true
print(String.endsWith("coconut", "nut")) -- true
print(String.includes("javascript", "vasc")) -- true

-- Alternatively, use jsp.extendLuaString()
jsp.extendLuaString()
-- After this, you can do:

print(("hello, world!"):charAt(8)) -- w
print(("hello,"):concat(" lua!")) -- hello, lua!
print(("banana"):startsWith("ba")) -- true
print(("coconut"):endsWith("nut")) -- true
print(("javascript"):includes("vasc")) -- true

local str = "     trim me daddy  "
print(str:trim()) -- "trim me daddy"
print(str:trimEnd()) -- "     trim me daddy"
print(str:trimStart()) -- "trim me daddy  "

local str = "Use the power of JS in Lua"
print(str:split(" ")) -- { "Use", "the", "power", "of", "JS", "in", "Lua" }
print(str:split("JS")) -- { "Use the power of ", " in Lua" }
print(str:toUpperCase()) -- USE THE POWER OF JS IN LUA
print(str:toLowerCase()) -- use the power of js in lua
