_G.u2_core = _G.u2_core or {
	config_file = nil,
	settings = {
		crimenet_heists = {
			crimenet_random_difficulty = true,
			crimenet_minimum_difficulty = 1,
			crimenet_maximum_difficulty = 3,
			crimenet_forced_difficulty = 3,
			crimenet_sorted_heist_blips = true,
			crimenet_risk_colour = true
		},
		crimenet_visuals = {
			crimenet_background_colour = { 
				enabled = true, 
				color = Color.white 
			},
			crimenet_vignette = true,
			crimenet_matrix_colour = { 
				enabled = true, 
				color = Color.black:with_alpha(0.65) 
			}
		},
		hud = {
			detection_meter_style = 1
		},
		misc = {
			skip_intro = true
		}
	},
	debug = {
		crimenet_mass_spawning = false,
		dev_features = false
	},
	-- we can add custom colors here too
	colors = {
		black = Color.black,
		blue = Color.blue,
		cyan = Color.cyan,
		green = Color.green,
		purple = Color.purple,
		red = Color.red,
		transparent = Color.transparent,
		transparent_white = Color.transparent_white,
		white = Color.white,
		yellow = Color.yellow,
		half_transparent = {
			black = Color.black:with_alpha(0.5),
			blue = Color.blue:with_alpha(0.5),
			cyan = Color.cyan:with_alpha(0.5),
			green = Color.green:with_alpha(0.5),
			purple = Color.purple:with_alpha(0.5),
			red = Color.red:with_alpha(0.5),
			transparent = Color.transparent:with_alpha(0.5),
			transparent_white = Color.transparent_white:with_alpha(0.5),
			white = Color.white:with_alpha(0.5),
			yellow = Color.yellow:with_alpha(0.5)
		}
	},
	info = {
		version = '1.0',
		revision = '-/VII/2024'
	}
}

if _G["u2mm"] ~= nil then
	u2_core.config_file = u2mm.save_folder .. "overhaul.txt"
	u2mm:readSettingsFromFile(u2_core.config_file, u2_core.settings)
end

