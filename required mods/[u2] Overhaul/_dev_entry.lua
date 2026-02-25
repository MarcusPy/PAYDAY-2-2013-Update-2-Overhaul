if _G.u2_core.debug.dev_features then
	-- turn this into a framework or add to u2mm
	_G.keybind_test = _G.keybind_test or {}
	
	function toggleGodMode()
		if managers.player:player_unit() then
			if Global.god_mode then
				Global.god_mode = false
				managers.player:player_unit():character_damage():set_god_mode(Global.god_mode)
				managers.chat:_receive_message(1, "[debug]", "GodMode is OFF", tweak_data.screen_colors.risk)
				return
			end
			Global.god_mode = true
			managers.player:player_unit():character_damage():set_god_mode(Global.god_mode)
			managers.chat:_receive_message(1, "[debug]", "GodMode is ON", tweak_data.screen_colors.risk)
		end
	end
	
	local keyboard = Input:keyboard()
	if keyboard and keyboard:has_button(Idstring("f8")) then
		_G.keybind_test = Input:create_virtual_controller()
		_G.keybind_test:connect(keyboard, Idstring("f8"), Idstring("btn_toggle"))
		_G.keybind_test:add_trigger(Idstring("btn_toggle"), toggleGodMode)
	end
end

-- tested features, ready to be made into their own modules / moved from here
if RequiredScript == "lib/entry" then

	for dlc_name, dlc_data in pairs( Global.dlc_manager.all_dlc_data ) do
		--log(dlc_name)
		dlc_name = { app_id = "218620", no_install = true }
		dlc_data.verified = true
		if dlc_name == "career_criminal_edition" then 
			dlc_name = { app_id = "-1", no_install = true, verified = false }
			dlc_data.verified = false
		end
	end
	
end