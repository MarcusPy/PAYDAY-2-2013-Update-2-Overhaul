-- we need this to fix OVERKILL's error with how Color works
-- if we use Color.white for instance, it later gets converted to Color(1 * (1, 1, 1))
-- that is a problem because when we try to loadstring(Color(1 * (1, 1, 1))) it goes nil
-- due to it being in incorrect format, so we need to fix it by converting it to this
-- Color(1.000000, 1.000000, 1.000000, 1.000000)
function u2mm:parseColorString(input)
    -- Function to trim whitespace from both ends of a string
    local function trim(s)
        return s:match("^%s*(.-)%s*$")
    end

    -- Function to evaluate multiplication within parentheses
    local function evalExpression(expr)
        expr = trim(expr)
        -- Find the multiplication factor and the tuple
        local factor, values = expr:match("^(%d*%.?%d+)%s*%*%s*%(([^)]+)%)$")
        if factor and values then
            factor = tonumber(factor)
            -- Split the tuple values
            local r, g, b = values:match("(%d*%.?%d+)%s*,%s*(%d*%.?%d+)%s*,%s*(%d*%.?%d+)")
            if r and g and b then
                return string.format("Color(%f, %f, %f, %f)", factor, tonumber(r), tonumber(g), tonumber(b))
            else
                log("Invalid tuple format: " .. values)
            end
        else
            log("Invalid expression format: " .. expr)
        end
    end

    -- Main parsing
    local function parse(input)
        input = trim(input)
        -- Match the main Color function call
        local func, expr = input:match("^(%w+)%s*%(%s*(.+)%s*%)$")
        if func == "Color" and expr then
            return evalExpression(expr)
        else
            log("Invalid input format: " .. input)
        end
    end

    return parse(input)
end

function u2mm:startsWith(str, start)
	return str:sub(1, #start) == start
end

-- not infallible but probably good enough for just checking
function u2mm:isObject(value)
    if type(value) == "table" then
        local mt = getmetatable(value)
        if mt and type(mt) == "table" then
            return true
        end
    end
    return false
end

function u2mm:tablesEqual(t1, t2)
	if t1 == t2 then return true end
	if type(t1) ~= "table" or type(t2) ~= "table" then return false end
	for k, v in pairs(t1) do
		if t2[k] ~= v then return false end
	end
	for k, v in pairs(t2) do
		if t1[k] ~= v then return false end
	end
	return true
end

function u2mm:tableLength(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
	
    return count
end