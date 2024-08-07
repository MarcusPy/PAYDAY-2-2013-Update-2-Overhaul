_G.uwf = _G.uwf or {
	settings = {
		-- default values
		aspect_ratio = {
			modWidth = 16,
			modHeight = 9
		}
	},
	config_file = nil
}

if _G["u2mm"] ~= nil then
	uwf.config_file = u2mm.save_folder .. "ultrawideFix.txt"
	u2mm:readSettingsFromFile(uwf.config_file, uwf.settings)
end

if RequiredScript == "lib/managers/menumanager" then
	Hooks:Add("LocalizationManagerPostInit", "ultrawideMenuStrings", function(loc)
		LocalizationManager:add_localized_strings({
			ultrawide_menu_title = "Ultrawide Fix Menu",
			ultrawide_menu_desc = "Ultrawide Fix Mod Settings Page",
			ultrawide_aspect_ratio_title = "Aspect Ratio",
			ultrawide_aspect_ratio_desc = "Your Aspect Ratio",
			ultrawide_aspect_ratio_4by3 = "4:3 [untested]",
			ultrawide_aspect_ratio_5by4 = "5:4 [untested]",
			ultrawide_aspect_ratio_16by9 = "16:9",
			ultrawide_aspect_ratio_16by10 = "16:10 [untested]",
			ultrawide_aspect_ratio_21by9 = "21:9 [untested]",
			ultrawide_aspect_ratio_32by9 = "32:9",
			ultrawide_help_button_title = "How to use",
		})
	end)
	
	function MenuCallbackHandler:saveSettings_uwf(item)
		local key = string.sub(item._parameters.name, #"ultrawide_" + 1)
		local value = item:value()
		if type(value) == "string" and u2mm:startsWith(value, "{") then
			local var = loadstring("return " .. value)
			value = var()
		end
		u2mm:updateSetting(uwf.settings, key, value)
		u2mm:saveSettingsToFile(uwf.config_file, uwf.settings)
	end
	
	function MenuCallbackHandler:howToUsePopup()
		local dialog_data = {
			title = "Ultrawide Fix For Dummies",
			text = "1. Run the game in your desired resolution\n2. Select the corresponding aspect ratio\n3. Restart the game",
			button_list = {{
				text = "OK"
			}}
		}
		managers.system_menu:show( dialog_data )
	end
	
	local data = {
		type = "MenuItemMultiChoice",
		{
			_meta = "option",
			text_id = "ultrawide_aspect_ratio_4by3",
			value = "{modWidth=4,modHeight=3}"
		},
		{
			_meta = "option",
			text_id = "ultrawide_aspect_ratio_5by4",
			value = "{modWidth=5,modHeight=4}"
		},
		{
			_meta = "option",
			text_id = "ultrawide_aspect_ratio_16by9",
			value = "{modWidth=16,modHeight=9}"
		},
		{
			_meta = "option",
			text_id = "ultrawide_aspect_ratio_16by10",
			value = "{modWidth=16,modHeight=10}"
		},
		{
			_meta = "option",
			text_id = "ultrawide_aspect_ratio_21by9",
			value = "{modWidth=21,modHeight=9}"
		},
		{
			_meta = "option",
			text_id = "ultrawide_aspect_ratio_32by9",
			value = "{modWidth=32,modHeight=9}"
		}
	}
	
	--[[local lastUsedOption_aspect_ratio = (function() 
		local savedValue = u2mm:turnTableIntoString(uwf.settings.aspect_ratio)
		local result = u2mm:matchStringToOption(savedValue, data)
		return result == nil and 3 or result 
	end)()]]
	--log(tostring(lastUsedOption_aspect_ratio))
	--or
	local lastUsedOption_aspect_ratio = (function() 
		local result = u2mm:matchSavedValueToOption(uwf.settings.aspect_ratio, data)
		return result == nil and 3 or result 
	end)()
	--log(tostring(lastUsedOption_aspect_ratio))
	
	Hooks:PostHook(MenuManager, "init", "AddUltrawideFixMenu", function(self, is_start_menu)
		u2mm:addSubmenu("ultrawidefixmenu", "ultrawide_menu_title", "ultrawide_menu_desc", u2mm.origin["u2mm"])
		u2mm:addMultichoice(
			"ultrawide_aspect_ratio", 
			"ultrawide_aspect_ratio_title", 
			"ultrawide_aspect_ratio_desc", 
			"saveSettings_uwf", 
			lastUsedOption_aspect_ratio, 
			u2mm.origin["ultrawidefixmenu"],
			data
		)
		u2mm:addButton("howToUse", "ultrawide_help_button_title", "", "howToUsePopup", u2mm.origin["ultrawidefixmenu"])
		u2mm:createSaveFile(uwf.config_file)
	end)
end

if RequiredScript == "lib/managers/menu/menuscenemanager" then
	function MenuSceneManager:_set_dimensions()
		local aspect_ratio = self:_real_aspect_ratio()
		local y = (1-(aspect_ratio / (uwf.settings.aspect_ratio.modWidth/uwf.settings.aspect_ratio.modHeight)))/2
		local h = aspect_ratio / (uwf.settings.aspect_ratio.modWidth/uwf.settings.aspect_ratio.modHeight)
		self._vp._vp:set_dimensions( 0, y, 1, h )
	end

	function MenuSceneManager:setup_camera()
		if self._camera_values then
			return
		end
		
		local ref = self._bg_unit:get_object( Idstring( "a_camera_reference" ) )
		local target_pos = Vector3( 0, 0, ref:position().z )
		
		self._camera_values = {}
		self._camera_values.camera_pos_current = ref:position():rotate_with( Rotation( 90 ) )
		self._camera_values.camera_pos_target = self._camera_values.camera_pos_current
		self._camera_values.target_pos_current = target_pos
		self._camera_values.target_pos_target = self._camera_values.target_pos_current
		self._camera_values.fov_current = self._standard_fov
		self._camera_values.fov_target = self._camera_values.fov_current

		self._camera_object = World:create_camera()
		self._camera_object:set_near_range( 3 )
		self._camera_object:set_far_range( 250000 )
		self._camera_object:set_fov( 55 )
		self._camera_object:set_rotation( self._camera_start_rot )

		self._vp = managers.viewport:new_vp( 0, 0, 1, 1, "menu_main" )
		self._vp:set_width_mul_enabled()
		self._director = self._vp:director()
		self._shaker = self._director:shaker()
		self._camera_controller = self._director:make_camera( self._camera_object, Idstring("menu") )
		self._director:set_camera( self._camera_controller )
		self._director:position_as( self._camera_object )
		self._camera_controller:set_both( self._camera_object )
		self._camera_controller:set_target( self._camera_start_rot:y() * 100 + self._camera_start_rot:x() * 6 )
		self:_set_camera_position( self._camera_values.camera_pos_current )
		self:_set_target_position( self._camera_values.camera_pos_target )
		self._vp:set_camera( self._camera_object )managers.viewport:preload_environment( "environments/env_menu/env_menu" )
		
		managers.environment_area:set_default_environment( "environments/env_menu/env_menu" )
		
		self._vp:set_environment( managers.environment_area:default_environment() )
		
		self._vp:set_active( true )
		
		managers.environment_controller:refresh_render_settings()
		
		self._vp:camera():set_width_multiplier(CoreMath.width_mul( uwf.settings.aspect_ratio.modWidth/uwf.settings.aspect_ratio.modHeight ) )
		
		self:_set_dimensions()
		
		self._shaker:play( "breathing", 0.2 )
		
		self._resolution_changed_callback_id = managers.viewport:add_resolution_changed_func( callback( self, self, "_resolution_changed" ) )
		
		self._environment_modifier_id = managers.viewport:viewports()[1]:create_environment_modifier(false, function(interface) return self:_sky_rotation_modifier(interface) end, "sky_orientation")
	end
end

if RequiredScript == "core/lib/managers/viewport/coreviewportmanager" then
    core:module("CoreViewportManager")

    function ViewportManager:get_safe_rect()
        return {
            x = 3.2 * 0.01,
            y = 3.2 * 0.01,
            width = 1 - 3.2 * 0.01 * 2,
            height = 1 - 3.2 * 0.01 * 2
        }
    end
end

if RequiredScript == "core/lib/managers/coreguidatamanager" then
    if core then
        core:module("CoreGuiDataManager")
    end

    function GuiDataManager:get_base_res()
        return self._base_res.x, self._base_res.y
    end

    function GuiDataManager:scaled_size()
        local w = math.round(self:_get_safe_rect().width * self._base_res.x)
        local h = math.round(self:_get_safe_rect().height * self._base_res.y)

        return {
            x = 0,
            y = 0,
            width = w,
            height = h
        }
    end

    function GuiDataManager:_setup_workspace_data()
        local res = self._static_resolution or RenderSettings.resolution
        local aspect = res.x / res.y
        self._base_res = {
            x = 720 * aspect * 1,
            y = 720 * 1
        }

        self._saferect_data = {}
        self._corner_saferect_data = {}
        self._fullrect_data = {}
        local safe_rect = self:_get_safe_rect_pixels()
        local scaled_size = self:scaled_size()
        local res = self._static_resolution or RenderSettings.resolution
        local w = scaled_size.width
        local h = scaled_size.height
        local sh = math.min(safe_rect.height, safe_rect.width / (w / h))
        local sw = math.min(safe_rect.width, safe_rect.height * w / h)
        local x = res.x / 2 - sh * w / h / 2
        local y = res.y / 2 - sw / (w / h) / 2
        self._safe_x = x
        self._safe_y = y
        self._saferect_data.w = w
        self._saferect_data.h = h
        self._saferect_data.width = self._saferect_data.w
        self._saferect_data.height = self._saferect_data.h
        self._saferect_data.x = x
        self._saferect_data.y = y
        self._saferect_data.on_screen_width = sw
        local h_c = w / (safe_rect.width / safe_rect.height)
        h = math.max(h, h_c)
        local w_c = h_c / h
        w = math.max(w, w / w_c)
        self._corner_saferect_data.w = w
        self._corner_saferect_data.h = h
        self._corner_saferect_data.width = self._corner_saferect_data.w
        self._corner_saferect_data.height = self._corner_saferect_data.h
        self._corner_saferect_data.x = safe_rect.x
        self._corner_saferect_data.y = safe_rect.y
        self._corner_saferect_data.on_screen_width = safe_rect.width
        sh = self._base_res.x / self:_aspect_ratio()
        h = math.max(self._base_res.y, sh)
        sw = sh / h
        w = math.max(self._base_res.x, self._base_res.x / sw)
        self._fullrect_data.w = w
        self._fullrect_data.h = h
        self._fullrect_data.width = self._fullrect_data.w
        self._fullrect_data.height = self._fullrect_data.h
        self._fullrect_data.x = 0
        self._fullrect_data.y = 0
        self._fullrect_data.on_screen_width = res.x
        self._fullrect_data.convert_x = math.floor((w - scaled_size.width) / 2)
        self._fullrect_data.convert_y = math.floor((h - scaled_size.height) / 2)
        self._fullrect_data.corner_convert_x =
            math.floor((self._fullrect_data.width - self._corner_saferect_data.width) / 2)
        self._fullrect_data.corner_convert_y =
            math.floor((self._fullrect_data.height - self._corner_saferect_data.height) / 2)

        self._fullrect_16_9_data = self._fullrect_data
        self._fullrect_1280_data = self._fullrect_data
        self._corner_saferect_1280_data = self._corner_saferect_data
    end
end

if RequiredScript == "lib/managers/mousepointermanager" then
    MousePointerManager.convert_1280_mouse_pos = MousePointerManager.convert_fullscreen_mouse_pos
    MousePointerManager.convert_fullscreen_16_9_mouse_pos = MousePointerManager.convert_fullscreen_mouse_pos
end