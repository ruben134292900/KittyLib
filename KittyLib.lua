local table = setmetatable({}, {__index = table})
local math = setmetatable({}, {__index = math})
local string = setmetatable({}, {__index = string})
local common = {}

local KittyLib = {_VERSION = "0.1.0"}

do -- commons

end

do -- string
	function string.split(s: string, sep: string): ({string}, number)
		if sep == nil then
			sep = "%s"
		end

		local t = {}
		local splits = 0

		for str in string.gmatch(s, "([^"..sep.."]+)") do
			table.insert(t, str)
			splits += 1
		end

		return t, splits
	end

	function string.divide(s: string, div: number): {string}
		local t = {}
		for i=1, div do
			local len = string.len(s) / div
			local strend = i * len
			local start = (strend - len) + (i > 1 and 1 or 0)

			t[i] = string.sub(s, start, strend)
		end
		return t
	end
end

do -- math
	-- Lua 5.4 backports
	function math.type(n: number): ("integer" | "float")?
		if typeof(n) ~= "number" then
			return nil
		end
		if n % 1 ~= 0 then
			return "float"
		else
			return "integer"
		end
	end

	function math.tointeger(float: number): number?
		if math.type(float) == "float" then
			return float - (float % 1)
		else
			return nil
		end
	end

	function math.ult(m: number, n: number): boolean
		local m1 = m >= 0 and m or n + 0x80000000 + 0x80000000
		local n1 = n >= 0 and n or n + 0x80000000 + 0x80000000
		return m1 < n1
	end

	-- other
	function math.rounddec(n: number, decimal: number)
		local mult = 10 ^ (decimal)
		return math.modf(n * mult) / mult
	end

	function math.decimal(n: number): number?
		if math.type(n) == "float" then
			return #(tostring(n):split(".")[2])
		else
			return nil
		end
	end

	function math.tobinary(n: number): string
		assert(math.type(n) == "integer", "input value must be an integer.")

		local ret=""
		while n ~= 1 and n ~= 0 do
			ret = tostring(n % 2) .. ret
			n = math.modf(n / 2)
		end
		ret = tostring(n) .. ret
		return ret
	end

	function math.frombinary(binary: string): number
		return tonumber(binary, 2)
	end

	function math.randomfloat(min: number, max: number, decimal: number?)
		local decimal = decimal or 1000
		return math.random(min * decimal, max * decimal) / decimal
	end
end

do -- table
	local function tostringTable(t: {}, mode: number?, indent: number, tostringed)
		local tostringed = tostringed or {}
		tostringed[tostring(t)] = true

		local stringTable = "{" .. (mode == 1 and "\n" or "")
		for i, v in next, t do
			local indexType = typeof(i)
			local valueType = typeof(v)

			local index = i
			if indexType == "number" then
				index = '[' .. i .. ']'
			elseif indexType == "string" and string.find(i, " ") then
				index = '["' .. i .. '"]'
			elseif indexType == "table" then
				index = "[" .. tostringTable(i, 0, 0) .. "]"
			end

			local value = ""
			if valueType == "string" then
				value = '"' .. v .. '"'
			elseif valueType == "number" or valueType == "nil" or valueType == "boolean" then
				value = tostring(v)
			elseif valueType == "table" then
				if tostringed[tostring(v)] == nil then
					value = tostringTable(v, mode, indent + 1, tostringed)
				end
			else
				value = tostring(v)
			end

			stringTable ..= string.rep("\t", (mode == 1 and indent or 0)) .. index .. " = " .. value

			if table.findkey(t, i) ~= table.len(t) then
				stringTable ..= ", "
			end

			stringTable ..= (mode == 1 and "\n" or "")
		end
		stringTable ..= string.rep("\t", (mode == 1 and indent - 1 or 0)) .. "}"

		return stringTable
	end

	function table.tostring(t: {}, mode: number?): string
		local mode = mode or 0
		assert(not (mode > 1 or mode < 0), "mode is out of range.")
		assert(typeof(t) == "table", "t must be a table.")
		return tostringTable(t, mode, 1)
	end

	function table.copy(t: {})
		local copied = {}
		for i, v in next, t do
			if type(v) == "table" then
				copied[i] = table.copy(v)
			else
				copied[i] = v
			end
		end
		return copied
	end

	function table.deepfreeze(t)
		for i, v in next, t do
			if type(v) == "table" then
				pcall(function() table.freeze(v) end)
				table.deepfreeze(v)
			end
		end
		pcall(function() table.freeze(t) end)
		return t
	end

	function table.isdeepfrozen(t)
		local deepfrozen = table.isfrozen(t)
		for i, v in next, t do
			if type(v) == "table" then
				deepfrozen = deepfrozen and table.isdeepfrozen(v)
			end
		end
		return deepfrozen
	end

	function table.destroy(t)
		for i, v in next, t do
			if type(v) == "table" then
				table.destroy(v)
			end
		end
		table.clear(t)
		t = nil
	end

	function table.replace(t, vt)
		for i, v in next, vt do
			if t[i] then
				t[i] = v
			end
		end
	end

	function table.deepreplace(t, vt)
		for i, v in next, vt do
			if t[i] then
				if type(t[i]) == "table" and type(v) == "table" then
					table.deepreplace(t[i], v)
				else
					t[i] = v
				end
			end
		end
	end

	function table.find(t, value)
		local key = 0
		for i, v in next, t do
			key = key + 1
			if v == value then
				break
			end
		end

		if key == 0 then
			key = nil
		end

		return key
	end

	function table.findkey(t, index)
		if type(index) == "number" then
			return index
		else
			if table.find(t, index) == nil then
				error(tostring(index) .. " is not found in " .. tostring(t))
			end

			local key = 0
			for i, v in next, t do
				key = key + 1

				if i == index then
					return key
				end
			end

		end
	end

	function table.len(t)
		local len = 0
		for i, v in next, t do
			len = len + 1
		end
		return len
	end

	function table.deeplen(t)
		local len = 0
		for i, v in next, t do
			len = len + 1
			if type(v) == "table" then
				len = len + table.deeplen(v)
			end
		end
		return len
	end
end

KittyLib.math = math
KittyLib.table = table
KittyLib.string = string
KittyLib.common = common

return KittyLib