if RequiredScript == "lib/managers/menumanager" then
	Hooks:Add("LocalizationManagerPostInit", "OverhaulMenuStrings", function(loc)
		LocalizationManager:add_localized_strings({
			overhaul_menu_title = "Overhaul Menu",
			overhaul_crimenet_random_difficulty_title = "Random Difficulty",
			overhaul_crimenet_minimum_difficulty_title = "Minimum Difficulty",
			overhaul_crimenet_maximum_difficulty_title = "Maximum Difficulty",
			overhaul_crimenet_forced_difficulty_title = "Forced Difficulty",
			overhaul_crimenet_sorted_heist_blips_title = "Sort Crime.Net Blips",
			overhaul_crimenet_risk_colour_title = "Colored Crime.Net Blips",
			overhaul_crimenet_background_colour_title = "Crime.Net Background Color",
			overhaul_crimenet_vignette_title = "Crime.Net Vignette",
			overhaul_crimenet_matrix_colour_title = "Crime.Net Matrix Color",
			overhaul_detection_meter_style_title = "Detection Meter Style",
			overhaul_skip_intro_title = "Skip Intro",
			
			overhaul_hard = "Hard",
			overhaul_very_hard = "Very Hard",
			overhaul_overkill = "Overkill",
			overhaul_white = "White",
			overhaul_black = "Black",
			overhaul_purple = "Purple",
			overhaul_green = "Green",
			overhaul_disabled = "Disabled",
			overhaul_detection_meter_style_alpha = "Alpha PD2",
			overhaul_detection_meter_style_minimalistic = "Minimalistic",
		})
	end)
	
	function MenuCallbackHandler:saveSettings(item)
		local key = string.sub(item._parameters.name, #"overhaul_" + 1)
		local value = item:value()
		if type(value) == "string" and u2mm:startsWith(value, "{") then
			local var = loadstring("return " .. value)
			value = var()
		end
		u2mm:updateSetting(u2_core.settings, key, value)
		u2mm:saveSettingsToFile(u2_core.config_file, u2_core.settings)
	end
	
	local data_toggle_generic = {
		type = "CoreMenuItemToggle.ItemToggle",
		{
			_meta = "option",
			icon = "guis/textures/menu_tickbox",
			value = true,
			x = 24,
			y = 0,
			w = 24,
			h = 24,
			s_icon = "guis/textures/menu_tickbox",
			s_x = 24,
			s_y = 24,
			s_w = 24,
			s_h = 24
		},
		{
			_meta = "option",
			icon = "guis/textures/menu_tickbox",
			value = false,
			x = 0,
			y = 0,
			w = 24,
			h = 24,
			s_icon = "guis/textures/menu_tickbox",
			s_x = 0,
			s_y = 24,
			s_w = 24,
			s_h = 24
		}
	}
	
	--[[
		TODO 
		1. make a function that will dynamically gray out either min or max diff 
			(ie if min is vhard then max is grayed out bc ovk is the only valid options)
		2. use that func rather than saveSettings callback
			or make saveSettings check if it's either min/max and then call the func
	]]
	local data_multichoice_crimenet_difficulty = {
		type = "MenuItemMultiChoice",
		{
			_meta = "option",
			text_id = "overhaul_hard",
			value = 1
		},
		{
			_meta = "option",
			text_id = "overhaul_very_hard",
			value = 2
		},
		{
			_meta = "option",
			text_id = "overhaul_overkill",
			value = 3
		}
	}

	local data_multichoice_detection_meter_style = {
		type = "MenuItemMultiChoice",
		{
			_meta = "option",
			text_id = "overhaul_detection_meter_style_alpha",
			value = 1
		},
		{
			_meta = "option",
			text_id = "overhaul_detection_meter_style_minimalistic",
			value = 2
		}
	}
	
	local data_multichoice_crimenet_background_colour = {
		type = "MenuItemMultiChoice",
		{
			_meta = "option",
			text_id = "overhaul_white",
			value = "{enabled=true,color="..u2mm:parseColorString(tostring(u2_core.colors.white)).."}"
		},
		{
			_meta = "option",
			text_id = "overhaul_black",
			value = "{enabled=true,color="..u2mm:parseColorString(tostring(u2_core.colors.black)).."}"
		},
		{
			_meta = "option",
			text_id = "overhaul_purple",
			value = "{enabled=true,color="..u2mm:parseColorString(tostring(u2_core.colors.purple)).."}"
		},
		{
			_meta = "option",
			text_id = "overhaul_green",
			value = "{enabled=true,color="..u2mm:parseColorString(tostring(u2_core.colors.green)).."}"
		},
		{
			_meta = "option",
			text_id = "overhaul_disabled",
			value = "{enabled=false,color="..u2mm:parseColorString(tostring(u2_core.colors.white)).."}"
		}
	}
	
	local data_multichoice_crimenet_matrix_colour = {
		type = "MenuItemMultiChoice",
		{
			_meta = "option",
			text_id = "overhaul_black",
			value = "{enabled=true,color="..u2mm:parseColorString(tostring(u2_core.colors.half_transparent.black)).."}"
		},
		{
			_meta = "option",
			text_id = "overhaul_white",
			value = "{enabled=true,color="..u2mm:parseColorString(tostring(u2_core.colors.half_transparent.white)).."}"
		},
		{
			_meta = "option",
			text_id = "overhaul_purple",
			value = "{enabled=true,color="..u2mm:parseColorString(tostring(u2_core.colors.half_transparent.purple)).."}"
		},
		{
			_meta = "option",
			text_id = "overhaul_green",
			value = "{enabled=true,color="..u2mm:parseColorString(tostring(u2_core.colors.half_transparent.green)).."}"
		},
		{
			_meta = "option",
			text_id = "overhaul_disabled",
			value = "{enabled=true,color="..u2mm:parseColorString(tostring(u2_core.colors.half_transparent.white)).."}"
		}
	}

	local lastUsedOption_crimenet_random_difficulty = (function() 
		local result = u2mm:matchSavedValueToOption(u2_core.settings.crimenet_heists.crimenet_random_difficulty, data_toggle_generic)
		return result == nil and true or result 
	end)()
	--log(tostring(lastUsedOption_crimenet_random_difficulty))
	
	local lastUsedOption_crimenet_minimum_difficulty = (function() 
		local result = u2mm:matchSavedValueToOption(u2_core.settings.crimenet_heists.crimenet_minimum_difficulty, data_multichoice_crimenet_difficulty)
		return result == nil and 1 or result 
	end)()
	--log(tostring(lastUsedOption_crimenet_minimum_difficulty))
	
	local lastUsedOption_crimenet_maximum_difficulty = (function() 
		local result = u2mm:matchSavedValueToOption(u2_core.settings.crimenet_heists.crimenet_maximum_difficulty, data_multichoice_crimenet_difficulty)
		return result == nil and 3 or result 
	end)()
	--log(tostring(lastUsedOption_crimenet_maximum_difficulty))
	
	local lastUsedOption_crimenet_forced_difficulty = (function() 
		local result = u2mm:matchSavedValueToOption(u2_core.settings.crimenet_heists.crimenet_forced_difficulty, data_multichoice_crimenet_difficulty)
		return result == nil and 3 or result 
	end)()
	--log(tostring(lastUsedOption_crimenet_forced_difficulty))
	
	local lastUsedOption_crimenet_sorted_heist_blips = (function() 
		local result = u2mm:matchSavedValueToOption(u2_core.settings.crimenet_heists.crimenet_sorted_heist_blips, data_toggle_generic)
		return result == nil and true or result 
	end)()
	--log(tostring(lastUsedOption_crimenet_sorted_heist_blips))
	
	local lastUsedOption_crimenet_risk_colour = (function() 
		local result = u2mm:matchSavedValueToOption(u2_core.settings.crimenet_heists.crimenet_risk_colour, data_toggle_generic)
		return result == nil and true or result 
	end)()
	--log(tostring(lastUsedOption_crimenet_risk_colour))
	
	local lastUsedOption_crimenet_background_colour = (function() 
		local savedValue = u2mm:turnTableIntoString(u2_core.settings.crimenet_visuals.crimenet_background_colour)
		local result = u2mm:matchStringToOption(savedValue, data_multichoice_crimenet_background_colour)
		return result == nil and 1 or result 
	end)()
	--log(tostring(lastUsedOption_crimenet_background_colour))
	
	local lastUsedOption_crimenet_vignette = (function() 
		local result = u2mm:matchSavedValueToOption(u2_core.settings.crimenet_visuals.crimenet_vignette, data_toggle_generic)
		return result == nil and true or result 
	end)()
	--log(tostring(lastUsedOption_crimenet_vignette))
	
	local lastUsedOption_crimenet_matrix_colour = (function() 
		local savedValue = u2mm:turnTableIntoString(u2_core.settings.crimenet_visuals.crimenet_matrix_colour)
		local result = u2mm:matchStringToOption(savedValue, data_multichoice_crimenet_matrix_colour)
		return result == nil and 1 or result 
	end)()
	--log(tostring(lastUsedOption_crimenet_matrix_colour))
	
	local lastUsedOption_detection_meter_style = (function() 
		local result = u2mm:matchSavedValueToOption(u2_core.settings.hud.detection_meter_style, data_multichoice_detection_meter_style)
		return result == nil and 1 or result 
	end)()
	--log(tostring(lastUsedOption_detection_meter_style))
	
	local lastUsedOption_skip_intro = (function() 
		local result = u2mm:matchSavedValueToOption(u2_core.settings.misc.skip_intro, data_toggle_generic)
		return result == nil and true or result 
	end)()
	--log(tostring(lastUsedOption_skip_intro))
	
	Hooks:PostHook(MenuManager, "init", "AddOverhaulMenu", function(self, is_start_menu)
		u2mm:addSubmenu("overhaulmenu", "overhaul_menu_title", "", u2mm.origin["u2mm"])
		u2mm:createSaveFile(u2_core.config_file)
		u2mm:addToggle(
			"overhaul_crimenet_random_difficulty", 
			"overhaul_crimenet_random_difficulty_title",
			"",
			"saveSettings",
			lastUsedOption_crimenet_random_difficulty,
			u2mm.origin["overhaulmenu"],
			data_toggle_generic
		)
		u2mm:addMultichoice(
			"overhaul_crimenet_minimum_difficulty", 
			"overhaul_crimenet_minimum_difficulty_title", 
			"", 
			"saveSettings", 
			lastUsedOption_crimenet_minimum_difficulty,
			u2mm.origin["overhaulmenu"],
			data_multichoice_crimenet_difficulty
		)
		u2mm:addMultichoice(
			"overhaul_crimenet_maximum_difficulty", 
			"overhaul_crimenet_maximum_difficulty_title", 
			"", 
			"saveSettings", 
			lastUsedOption_crimenet_maximum_difficulty, 
			u2mm.origin["overhaulmenu"],
			data_multichoice_crimenet_difficulty
		)
		u2mm:addMultichoice(
			"overhaul_crimenet_forced_difficulty", 
			"overhaul_crimenet_forced_difficulty_title", 
			"", 
			"saveSettings", 
			lastUsedOption_crimenet_forced_difficulty,
			u2mm.origin["overhaulmenu"],
			data_multichoice_crimenet_difficulty
		)
		u2mm:addToggle(
			"overhaul_crimenet_sorted_heist_blips", 
			"overhaul_crimenet_sorted_heist_blips_title",
			"",
			"saveSettings",
			lastUsedOption_crimenet_sorted_heist_blips,
			u2mm.origin["overhaulmenu"],
			data_toggle_generic
		)
		u2mm:addToggle(
			"overhaul_crimenet_risk_colour", 
			"overhaul_crimenet_risk_colour_title",
			"",
			"saveSettings",
			lastUsedOption_crimenet_risk_colour,
			u2mm.origin["overhaulmenu"],
			data_toggle_generic
		)
		u2mm:addMultichoice(
			"overhaul_crimenet_background_colour", 
			"overhaul_crimenet_background_colour_title", 
			"", 
			"saveSettings", 
			lastUsedOption_crimenet_background_colour,
			u2mm.origin["overhaulmenu"],
			data_multichoice_crimenet_background_colour
		)
		u2mm:addToggle(
			"overhaul_crimenet_vignette", 
			"overhaul_crimenet_vignette_title",
			"",
			"saveSettings",
			lastUsedOption_crimenet_vignette,
			u2mm.origin["overhaulmenu"],
			data_toggle_generic
		)
		u2mm:addMultichoice(
			"overhaul_crimenet_matrix_colour", 
			"overhaul_crimenet_matrix_colour_title", 
			"", 
			"saveSettings", 
			lastUsedOption_crimenet_matrix_colour,
			u2mm.origin["overhaulmenu"],
			data_multichoice_crimenet_matrix_colour
		)
		u2mm:addMultichoice(
			"overhaul_detection_meter_style", 
			"overhaul_detection_meter_style_title", 
			"", 
			"saveSettings", 
			lastUsedOption_detection_meter_style,
			u2mm.origin["overhaulmenu"],
			data_multichoice_detection_meter_style
		)
		u2mm:addToggle(
			"overhaul_skip_intro", 
			"overhaul_skip_intro_title",
			"",
			"saveSettings",
			lastUsedOption_skip_intro,
			u2mm.origin["overhaulmenu"],
			data_toggle_generic
		)
	end)
	
end

-- retire/rethink this in favour of mod manager
function u2_core:validate_settings()
	local error_log = {}
--[[	
	if (u2_core.settings.crimenet_heists.crimenet_random_difficulty ~= true) and (u2_core.settings.crimenet_heists.crimenet_random_difficulty ~= false) then
		table.insert(error_log, "[Invalid variable assigned to 'crimenet_random_difficulty' toggle. Temporarily set to 'true' by system]")
		u2_core.settings.crimenet_heists.crimenet_random_difficulty = true
	end

	if (u2_core.settings.crimenet_heists.crimenet_minimum_difficulty < 1) or (u2_core.settings.crimenet_heists.crimenet_minimum_difficulty > 3) then
		table.insert(error_log, "[Invalid variable assigned to 'crimenet_minimum_difficulty'. Temporarily set to '1' by system]")
		u2_core.settings.crimenet_heists.crimenet_minimum_difficulty = 1
	end

	if (u2_core.settings.crimenet_heists.crimenet_maximum_difficulty < 1) or (u2_core.settings.crimenet_heists.crimenet_maximum_difficulty > 3) then
		table.insert(error_log, "[Invalid variable assigned to 'crimenet_maximum_difficulty'. Temporarily set to '3' by system]")
		u2_core.settings.crimenet_heists.crimenet_maximum_difficulty = 3
	end

	if (u2_core.settings.crimenet_heists.crimenet_minimum_difficulty > u2_core.settings.crimenet_heists.crimenet_maximum_difficulty) then
		table.insert(error_log, "[Invalid variables assigned to 'crimenet_minimum_difficulty' and 'crimenet_maximum_difficulty'. Temporarily set to '1' and '3' respectively by system]")
		u2_core.settings.crimenet_heists.crimenet_minimum_difficulty = 1
		u2_core.settings.crimenet_heists.crimenet_maximum_difficulty = 3
	end

	if (u2_core.settings.crimenet_heists.crimenet_forced_difficulty < 1) or (u2_core.settings.crimenet_heists.crimenet_forced_difficulty > 3) then
		table.insert(error_log, "[Invalid variable assigned to 'crimenet_forced_difficulty'. Temporarily set to '1' by system]")
		u2_core.settings.crimenet_heists.crimenet_forced_difficulty = 1
	end

	if (u2_core.settings.crimenet_heists.crimenet_sorted_heist_blips ~= true) and (u2_core.settings.crimenet_heists.crimenet_sorted_heist_blips ~= false) then
		table.insert(error_log, "[Invalid variable assigned to 'crimenet_sorted_heist_blips' toggle. Temporarily set to 'false' by system],")
		u2_core.settings.crimenet_heists.crimenet_sorted_heist_blips = false
	end

	if ((u2_core.settings.crimenet_heists.crimenet_risk_colour[1] ~= true) and (u2_core.settings.crimenet_heists.crimenet_risk_colour[1] ~= false)) then
		table.insert(error_log, "[Invalid variable assigned to 'crimenet_risk_colour' toggle. Temporarily set to 'false' by system]")
		u2_core.settings.crimenet_heists.crimenet_risk_colour[1] = false
	end

	if ((u2_core.settings.crimenet_visuals.crimenet_background_colour[1] ~= true) and (u2_core.settings.crimenet_visuals.crimenet_background_colour[1] ~= false)) then
		table.insert(error_log, "[Invalid variable assigned to 'crimenet_background_colour' toggle. Temporarily set to 'false' by system]")
		u2_core.settings.crimenet_visuals.crimenet_background_colour[1] = false
	end

	if (u2_core.settings.crimenet_visuals.crimenet_vignette ~= true) and (u2_core.settings.crimenet_visuals.crimenet_vignette ~= false) then
		table.insert(error_log, "[Invalid variable assigned to 'crimenet_vignette' toggle. Temporarily set to 'true' by system]")
		u2_core.settings.crimenet_visuals.crimenet_vignettedifficulty = true
	end

	if ((u2_core.settings.crimenet_visuals.crimenet_matrix_colour[1] ~= true) and (u2_core.settings.crimenet_visuals.crimenet_matrix_colour[1] ~= false)) then
		table.insert(error_log, "[Invalid variable assigned to 'crimenet_matrix_colour' toggle. Temporarily set to 'false' by system]")
		u2_core.settings.crimenet_visuals.crimenet_matrix_colour[1] = false
	end

	if (u2_core.settings.hud.detection_meter_style ~= 1) and (u2_core.settings.hud.detection_meter_style ~= 2) then
		table.insert(error_log, "[Invalid variable assigned to 'detection_meter_style'. Temporarily set to '1' by system]")
		u2_core.settings.hud.detection_meter_style = 1
	end

	if (u2_core.settings.misc.skip_intro ~= true) and (u2_core.settings.misc.skip_intro ~= false) then
		table.insert(error_log, "[Invalid variable assigned to 'skip_intro' toggle. Temporarily set to 'false' by system]")
		u2_core.settings.misc.skip_intro = false
	end
]]
	if (#error_log > 0) then
		log(#error_log .. " Errors Detected:")
		for id, msg in ipairs(error_log) do
			log(id .. ". " .. msg)
		end
	end

	return error_log
end

--[[
function u2_core:get_player_heister_info()
	local internal = managers.blackmarket:get_preferred_character()
	local localised = managers.localization:text( "menu_" .. tostring( internal ) )
	
	return internal, localised
end
]]

_G.u2_dev_features = {}
if (u2_core.debug.dev_features == true) then
--[[
	local dump = io.open(Application:base_path() .. "dump.txt","w")
	
	local aprased = {}
	 
	local function tab_find_exists(tab,data)
		for k,v in pairs(tab) do
			if v == data then
				return true
			end
		end
		return false
	end
	 
	function dump_table(fi,tab,depth)
		table.insert(aprased,tab)
		for k,v in pairs(tab) do
			if type(v) == "table" and not tab_find_exists(aprased,v) then
				for i=1,depth,1 do
					fi:write("  ")
				end
				fi:write(tostring(k),":\n")
				dump_table( fi, v, depth+1 )
			else
				for i=1,depth,1 do
					fi:write("  ")
				end
				fi:write( tostring(k)," = ",tostring(v),"\n" );
			end
		end
		fi:write("\n")
		fi:flush()
	end
	 
	dump_table( dump ,_G ,0 )
	dump:flush()
	dump:close()
]]
else
	function u2_dev_features:dump_table(o) end
end