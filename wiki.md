Welcome to the *KittyLib* documentation.

Made for version `0.1.1`

# Libraries
- string
- table
- math
- common

# string
An expanded version of the default string library.

## string.split
*`LuaU`* *`Lua5.1`* *`Lua5.4`*
```lua
string.split(s: string, sep: string): ({string}, number)
```

Splits the string into parts based on the seperator string, also returns the amount of times the string has been split.

### Example
```lua
local str = "Hello World!"
local splitstr, splitamount = string.split(str, " ")

print(splitstr[1], splitstr[2], splitamount) --> [1]"Hello" [2]"World!" [3]1
```

## string.divide
*`LuaU` `Lua5.1`*
```lua
string.divide(s: string, div: number): {string}
```

Similair to `string.split` but instead of splitting the string based on another string, it splits the string based on how many times it needs to be split.

### Example
```lua
local str = "Hello World!"
local div = 4

local dividedstring = string.divide(str, div)
print(dividedstring[1], dividedstring[2], dividedstring[3], dividedstring[4]) --> [1]"Hel" [2]"lo " [3]"Wor" [4]"ld!"
```
---

# table
Expansion to the default table library.

## table.tostring
*`LuaU` `Lua5.1` `Lua5.4`*
```lua
table.tostring(t: {}, mode: number? <0, 1>): string
```
Converts a table to almost an exact string replica of the original, it cannot turn functions or nil values into strings though.

### Example
```lua
local tabletoConvert = {
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

print(table.tostring(tabletoConvert, 0)) --> {[1] = 1, [2] = "string", [3] = true, one = 1, [{[1] = "table index"}] = {[1] = "string"}, ["twenty two"] = 22}
print(table.tostring(tabletoConvert, 1)) 
--[[--> 
{
	[1] = 1, 
	[2] = "string", 
	[3] = true, 
	one = 1, 
	[{[1] = "table index"}] = {
		[1] = "string"
	}, 
	["twenty two"] = 22
}
]]
```

## table.copy
*`LuaU` `Lua5.1` `Lua5.4`*
```lua
table.copy(t: {}): {}
```

Deepclones a table, same as most deepclone functions you can find on google.

## table.deepfreeze
*`LuaU`*
```lua
table.deepfreeze(t: {})
```

Freezes a table and its descendants which are also a table.

## table.isdeepfrozen
*`LuaU`*
```lua
table.isdeepfrozen(t: {}): boolean
```

Checks a table and its descendants if they are frozen, if one is not frozen, it will return `false`

## table.destroy
*`LuaU` `Lua5.1` `Lua5.4`*
```lua
table.destroy(t: {}): {}
```

Clears a table and its descendant tables.

## table.replace
*`LuaU` `Lua5.1` `Lua5.4`*
```lua
table.replace(t: {}, vt: {}): {}
```
Replaces each value in `t` which has the same index as in `vt`

## table.deepreplace
*`LuaU` `Lua5.1` `Lua5.4`*
```lua
table.deepreplace(t: {}, vt: {}): {}
```
Same as `table.replace` but instead replaces values in table values as well.

## table.find
*`LuaU` `Lua5.1` `Lua5.4`*
```lua
table.find(t: {}, value: any): number?
```
[Documentation for table.find](https://create.roblox.com/docs/reference/engine/libraries/table#find) except it has no init argument.

## table.findkey
*`LuaU` `Lua5.1` `Lua5.4`*
```lua
table.findkey(t: {}, index: string): number?
```

Finds the number index of `index`, returns nil if it cannot be found.

## table.len
*`LuaU` `Lua5.1` `Lua5.4`*
```lua
table.len(t: {}): number
```

Returns the full length of a table, including string indexed values.

## table.deeplen
*`LuaU` `Lua5.1` `Lua5.4`*
```lua
table.deeplen(t: {}): number
```

Returns the length of the whole table including descendant table lengths.

## table.clear
*`(Already in LuaU)` `Lua5.1` `Lua5.4`*
```lua
table.clear(t: {}): {}
```

Clears the entire table.


---

# math
Some features from `Lua5.4` ported over to `LuaU` and `Lua5.1`, and some other functions.

## math.type
*`LuaU` `Lua5.1` `(Already in 5.4)`*
```lua
math.type(n: number): ("integer" | "float")?
```
Returns `"integer"` if `n` is an integer, `"float"` if it is a float, or nil if `n` is not a number.

## math.tointeger
*`LuaU` `Lua5.1` `(Already in 5.4)`*
```lua
math.tointeger(float: number): number?
```

If the float is convertible to an integer, it will return an integer of that float, returns nil otherwise.

## math.ult
*`LuaU` `Lua5.1` `(Already in 5.4)`*
```lua
math.ult(m: number, n: number): boolean
```
Returns a boolean, true if and only if integer `m` is below integer `n` when they are compared as unsigned integers.

## math.rounddec
*`LuaU` `Lua5.1` `Lua5.4`*
```lua
math.rounddec(n: number, decimal: number): number
```

Returns a float with a rounded decimal count

## math.decimal
*`LuaU` `Lua5.1` `Lua5.4`*
```lua
math.decimal(n: number): number?
```

Counts and returns the amount of decimals behind a float, returns nil if it is not a float.

## math.tobinary
*`LuaU` `Lua5.4`*
```lua
math.tobinary(n: number): string
```

Returns a binary string of a number, the input number cannot be a float.

## math.frombinary
*`LuaU` `Lua5.4`*
```lua
math.frombinary(binary: string): number
```

Converts a binary string into a number.

## math.randomfloat
*`LuaU` `Lua5.1` `Lua5.4`*
```lua
math.randomfloat(min: number, max: number, decimal: number?)
```

Generates a more accurate random float, with an optional decimal count to control how many random decimals come after.

---

###### the end :D
