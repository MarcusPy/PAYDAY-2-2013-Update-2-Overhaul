_G.u2mm = _G.u2mm or {
	origin = nil,
	save_folder = Application:base_path() .. "[u2] Saves/",
	info = {
		version = '1.1',
		revision = '25/XI/2024'
	}
}

-- load extra utility methods that don't rely on the content of this file and can be used separately
dofile(Application:base_path() .. "/mods/[u2] Mod Manager/utils.lua")

function u2mm:createSaveFolder()
	local exists = os.rename(u2mm.save_folder, u2mm.save_folder)
	if not exists then
		os.execute("mkdir \"" .. u2mm.save_folder .. "\"")
	end
end

-- used to verify whether the save file exists or not
function u2mm:createSaveFile(file)
	local exists = io.open(file, "r")
	if exists then
		exists:close(file)
	elseif not exists then
		local newFile = io.open(file, "w")
		newFile:close()
	end
end

-- updates the value of the specified key in the specified table, duh
function u2mm:updateSetting(tbl, key, value)
    local function searchAndUpdate(tbl, key, value)
        for k, v in pairs(tbl) do
            if k == key then
                if value ~= nil then
                    tbl[k] = value
                end
                return true
            elseif type(v) == "table" then
                local found = searchAndUpdate(v, key, value)
                if found then
                    return true
                end
            end
        end
        return false
    end

    local found = searchAndUpdate(tbl, key, value)
    if not found then
        log("key not found: " .. key)
    end
end

-- YOU MUST DEFINE YOUR TABLE AS A GLOBAL, NOT A LOCAL
-- word of advice (you can choose to ignore it):
-- preferably don't pass your entire table defined within _G,
-- create a nested table called something like "settings" where the config variables will be stored,
-- then pass only that table, this is to avoid saving variables that aren't user config
-- like path to config file, should you choose to store it there that is
function u2mm:saveSettingsToFile(file, settings)
    -- First of all check if the file exists or create it
    u2mm:createSaveFile(file)
    
    local function extractValuesFromTable(arr, prefix)
        local values = {}
        for k, v in pairs(arr) do
            local key = tostring(k)
            if prefix then
                key = prefix .. "." .. key
            end
            if type(v) == "table" then
                local _values = extractValuesFromTable(v, key)
                for _, nestedValue in ipairs(_values) do
                    table.insert(values, nestedValue)
                end
            else
                table.insert(values, key .. "=" .. tostring(v))
            end
        end
        return values
    end
    
    local saveFile = io.open(file, "w")
    if not saveFile then
        log("Error: Could not open file: [" .. file .. "] for writing.")
        return
    end
    
    local dataToSave = extractValuesFromTable(settings)
    for _, v in ipairs(dataToSave) do
        saveFile:write(v .. "\n")
    end
    
    saveFile:close()
end

-- same here, pass only the settings part of your global table
-- this method well, reads the settings saved in the file and applies them to the provided settings table
function u2mm:readSettingsFromFile(file, settings)
    local function splitString(inputstr, sep)
        if sep == nil then
            sep = "%s"
        end
        local t = {}
        for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
            table.insert(t, str)
        end
        return t
    end

    local function convertToType(value)
        if value == "true" then
            return true
        elseif value == "false" then
            return false
        elseif tonumber(value) ~= nil then
            return tonumber(value)
        else
            return u2mm:parseValueFromString(value)
        end
    end

    local saveFile, err = io.open(file, "r")
    if not saveFile then
        if err:find("No such file") then
            -- save file has not been created yet
        else
            log("Error: Could not open file: [" .. file .. "] for reading. " .. err)
        end
        return
    end

    for line in saveFile:lines() do
        local keyValuePair = splitString(line, "=")
        if #keyValuePair == 2 then
            local keyPath = splitString(keyValuePair[1], ".")
            local value = convertToType(keyValuePair[2])
            local currentTable = settings
            for i = 1, #keyPath - 1 do
                local key = keyPath[i]
                currentTable[key] = currentTable[key] or {}
                currentTable = currentTable[key]
            end
            currentTable[keyPath[#keyPath]] = value
        end
    end

    saveFile:close()
end

-- this and the next method are used to setup values, with which options are set up
-- this is the main method that should be used
function u2mm:matchSavedValueToOption(val, data)
    local function isBoolean(var)
        return type(var) == "boolean"
    end
	
	local function isNumber(value)
		return type(value) == "number"
	end

    local dataCopy = deep_clone(data)
    for idx, option in ipairs(dataCopy) do
        if type(option.value) == "string" and u2mm:startsWith(option.value, "{") then
            local var = loadstring("return " .. option.value)
            option.value = var()
			if u2mm:tablesEqual(option.value, val) then
				--log("tablesEqual() returned true")
				return idx
			end
        elseif isBoolean(option.value) and option.value == val then
			--log("returning "..tostring(val).." of type "..tostring(type(val)))
            return val
        elseif isNumber(option.value) and option.value == val then
			--log("returning "..tostring(val).." of type "..tostring(type(val)))
            return val
        end
    end
	--log("matchSavedValueToOption() returned nil, found no matches in option.value")
    return
end

-- this method should be used only when dealing with objects
-- here both parametres are presented as string and are compared as such
function u2mm:matchStringToOption(val, data)
    local dataCopy = deep_clone(data)
    for idx, option in ipairs(dataCopy) do
		if option.value == val then
			return idx
		end
    end

    return
end

-- since PD2's item:value() method doesn't work with tables,
-- we need to simulate it using a string and extract the values
-- so strings like: "4", "-15", "69.1", "false", "Color.green" will return as 4, -15, 69.1, false, Color.green
function u2mm:parseValueFromString(optionValue)
    local function trim(s)
        return s:match("^%s*(.-)%s*$")
    end

	optionValue = trim(optionValue)  
	local number = tonumber(optionValue)
	if number then
		return number
	elseif optionValue == "true" then
		return true
	elseif optionValue == "false" then
		return false
	else
		if u2mm:startsWith(optionValue, "Color(") then
			optionValue = u2mm:parseColorString(optionValue)
		end
		local var = loadstring("return " .. optionValue)
		return var()
	end
end

-- here we pass an actual lua table and get a string'ified representation of it
function u2mm:turnTableIntoString(data)
    if type(data) ~= "table" then
        return tostring(data) -- return tostring of v
    end
    
    if u2mm:tableLength(data) == 0 then
		log("turnTableIntoString returned {}")
        return "{}"
    end
    
    local value = "{"
    for k, v in pairs(data) do
        value = value .. tostring(k) .. "=" .. u2mm:turnTableIntoString(v) .. ","
    end
    
    return value:sub(1, -2) .. "}"
end