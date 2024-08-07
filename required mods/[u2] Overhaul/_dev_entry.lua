if (_G.u2_core.debug.dev_features == true) then
	if (RequiredScript == "lib/entry") then
		--log("dev entry")
		
	end
end 

-- tested features, ready to be made into their own modules / moved from here
if (RequiredScript == "lib/entry") then

	-- unlock all guns except saw
	function BlackMarketManager:_setup_weapons()
		local function check(weapon)
			if weapon == 'saw' then
				if managers.player:has_category_upgrade( "saw", "portable_saw" ) then
					return true
				else
					return false
				end
			else
				return true
			end
		end
		
		local weapons = {}
		Global.blackmarket_manager.weapons = weapons
		for weapon,data in pairs( tweak_data.weapon ) do
			if data.autohit then
				local selection_index = data.use_data.selection_index
				local factory_id = managers.weapon_factory:get_factory_id_by_weapon_id( weapon )
				weapons[ weapon ] = { owned = false, unlocked = check(weapon), factory_id = factory_id, selection_index = selection_index }
			end
		end
	end

	-- remove the blue filter from main menu
	local old_MenuSceneManager_setup_camera = MenuSceneManager.setup_camera
	function MenuSceneManager:setup_camera(...)
		old_MenuSceneManager_setup_camera(self, ...)
		local gradings = { 
			"color_off", 
			"color_payday", 
			"color_heat", 
			"color_nice", 
			"color_sin", 
			"color_bhd", 
			"color_xgen", 
			"color_xxxgen", 
			"color_matrix" 
		}
		managers.environment_controller:set_default_color_grading( "color_off" )
		managers.environment_controller:refresh_render_settings()
	end

	-- sweet and concise intro
	function BootupState:setup()
		local res = RenderSettings.resolution
		local safe_rect_pixels = managers.gui_data:scaled_size() -- managers.viewport:get_safe_rect_pixels()
		local gui = Overlay:gui()
		
		self._full_workspace = gui:create_screen_workspace()
		self._workspace = managers.gui_data:create_saferect_workspace() -- gui:create_screen_workspace()
		self._back_drop_gui = MenuBackdropGUI:new()
		self._back_drop_gui:hide()
		self._workspace:hide()
		self._full_workspace:hide()
		managers.gui_data:layout_workspace( self._workspace )
		
		self._play_data_list = {
			{ layer = 1, video = "movies/company_logo", width = res.x, height = res.y, padding = 200, can_skip = true }
		}
		
		self._full_panel = self._full_workspace:panel()
		self._panel = self._workspace:panel()
		
		self._controller_list = {}
		for index=1, managers.controller:get_wrapper_count() do
			local con = managers.controller:create_controller( "boot_" .. index, index, false )
			con:enable()
			self._controller_list[ index ] = con
		end
	end

	-- remove those buggy markers
	function MenuCallbackHandler:got_skillpoint_to_spend()
		return false
	end
	
	function MenuCallbackHandler:got_new_lootdrop()
		return false
	end

end