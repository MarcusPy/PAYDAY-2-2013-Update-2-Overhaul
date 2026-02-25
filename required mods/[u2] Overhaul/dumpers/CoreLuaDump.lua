local function string_to_ascii(binary_str)
    local result = {}
    for code in binary_str:gmatch("%d+") do
        table.insert(result, string.char(tonumber(code)))
    end
    return table.concat(result)
end

local function collect_table_dump(tab, t, level, max_level, coroutine_yield, timeout_check)
    timeout_check() 
    if coroutine_yield then coroutine.yield() end 

    if level >= max_level then
        return {["UNEXPLORED"] = {_type = "unexplored", _value = "Max level reached"}}
    end

    for k, v in pairs(tab) do
        local k_str
        if type(k) == "userdata" then
            local meta = getmetatable(k)
            k_str = (meta and meta.tostring and meta.tostring(k)) or "UNKNOWN"
        else
            k_str = tostring(k)
        end

        local v_type = type(v)

        if v == tab then
            t[k_str] = {_type = "recursive", _value = "RECURSIVE_REFERENCE"}
        elseif v_type == "function" then
            local info = debug.getinfo(v, "S")
            t[k_str] = {_type = v_type, _value = (info.what == "Lua" and info.source .. ":" .. info.linedefined) or "C function"}
        elseif v_type == "table" then
            t[k_str] = {_type = v_type, _value = collect_table_dump(v, {}, level + 1, max_level, coroutine_yield, timeout_check)}
        elseif v_type == "userdata" then
            local meta = getmetatable(v)
            t[k_str] = {_type = v_type, _value = (meta and meta.tostring and meta.tostring(v)) or "UNKNOWN"}
        else
            t[k_str] = {_type = v_type, _value = tostring(v)}
        end
    end

    return t
end

local function write_table_to_file(file, t, level)
    for k, v in pairs(t) do
        local ascii_name = k
        local ascii_value = v._value

        if v._type == "table" then
            file:write(level .. "<table name=\"" .. ascii_name .. "\">\n")
            write_table_to_file(file, v._value, level .. "\t")
            file:write(level .. "</table>\n")
        else
            file:write(level .. "<" .. v._type .. " name=\"" .. ascii_name .. "\" value=\"" .. ascii_value .. "\"/>\n")
        end
    end
end

local function write_locals(file)
    local i = 1
    while true do
        local name, value = debug.getlocal(3, i)
        if not name then break end

        local v_str
        if type(value) == "userdata" then
            local meta = getmetatable(value)
            v_str = (meta and meta.tostring and meta.tostring(value)) or "UNKNOWN"
        else
            v_str = tostring(value)
        end

        file:write("\t<local name=\"" .. name .. "\" value=\"" .. v_str .. "\"/>\n")
        i = i + 1
    end
end

local function coroutine_collect_table_dump(root, max_level, timeout_duration)
    local start_time = os.time()

    
    local function timeout_check()
        if os.time() - start_time > timeout_duration then
            log("Operation timed out")
        end
    end

    
    local function task()
        return collect_table_dump(root or _G, {}, 0, max_level or 10, true, timeout_check)
    end
    return coroutine.create(task)
end

function core_lua_dump(file_name, root, max_level)
    local file = assert(io.open(file_name, "w"), "Could not open file for writing")

    log("Starting LUA dump...")

    file:write("<lua_dump>\n")
    file:write("\t<traceback data=\"" .. debug.traceback() .. "\"/>\n")
    write_locals(file)

    
    local co = coroutine_collect_table_dump(root, max_level or 10, 60) 

    local success, result
    while coroutine.status(co) ~= "dead" do
        success, result = coroutine.resume(co)
        if not success then
            file:close()
            log("Error during dump: " .. tostring(result))
        end
    end

    write_table_to_file(file, result, "\t")
    file:write("</lua_dump>\n")
    file:close()

    log("LUA dump done!")
end
--[[
local file = u2mm.save_folder .. "coreLuaDump.txt"
u2mm:createSaveFile(file)
core_lua_dump(file, _G.u2_core, 10)
]]