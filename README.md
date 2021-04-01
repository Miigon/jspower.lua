# jspower.lua
## JavaScript-style Array, String and Math, in Lua!
jspower.lua implements `Array, String, Math, Number` from JavaScript, giving you all the power from JavaScript while staying in Lua!

# License

Copyright (c) 2021 Miigon, open-sourced under the MIT License

# Examples
tested under Lua 5.1 and LuaJIT 2.1.0-beta3
## Array
```lua
local Array = require("./jspower.lua").Array

-- Notice that indecies in Lua start from 1, not 0. 

local a = Array.new({1, 2, 3, 4, 5})
print(a) -- 1,2,3,4,5

print(a:pop()) -- 5
print(a:pop()) -- 4
print(a) -- 1,2,3

print(a:push(666)) -- 4 (new length of the array)
print(a) -- 1,2,3,666

print(a:reverse()) -- 666,3,2,1

print(a:unshift(777)) -- 5 (new length of the array)
print(a:shift()) -- 777
print(a:shift()) -- 666
print(a) -- 3,2,1

local a = Array.new({1, 2, 3, 4, 5, 6, 7, 8})
print(a) -- 1,2,3,4,5,6,7,8

print(a:slice(4,7)) -- 4,5,6
print(a) -- 1,2,3,4,5,6,7,8

print(a:splice(4,3)) -- 4,5,6
print(a) -- 1,2,3,7,8

print(a:reduce(function(acc, val) return acc + val end)) -- 21

local a = Array.new({"banana", "cat", "apple"})
print(a:sort()) -- apple,banana,cat

print(a:includes("banana")) -- true
print(a:includes("coconut")) -- false
print(a:indexOf("banana")) -- 2
print(a:indexOf("coconut")) -- -1

local a = Array.new({1, 2, 3, 4, 5, 6, 7, 8})
print(a:filter(function(v, i) return i % 2 == 0 end)) -- 2,4,6,8

-- and many more...
```
## String

```lua
local jsp = require("./jspower.lua")
local String = jsp.String


print(String.fromCharCode(97)) -- a
print(String.charCodeAt("hello, world!",8)) -- 119
print(String.charAt("hello, world!",8)) -- w
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

```

## Number

```lua
local jsp = require("./jspower.lua")
local Number = jsp.Number

print(Number.parseInt("13A6")) -- 13
print(Number.parseInt("13A6",16)) -- 5030
print(Number.toFixed(13.44511, 2)) -- 13.45
print(Number.toPrecision(13.44511, 3)) -- 13.4
print(Number.isNaN(11111)) -- false
print(Number.isNaN(Number.NaN)) -- true
print(Number.isFinite(jsp.Infinity)) -- false
print(Number.isFinite(3.33333)) -- true
```

# Disclaimer

This project is not thoroughly tested against each and every edge-cases, and may not produce consistent result with a real JavaScript engine.

However, if you did find any such inconsistency, please report by opening an issue! Any contribution is appreciated!

# Unsupported Features

RegEx, locale, UTF-16 related (due to lack of native support) functionalities
