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