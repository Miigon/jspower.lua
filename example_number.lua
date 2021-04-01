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