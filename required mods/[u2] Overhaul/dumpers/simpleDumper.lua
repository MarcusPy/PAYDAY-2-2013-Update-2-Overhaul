-- simple dumper, produces ~2mb when _G is passed
-- see CoreLuaDumpFix for a more elaborate one that produces ~200mb of _G
local parsedTables = {}

local function tableExists(tab, data)
	for _, v in pairs(tab) do
		if v == data then
			return true
		end
	end
	return false
end

function dump_table(file, tab, depth)
	table.insert(parsedTables, tab)

	for key, value in pairs(tab) do
		for i = 1, depth do
			file:write("  ")
		end

		if type(value) == "table" and not tableExists(parsedTables, value) then
			file:write(tostring(key) .. ":\n")
			dump_table(file, value, depth + 1)
		else
			file:write(tostring(key) .. " = " .. tostring(value) .. "\n")
		end
	end

	file:write("\n")
	file:flush()
end
--[[
local file = u2mm.save_folder .. "simpleDump.txt"
u2mm:createSaveFile(file)
file = io.open(file, "w")
dump_table(file, _G.u2_core, 0)
file:flush()
file:close()
]]