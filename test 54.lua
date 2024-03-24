local KittyLib = require("KittyLib Lua54")
local math = KittyLib.math
local string = KittyLib.string
local table = KittyLib.table
local common = KittyLib.common

local float = 1.1
local int = 200
print(math.tobinary(int))
print(math.frombinary(math.tobinary(int)))

print(table.tostring(string.split("string with space", " "), 1))

print(math.rounddec(2.56, 1))
print(math.decimal(float))
print(math.randomfloat(int, int + int, 3))

local sampleTable = {
    1,
    one = 1,
    "string",
    ["twenty two"] = 22,
    true,
    nil,
    [{"table index"}] = {
        "string"
    }
}

print(table.tostring(sampleTable, 0))
print(table.tostring(sampleTable, 1))

print(table.tostring(sampleTable, 1))
print(table.tostring(table.replace(sampleTable, {[1] = 2}), 1))

print(table.tostring(sampleTable, 1))
print(table.tostring(table.deepreplace(sampleTable, {[1] = 2, [{"table index"}] = 5}), 1))

print(table.find(sampleTable, 5))
print(table.findkey(sampleTable, "twenty two"))

print(table.len(sampleTable))
print(table.deeplen(sampleTable))

local newSample = table.destroy(sampleTable)
print(table.tostring(newSample, 1))
