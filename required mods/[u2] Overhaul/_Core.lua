_G.u2_core = _G.u2_core or {
	config_file = nil,
	settings = {
		crimenet_heists = {
			crimenet_random_difficulty = true,
			crimenet_minimum_difficulty = 1,
			crimenet_maximum_difficulty = 3,
			crimenet_forced_difficulty = 3,
			crimenet_sorted_heist_blips = true,
			crimenet_risk_color = true
		},
		crimenet_visuals = {
			crimenet_background_color = { 
				enabled = true, 
				color = Color.white 
			},
			crimenet_vignette = true,
			crimenet_matrix_color = { 
				enabled = true, 
				color = Color.black:with_alpha(0.65) 
			}
		},
		gameplay = {
			ammo_pickup_changes = true,
			lose_remaining_clip_ammo = true,
			no_waypoints = false,
			no_bag_tilt = false,
			no_headbob = false,
			no_weapon_sway = false
		},
		hud = {
			detection_meter_style = 1
		},
		misc = {
			skip_intro = false,
			remove_meth_blur = false,
			cheats_settings_menu = false
		}
	},
	debug = {
		debug_menu = false,
		crimenet_mass_spawning = false,
		string_id_reveal = false,
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
		version = '1.1',
		revision = '30/IX/2024'
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
			overhaul_help_popup_title = "Help",
			overhaul_crimenet_random_difficulty_title = "Random Difficulty",
			overhaul_crimenet_minimum_difficulty_title = "Minimum Difficulty",
			overhaul_crimenet_maximum_difficulty_title = "Maximum Difficulty",
			overhaul_crimenet_forced_difficulty_title = "Forced Difficulty",
			overhaul_crimenet_sorted_heist_blips_title = "Sort Crime.Net Blips",
			overhaul_crimenet_risk_color_title = "Colored Crime.Net Blips",
			overhaul_crimenet_background_color_title = "Crime.Net Background Color",
			overhaul_crimenet_vignette_title = "Crime.Net Vignette",
			overhaul_crimenet_matrix_color_title = "Crime.Net Matrix Color",
			overhaul_ammo_pickup_changes_title = "Custom Ammo Drops Mechanic",
			overhaul_lose_remaining_clip_ammo_title = "Lose Remaining Ammo",
			overhaul_no_waypoints_title = "Disable Waypoints",
			overhaul_no_bag_tilt_title = "Disable Bag Carrying Tilt",
			overhaul_no_headbob_title = "Disable Headbobbing",
			overhaul_no_weapon_sway_title = "Disable Weapon Swaying",
			overhaul_detection_meter_style_title = "Detection Meter Style",
			overhaul_remove_meth_blur_title = "Remove Meth Lab Blur",
			overhaul_skip_intro_title = "Skip Intro",
			overhaul_cheats_settings_menu_title = "Show Cheats Menu",
			
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
	
	function MenuCallbackHandler:helpPopup()
		local dialog_data = {
			title = "Setting Descriptions:",
			text = [[Random Difficulty - Heists in Crime.Net can have any difficulty. Fine-tuned by Minimum/Maximum Difficulty setting.

Forced Difficulty - If Random Difficulty is off, allows only the designated difficulty to appear.

Sort Crime.Net Blips - Sort and arrange heist blips by difficulty.

Crime.Net Background Color - Visual only, self-explanatory.

Crime.Net Vignette - Visual only, self-explanatory.

Crime.Net Matrix Color - Visual only, self-explanatory.

Lose Remaining Ammo - Drop all remaining ammo you have left in the magazine while reloading. Makes the game more difficult.

Disable Waypoints - Hides all waypoints. Makes the game more difficult.

Disable Bag Carrying Tilt - Makes the camera remain straight while carrying bags.

Disable Headbobbing - Makes the camera fixed in place during movement.

Disable Weapon Swaying - Disables breathing effect during ADS.

Detection Meter Style - Choose between percentage only and full one.

Remove Meth Lab Blur - Improves air conditioning in Rats Day 1.

Skip Intro - bruh.

Show Cheats Menu - Enables a simple, WIP cheat menu. Requires a reload. Use with caution, actions can't be undone.]],
			button_list = {{
				text = "OK                           "
			}}
		}
		managers.system_menu:show( dialog_data )
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
	
	local data_multichoice_crimenet_background_color = {
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
	
	local data_multichoice_crimenet_matrix_color = {
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
	
	local lastUsedOption_crimenet_risk_color = (function() 
		local result = u2mm:matchSavedValueToOption(u2_core.settings.crimenet_heists.crimenet_risk_color, data_toggle_generic)
		return result == nil and true or result 
	end)()
	--log(tostring(lastUsedOption_crimenet_risk_color))
	
	local lastUsedOption_crimenet_background_color = (function() 
		local savedValue = u2mm:turnTableIntoString(u2_core.settings.crimenet_visuals.crimenet_background_color)
		local result = u2mm:matchStringToOption(savedValue, data_multichoice_crimenet_background_color)
		return result == nil and 1 or result 
	end)()
	--log(tostring(lastUsedOption_crimenet_background_color))
	
	local lastUsedOption_crimenet_vignette = (function() 
		local result = u2mm:matchSavedValueToOption(u2_core.settings.crimenet_visuals.crimenet_vignette, data_toggle_generic)
		return result == nil and true or result 
	end)()
	--log(tostring(lastUsedOption_crimenet_vignette))
	
	local lastUsedOption_crimenet_matrix_color = (function() 
		local savedValue = u2mm:turnTableIntoString(u2_core.settings.crimenet_visuals.crimenet_matrix_color)
		local result = u2mm:matchStringToOption(savedValue, data_multichoice_crimenet_matrix_color)
		return result == nil and 1 or result 
	end)()
	--log(tostring(lastUsedOption_crimenet_matrix_color))
	
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
	
	local lastUsedOption_ammo_pickup_changes = (function() 
		local result = u2mm:matchSavedValueToOption(u2_core.settings.gameplay.ammo_pickup_changes, data_toggle_generic)
		return result == nil and true or result 
	end)()
	--log(tostring(lastUsedOption_ammo_pickup_changes))

	local lastUsedOption_lose_remaining_clip_ammo = (function() 
		local result = u2mm:matchSavedValueToOption(u2_core.settings.gameplay.lose_remaining_clip_ammo, data_toggle_generic)
		return result == nil and true or result 
	end)()
	--log(tostring(lastUsedOption_lose_remaining_clip_ammo))

	local lastUsedOption_no_waypoints = (function() 
		local result = u2mm:matchSavedValueToOption(u2_core.settings.gameplay.no_waypoints, data_toggle_generic)
		return result == nil and true or result 
	end)()
	--log(tostring(lastUsedOption_no_waypoints))
	
	local lastUsedOption_no_bag_tilt = (function() 
		local result = u2mm:matchSavedValueToOption(u2_core.settings.gameplay.no_bag_tilt, data_toggle_generic)
		return result == nil and true or result 
	end)()
	--log(tostring(lastUsedOption_no_bag_tilt))

	local lastUsedOption_no_headbob = (function() 
		local result = u2mm:matchSavedValueToOption(u2_core.settings.gameplay.no_headbob, data_toggle_generic)
		return result == nil and true or result 
	end)()
	--log(tostring(lastUsedOption_no_headbob))

	local lastUsedOption_no_weapon_sway = (function() 
		local result = u2mm:matchSavedValueToOption(u2_core.settings.gameplay.no_weapon_sway, data_toggle_generic)
		return result == nil and true or result 
	end)()
	--log(tostring(lastUsedOption_no_weapon_sway))
	
	local lastUsedOption_cheats_settings_menu = (function() 
		local result = u2mm:matchSavedValueToOption(u2_core.settings.misc.cheats_settings_menu, data_toggle_generic)
		return result == nil and true or result 
	end)()
	--log(tostring(lastUsedOption_cheats_settings_menu))
	
	local lastUsedOption_remove_meth_blur = (function() 
		local result = u2mm:matchSavedValueToOption(u2_core.settings.misc.remove_meth_blur, data_toggle_generic)
		return result == nil and true or result 
	end)()
	--log(tostring(lastUsedOption_remove_meth_blur))

	Hooks:PostHook(MenuManager, "init", "AddOverhaulMenu", function(self, is_start_menu)
		u2mm:addSubmenu("overhaulmenu", "overhaul_menu_title", "", u2mm.origin["u2mm"])
		u2mm:createSaveFile(u2_core.config_file)
		u2mm:addButton("helpOverhaulSettings", "overhaul_help_popup_title", "", "helpPopup", u2mm.origin["overhaulmenu"])
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
			"overhaul_crimenet_risk_color", 
			"overhaul_crimenet_risk_color_title",
			"",
			"saveSettings",
			lastUsedOption_crimenet_risk_color,
			u2mm.origin["overhaulmenu"],
			data_toggle_generic
		)
		u2mm:addMultichoice(
			"overhaul_crimenet_background_color", 
			"overhaul_crimenet_background_color_title", 
			"", 
			"saveSettings", 
			lastUsedOption_crimenet_background_color,
			u2mm.origin["overhaulmenu"],
			data_multichoice_crimenet_background_color
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
			"overhaul_crimenet_matrix_color", 
			"overhaul_crimenet_matrix_color_title", 
			"", 
			"saveSettings", 
			lastUsedOption_crimenet_matrix_color,
			u2mm.origin["overhaulmenu"],
			data_multichoice_crimenet_matrix_color
		)
		u2mm:addToggle(
			"overhaul_ammo_pickup_changes", 
			"overhaul_ammo_pickup_changes_title",
			"",
			"saveSettings",
			lastUsedOption_ammo_pickup_changes,
			u2mm.origin["overhaulmenu"],
			data_toggle_generic
		)
		u2mm:addToggle(
			"overhaul_lose_remaining_clip_ammo", 
			"overhaul_lose_remaining_clip_ammo_title",
			"",
			"saveSettings",
			lastUsedOption_lose_remaining_clip_ammo,
			u2mm.origin["overhaulmenu"],
			data_toggle_generic
		)
		u2mm:addToggle(
			"overhaul_no_waypoints", 
			"overhaul_no_waypoints_title",
			"",
			"saveSettings",
			lastUsedOption_no_waypoints,
			u2mm.origin["overhaulmenu"],
			data_toggle_generic
		)
		u2mm:addToggle(
			"overhaul_no_bag_tilt", 
			"overhaul_no_bag_tilt_title",
			"",
			"saveSettings",
			lastUsedOption_no_bag_tilt,
			u2mm.origin["overhaulmenu"],
			data_toggle_generic
		)
		u2mm:addToggle(
			"overhaul_no_headbob", 
			"overhaul_no_headbob_title",
			"",
			"saveSettings",
			lastUsedOption_no_headbob,
			u2mm.origin["overhaulmenu"],
			data_toggle_generic
		)
		u2mm:addToggle(
			"overhaul_no_weapon_sway", 
			"overhaul_no_weapon_sway_title",
			"",
			"saveSettings",
			lastUsedOption_no_weapon_sway,
			u2mm.origin["overhaulmenu"],
			data_toggle_generic
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
			"overhaul_remove_meth_blur", 
			"overhaul_remove_meth_blur_title",
			"",
			"saveSettings",
			lastUsedOption_remove_meth_blur,
			u2mm.origin["overhaulmenu"],
			data_toggle_generic
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
		u2mm:addToggle(
			"overhaul_cheats_settings_menu", 
			"overhaul_cheats_settings_menu_title",
			"",
			"saveSettings",
			lastUsedOption_cheats_settings_menu,
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
	--and so on
]]
	if (#error_log > 0) then
		log(#error_log .. " Errors Detected:")
		for id, msg in ipairs(error_log) do
			log(id .. ". " .. msg)
		end
	end

	return error_log
end

if u2_core.settings.misc.cheats_settings_menu then
	dofile(Application:base_path() .. "/mods/[u2] Overhaul/Cheats_Settings_Menu.lua")
	if _G["u2_cheats"] ~= nil and RequiredScript == "lib/managers/menumanager" then
		function MenuCallbackHandler:addMaskItems_clbk()
			local types = { "masks", "materials", "textures", "colors" }
			for _, item_type in pairs( types ) do
				_G.u2_cheats.unlock_items_category( item_type )
			end
		end

		function MenuCallbackHandler:addAllItems_clbk()
			_G.u2_cheats.unlock_all_items()
		end

		Hooks:PostHook(MenuManager, "init", "AddCheatsMenu", function(self, is_start_menu)
			u2mm:addSubmenu("cheatsmenu", "cheats_menu_title", "", u2mm.origin["u2mm"])
			u2mm:addButton("addMaskItems", "addMaskItems_title", "", "addMaskItems_clbk", u2mm.origin["cheatsmenu"])
			u2mm:addButton("addAllItems", "addAllItems_title", "", "addAllItems_clbk", u2mm.origin["cheatsmenu"])
		end)
	end
end

if u2_core.debug.dev_features then

    dofile(Application:base_path() .. "/mods/[u2] Overhaul/dumpers/simpleDumper.lua")
	dofile(Application:base_path() .. "/mods/[u2] Overhaul/dumpers/CoreLuaDump.lua")

end