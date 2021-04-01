-- jspower.lua 
-- (all the power from JavaScript while staying in Lua!)
-- 
-- Copyright (c) 2021 Miigon, open-sourced under the MIT License
-- https://github.com/Miigon/jspower.lua

local LOAD_JSP_INTO_GLOBAL = false

local _NaN = 0/0

------------- Array ------------- 

local Array = {
    prototype = {}
}

Array.new = function(obj)
    obj = obj or {}
    for i=1,#obj do
        if type(obj[i]) == "table" then
            obj[i] = Array.new(obj[i])
        end
    end
    setmetatable(obj, { __index = Array, __tostring = Array.toString })
    return obj
end

Array.from = function(obj, mapFn)
    if mapFn then return Array.from(obj):map(mapFn) end
    local ret = Array.new()
    for i=1,#obj do
        ret[#ret+1] = obj[i]
    end
    return ret
end

Array.isArray = function(obj)
    return getmetatable(obj) == Array
end

Array.concat = function(...)
    local ret = Array.new()
    local arg = {...}
    for i = 1, #arg do
        local arr = arg[i]
        if type(arr) == "table" then
            for j = 1, #arr do
                ret[#ret + 1] = arr[j]
            end
        else
            ret[#ret + 1] = arr;
        end
    end 
    return ret
end

Array.at = function(arr, ind) -- experimental ECMAScript functionality
    if ind < 0 then ind = #arr + ind + 1 end
    return arr[ind]
end

Array.every = function(arr, f)
    for i = 1,#arr do
        if not f(arr[i], i, arr) then return false end
    end
    return true
end

Array.fill = function(arr, f)
    error("JSPOWER_NOT_IMPLEMENTED")
end

Array.filter = function(arr, f)
    local ret = Array.new()
    for i = 1,#arr do
        if f(arr[i], i, arr) then ret[#ret+1] = arr[i] end
    end
    return ret
end

Array.find = function(arr, f)
    for i = 1,#arr do
        if f(arr[i], i, arr) then return arr[i] end
    end
    return nil
end

Array.findIndex = function(arr, f)
    for i = 1,#arr do
        if f(arr[i], i, arr) then return i end
    end
    return nil
end

Array.flat = function(arr, depth)
    if depth ~= nil and depth <= 0 then return arr end
    depth = depth or 1
    local ret = Array.new()
    for i = 1,#arr do
        if type(arr[i]) == "table" then
            local flattened = Array.flat(arr[i], depth-1)
            for i = 1,#flattened do
                ret[#ret+1] = flattened[i]
            end
        else
            ret[#ret+1] = arr[i]
        end
    end
    return ret
end

Array.flatMap = function(arr, f)
    return arr:map(f):flat(1)
end

Array.forEach = function(arr, f)
    for k,v in pairs(arr) do
        f(v, k, arr)
    end
end

Array.includes = function(arr, v, fromInd)
    return arr:indexOf(v, fromInd) ~= -1
end

Array.indexOf = function(arr, v, fromInd)
    fromInd = fromInd or 1
    if fromInd < 0 then fromInd = #arr + fromInd + 1 end
    for i=fromInd,#arr do
        if arr[i] == v then return i end
    end
    return -1
end

Array.join = function(arr, sep)
    sep = sep or ','
    return table.concat(arr, sep)    
end

Array.keys = function()
    error("JSPOWER_NOT_IMPLEMENTED") -- use pairs() instead
end

Array.lastIndexOf = function(arr, v, fromInd)
    fromInd = fromInd or #arr
    if fromInd < 0 then fromInd = #arr + fromInd + 1 end
    for i=fromIndex,1,-1 do
        if arr[i] == v then return i end
    end
    return -1
end

Array.map = function(arr, f)
    local ret = Array.new()
    for k,v in pairs(arr) do
        ret[#ret+1] = f(v, k, arr)
    end
    return ret
end

Array.pop = function(arr)
    local ret = arr[#arr]
    table.remove(arr, #arr)
    return ret
end

Array.push = function(arr, v)
    arr[#arr+1] = v;
    return #arr
end

Array.reduce = function(arr, f, initial)
    local acc = initial
    
    local start = 1
    if acc == nil then
        acc = arr[start]
        start = start + 1
    end

    for i=start,#arr do
        acc = f(acc, arr[i], i, arr)
    end
    return acc
end

Array.reduceRight = function(arr, f, initial)
    local acc = initial
    
    local start = #arr
    if acc == nil then
        acc = arr[start]
        start = start - 1
    end

    for i=start,1,-1 do
        acc = f(acc, arr[i], i, arr)
    end
    return acc
end

Array.reverse = function(arr) -- {1,2,3,4,5}, #arr = 5, pivot = 2
    local pivot = #arr/2
    for i=1,pivot do
        local tmp = arr[i]
        arr[i] = arr[#arr-i+1]
        arr[#arr-i+1] = tmp
    end
    return arr
end


Array.shift = function(arr)
    local ret = arr[1]
    table.remove(arr, 1)
    return ret
end

Array.slice = function(arr, start, end_)
    start = start or 1
    end_ = end_ or #arr + 1
    if start < 0 then start = #arr + start + 1 end
    if end_ < 0 then end_ = #arr + end_ + 1 end
    
    local sliced = Array.new()
    
    for i = start, end_ - 1 do
        sliced[#sliced+1] = arr[i]
    end
    
    return sliced
end

Array.some = function(arr, f)
    for i = 1,#arr do
        if f(arr[i], i, arr) then return true end
    end
    return false
end

Array.sort = function(arr, f)
    f = f or function(a,b)return tostring(a) < tostring(b)end
    table.sort(arr,f)
    return arr
end

Array.splice = function(arr, start, deleteCount)
    if deleteCount == nil or start + deleteCount - 1 > #arr then
        deleteCount = #arr - start + 1
    end
    local sliced = arr:slice(start, start + deleteCount)

    for i = 1, deleteCount do
        table.remove(arr,start)
    end
    
    return sliced
end


Array.toLocaleString = function(arr)
    error("JSPOWER_NOT_IMPLEMENTED")
end


Array.toString = function(arr)
    return table.concat(arr, ',')
end

Array.unshift = function(arr, v)
    table.insert(arr, 1, v)
    return #arr
end

Array.values = function(arr, v)
    error("JSPOWER_NOT_IMPLEMENTED") -- use pairs() instead
end

------------- Date -------------
--[[
    Date isn't implemented because Date in javascript is so badly
    designed I don't think anyone would want to use that.
]]

------------- Math -------------
local Math = {
    E = 2.718281828459045,
    LN2 = 0.6931471805599453,
    LN10 = 2.302585092994046,
    LOG2E = 1.4426950408889634,
    LOG10E = 0.4342944819032518,
    PI = 3.141592653589793,
    SQRT1_2 = 0.7071067811865476,
    SQRT2 = 1.4142135623730951,
    Infinity = math.huge,

    abs = math.abs,
    acos = math.acos,
    asin = math.asin,
    atan = math.atan,
    atan2 = math.atan2,
    ceil = math.ceil,
    clz32 = nil, -- not useful enough in lua
    cos = math.cos,
    cosh = math.cosh,
    exp = math.exp,
    expm1 = nil, -- just do exp(x)-1
    floor = math.floor, -- just do exp(x)-1
    fround = nil, -- not useful enough in lua
    imul = nil, -- not useful enough in lua
    log = math.log,
    log1p = nil, -- just do log(1+x)
    log10 = math.log10,
    max = math.max,
    min = math.min,
    pow = math.pow,
    random = math.random,
    sin = math.sin,
    sinh = math.sinh,
    sqrt = math.sqrt,
    tan = math.tan,
    tanh = math.tanh,
    
}

Math.acosh = function(x) 
    return Math.log(x + Math.sqrt(x * x - 1))
end

Math.asinh = function(x)
    local absX = Math.abs(x)
    local w
    if absX < 3.725290298461914e-9 then -- |x| < 2^-28
        return x
    end
    if absX > 268435456 then -- |x| > 2^28
        w = Math.log(absX) + Math.LN2
    elseif absX > 2 then -- 2^28 >= |x| > 2
        w = Math.log(2 * absX + 1 / (Math.sqrt(x * x + 1) + absX))
    else
        local t = x * x
        w = Math.log(1 + absX + t / (1 + Math.sqrt(1 + t)))
    end

    return x > 0 and w or -w
end

Math.asinh = function(x)
    local absX = math.abs(x)
    local w
    if absX < 3.725290298461914e-9 then -- |x| < 2^-28
        return x
    end
    if absX > 268435456 then -- |x| > 2^28
        w = math.log(absX) + Math.LN2
    elseif absX > 2 then -- 2^28 >= |x| > 2
        w = math.log(2 * absX + 1 / (math.sqrt(x * x + 1) + absX))
    else
        local t = x * x
        w = Math.log(1 + absX + t / (1 + math.sqrt(1 + t)))
    end

    return x > 0 and w or -w
end

Math.atanh = function(x)
    return math.log((1+x)/(1-x)) / 2;
end

Math.cbrt = function(x)
    return x < 0 and - math.pow(x, 1/3) or math.pow(x, 1/3);
end

Math.hypot = function(...)
    local max = 0
    local s = 0
    local arguments = {...}
    for i=1,#arguments do
        local nn = tonumber(arguments[i])
        if nn == nil then return _NaN end
        local arg = math.abs(nn)
        if arg == math.huge then
            return math.huge
        end
        if arg > max then
            s = s * ((max / arg) * (max / arg))
            max = arg;
        end
        s = s + ((arg == 0 and max == 0) and 0 or (arg / max) * (arg / max))
    end
    return (max == 1 / 0) and (1 / 0) or (max * math.sqrt(s))
end

Math.log2 = function(x)
    return math.log(x) / math.log(2)
end

Math.round = function(x)
    return math.floor(x+0.5)
end

Math.sign = function(x)
    if x > 0 then return 1
    elseif x < 0 then return -1
    else return 0
    end
end

Math.trunc = function(x)
    local x_num = tonumber(x)
    if x_num == nil then return _NaN end
    local intPart = math.modf()
    return intPart
end

------------- Number -------------

local Number = {
    EPSILON = math.pow(2,-52),
    -- Lua 5.3 changed the way integers are handled
    -- Feature depending on MAX_SAFE_INTEGER, eg. isSafeInteger, will not work under Lua 5.3
    MAX_SAFE_INTEGER = _VERSION == "Lua 5.3" and nil or 9007199254740991, -- (2^53 - 1)
    MIN_SAFE_INTEGER = _VERSION == "Lua 5.3" and nil or -9007199254740991, -- -(2^53 - 1)
    MAX_VALUE = (math.pow(2,1023)-math.pow(2,970))*2, -- WARNING: approximation
    MIN_VALUE = 5e-324,
    NaN = 0/0,
    POSITIVE_INFINITY = math.huge,
    NEGATIVE_INFINITY = -math.huge,
}

Number.isFinite = function(v)
    return not (v == math.huge or v == -math.huge or v ~= v or v == nil)
end

Number.isInteger = function(v)
    return type(v) == "number" and Number.isFinite(v) and math.floor(v) == v
end

Number.isNaN = function(v)
    return v ~= v
end

Number.isSafeInteger = function(v)
    return Number.isInteger(v) and math.abs(v) <= Number.MAX_SAFE_INTEGER
end

Number.parseFloat = function()
    error("JSPOWER_NOT_IMPLEMENTED")
end

Number.parseInt = function(str, radix)
    str = tostring(str)
    radix = tonumber(radix)
    local negative_sign = false
    if string.sub(str,0,1) == '-' then
        negative_sign = true
        str = string.sub(str,2)
    end
    local firstTwoLetters = string.sub(str,1,2)
    if radix == nil then
        if firstTwoLetters == "0X" or firstTwoLetters == "0x" then
            radix = 16
        else
            radix = 10
        end
    end
    radix = radix or 10
    if radix < 2 or radix > 36 then
        return _NaN
    end
    local num = 0
    local isNaN = true
    local startIndex = 1
    if radix == 16 and (firstTwoLetters == "0X" or firstTwoLetters == "0x") then
        startIndex = 3
    end
    for i=startIndex,#str do
        local c_code = string.byte(str, i);
        local digit = -1
        if c_code >= 48 and c_code <= 48 + 9 and c_code <= 48 + radix then -- 0 to min(9,radix)
            digit = c_code - 48
        elseif c_code >= 65 and c_code <= 65 + radix - 11 then
            digit = 10 + c_code - 65
        elseif c_code >= 97 and c_code <= 97 + radix - 11 then
            digit = 10 + c_code - 97
        else -- invalid digit
            break
        end
        if digit ~= -1 then
            isNaN = false
            num = (num * radix + digit)
        end
    end
    if isNaN then return _NaN end
    if negative_sign then return -num else return num end
end

Number.toExponential = function(v,fractionDigits)
    return string.format("%." .. (fractionDigits or 0) .. "e",v)
end

Number.toFixed = function(v, digits)
    return string.format("%." .. (digits or 0) .. "f",v)
end

Number.toLocaleString = function(v, digits)
    error("JSPOWER_NOT_IMPLEMENTED")
end

Number.toPrecision = function(v, digits)
    return string.format("%." .. (digits or 0) .. "g",v)
end

Number.toString = function(v, radix)
    -- WARNING: implementation of this function might not be accurate.
    if radix == nil then radix = 10 end
    if radix < 2 or radix > 36 then return error("JSPOWER_RANGE_ERROR") end
    v = tonumber(v)
    if radix == 10 then return tostring(v) end
    local negative_sign = false
    if v < 0 then
        negative_sign = true
        v = -v
    end
    local res = {}
    local whole, fraction = math.modf(v)
    while whole ~= 0 do
        local digit_value = math.floor(whole % radix)
        res[#res + 1] = digit_value
        whole = math.floor(whole / radix)
    end
    if negative_sign then res[#res+1] = '-' end
    Array.reverse(res)
    local fracDigits = 0
    if fraction ~= 0 then res[#res + 1] = '.' end
    while fraction ~= 0 and fracDigits < 49 do
        fraction = fraction * radix
        local intPart, newFraction = math.modf(fraction)
        res[#res + 1] = intPart
        fraction = newFraction
        fracDigits = fracDigits + 1
    end
    for i=1,#res do
        local d = res[i]
        if d == '.' or d == '-' then
            -- do nothing
        elseif d >= 0 and d <= 9 and d <= radix then
            res[i] = string.char(48 + d)
        elseif d >= 10 and d <= radix then
            res[i] = string.char(97 + d - 10)
        end
    end 
    return Array.join(res, '')
end

------------- String -------------

local String = {
    charCodeAt = string.byte,
    ["repeat"] = string.rep,
    slice = string.sub,
    toLowerCase = string.lower,
    toUpperCase = string.upper,
}

String.charAt = function(str, ind)
    return string.sub(str, ind, ind)
end

String.concat = function(...)
    return table.concat({...})
end

String.endsWith = function(str, ss, length)
    length = length or #str
    return string.sub(str,length-#ss+1,length) == ss
end

String.fromCharCode = function(...)
    local args = {...}
    for i=1,#args do
        args[i] = string.char(args[i])
    end
    return table.concat(args)
end

String.includes = function(str, ss, pos)
    return string.find(str, ss, pos, true) ~= nil
end

String.indexOf = function(str, ss, fromInd)
    local ind = string.find(str, ss, fromInd, true)
    return ind ~= nil and ind or -1
end

String.lastIndexOf = function(str, ss, fromInd)
    fromInd = fromInd or 0
    local ind = string.find(string.reverse(str), string.reverse(ss), -fromInd, true)
    return ind ~= nil and (#str - ind - #ss + 2) or -1
end

local function generatePadding(str, target, pad)
    pad = pad or ' '
    local padding = string.rep(pad,math.ceil((target - #str)/#pad))
    if #str + #padding > target then
        padding = string.sub(padding, 1, target - #str)
    end
    return padding
end

String.padEnd = function(str, target, pad)
    return str .. generatePadding(s, target, pad)
end

String.padStart = function(str, target, pad)
    return generatePadding(s, target, pad) .. str
end

String.startsWith = function(str, ss, pos)
    pos = pos or 1
    return string.sub(str,pos,pos+#ss-1) == ss
end

String.split = function(str, sep)
    sep = sep or " "
    local res = Array.new()
    if sep == "" then
        for i=1,#str do
            res[#res + 1] = string.sub(str, i, i)
        end
        return res
    end
    local lastPos = 1
    while lastPos <= #str do
        local ms, me = string.find(str, sep, lastPos, true)
        if ms == nil then break end
        res[#res + 1] = string.sub(str, lastPos, ms - 1)
        lastPos = me + 1
    end
    res[#res + 1] = string.sub(str, lastPos, -1)
    return res
end

String.startsWith = function(str, ss, pos)
    pos = pos or 1
    return string.sub(str,pos,pos+#ss-1) == ss
end

String.trim = function(str)
    local trimmed = string.gsub(str, '^%s*(.-)%s*$', '%1')
    return trimmed
end

String.trimEnd = function(str)
    local trimmed = string.gsub(str, '^(.-)%s*$', '%1')
    return trimmed
end

String.trimStart = function(str)
    local trimmed = string.gsub(str, '^%s*(.-)$', '%1')
    return trimmed
end

-- copy jspower String functionalities to lua's string library
local extendLuaString = function()
    for k,v in pairs(String) do
        if string[k] == nil then
            string[k] = v
        end
    end
end

------------- Map -------------
-- not yet implemented

------------- Set -------------
-- not yet implemented


local jsp = {
    Array = Array,
    Math = Math,
    Number = Number,
    String = String,
    Infinity = math.huge,
    extendLuaString = extendLuaString,
}

if LOAD_JSP_INTO_GLOBAL then
    _G.jsp = jsp
end

return jsp