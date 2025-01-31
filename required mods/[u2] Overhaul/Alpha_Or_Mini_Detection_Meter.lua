if (_G.u2_core.settings.hud.detection_meter_style == 1) then
	function HUDSuspicion:init( hud, sound_source )
		self._hud_panel = hud.panel
		self._sound_source = sound_source
		
		if self._hud_panel:child( "suspicion_panel" ) then	
			self._hud_panel:remove( self._hud_panel:child( "suspicion_panel" ) )
		end
			
		self._suspicion_panel = self._hud_panel:panel( { visible = false, name = "suspicion_panel", y = 0, valign = "center", layer = 1 } ) -- valign = {1/3,0}, layer = 3 } )
		-- self._suspicion_panel:set_debug( true )
		self._misc_panel = self._suspicion_panel:panel( { name="misc_panel" } )
		self._suspicion_panel:set_size( 200, 200 )
		self._suspicion_panel:set_center( self._suspicion_panel:parent():w()/2, 500 )
		-- local suspicion = self._suspicion_panel:bitmap( { name = "suspicion", visible = true, texture = "guis/textures/pd2/icon_detection", color = Color.white, alpha = 1, valign = "center", w = 128, h = 128, layer=1 } )
		-- suspicion:set_center_x( self._suspicion_panel:w() / 2 )
		-- suspicion:set_center_y( self._suspicion_panel:h() / 6 )
		
		local scale = 1.175
		local suspicion_left = self._suspicion_panel:bitmap( { name = "suspicion_left", visible = true, texture = "guis/textures/pd2/hud_stealthmeter", color = Color(0,1,1), alpha = 1, valign = "center", w = 96, h = 96, blend_mode="add", render_template = "VertexColorTexturedRadial", layer=1 } )
		suspicion_left:set_size( suspicion_left:w() * scale, suspicion_left:h() * scale )
		suspicion_left:set_center_x( self._suspicion_panel:w() / 2 )
		suspicion_left:set_center_y( self._suspicion_panel:h() / 2 )
		
		local suspicion_right = self._suspicion_panel:bitmap( { name = "suspicion_right", visible = true, texture = "guis/textures/pd2/hud_stealthmeter", color = Color(0,1,1), alpha = 1, valign = "center", w = 96, h = 96, blend_mode="add", render_template = "VertexColorTexturedRadial", layer=1 } )
		suspicion_right:set_size( suspicion_right:w() * scale, suspicion_right:h() * scale )
		suspicion_right:set_center( suspicion_left:center() )
		suspicion_left:set_texture_rect( 128, 0, -128, 128 )
		
		local hud_stealthmeter_bg = self._misc_panel:bitmap( { name = "hud_stealthmeter_bg", visible = true, texture = "guis/textures/pd2/hud_stealthmeter_bg", color = Color(0.2,1,1,1), alpha = 0, valign = {1/2,0}, w = 96, h = 96, blend_mode="normal" } )
		hud_stealthmeter_bg:set_size( hud_stealthmeter_bg:w() * scale, hud_stealthmeter_bg:h() * scale )
		hud_stealthmeter_bg:set_center( suspicion_left:center() )
		
		local suspicion_detected = self._suspicion_panel:text( { name="suspicion_detected", text=managers.localization:to_upper_text( "hud_detected" ), font_size=20, font=tweak_data.menu.pd2_medium_font, layer=2, align="center", vertical="center", alpha=0 } )
		suspicion_detected:set_text( utf8.to_upper( managers.localization:text( "hud_suspicion_detected" ) ) )
		suspicion_detected:set_center( suspicion_left:center() )
		
		--[[local hud_stealth_cam = self._misc_panel:bitmap( { name = "hud_stealth_cam", visible = true, texture = "guis/textures/pd2/hud_stealth_cam", alpha = 0, w = 32, h = 32, blend_mode="add", layer=1 } )
		hud_stealth_cam:set_center( suspicion_left:center_x(), suspicion_left:bottom() )]]
		
		local hud_stealth_eye = self._misc_panel:bitmap( { name = "hud_stealth_eye", visible = true, texture = "guis/textures/pd2/hud_stealth_eye", alpha = 0, w = 24, h = 24, valign = "center", blend_mode="add", layer=1 } )
		hud_stealth_eye:set_center( suspicion_left:center_x(), suspicion_left:bottom() - 4 )
		-- hud_stealth_eye:set_center_x( hud_stealth_cam:center_x() )
		-- hud_stealth_eye:set_bottom( hud_stealth_cam:top() + 10 )
		
		local hud_stealth_exclam = self._misc_panel:bitmap( { name = "hud_stealth_exclam", visible = true, texture = "guis/textures/pd2/hud_stealth_exclam", alpha = 0, w = 24, h = 24, valign = "center", blend_mode="add", layer=1 } )
		hud_stealth_exclam:set_center( suspicion_left:center_x(), suspicion_left:top() - 4 )
		
		
		
		self._eye_animation = nil
		self._suspicion_value = 0
		-- self._suspicion_panel:set_debug( true )
	end
elseif (_G.u2_core.settings.hud.detection_meter_style == 2) then
	local hudsuspicion_init_original = HUDSuspicion.init
	local hudsuspicions_animate_eye_original = HUDSuspicion.animate_eye
	local hudsuspicion_hide_original = HUDSuspicion.hide

	function HUDSuspicion:init(hud, sound_source, ...)
		self._hud_panel = hud.panel
		self._sound_source = sound_source
		
		if self._hud_panel:child( "suspicion_panel" ) then	
			self._hud_panel:remove( self._hud_panel:child( "suspicion_panel" ) )
		end
			
		self._suspicion_panel = self._hud_panel:panel( { visible = false, name = "suspicion_panel", y = 0, valign = "center", layer = 1 } )
		self._misc_panel = self._suspicion_panel:panel( { name="misc_panel" } )
		self._suspicion_panel:set_size( 200, 200 )
		self._suspicion_panel:set_center( self._suspicion_panel:parent():w()/2, self._suspicion_panel:parent():h()/2.5 )
		
		local scale = 1.175
		local suspicion_left = self._suspicion_panel:bitmap( { name = "suspicion_left", visible = false, texture = "guis/textures/pd2/hud_stealthmeter", color = Color(0,1,1), alpha = 1, valign = "center", w = 96, h = 96, blend_mode="add", render_template = "VertexColorTexturedRadial", layer=1 } )
		suspicion_left:set_size( suspicion_left:w() * scale, suspicion_left:h() * scale )
		suspicion_left:set_center_x( self._suspicion_panel:w() / 2 )
		suspicion_left:set_center_y( self._suspicion_panel:h() / 2 )
		
		local suspicion_right = self._suspicion_panel:bitmap( { name = "suspicion_right", visible = false, texture = "guis/textures/pd2/hud_stealthmeter", color = Color(0,1,1), alpha = 1, valign = "center", w = 96, h = 96, blend_mode="add", render_template = "VertexColorTexturedRadial", layer=1 } )
		suspicion_right:set_size( suspicion_right:w() * scale, suspicion_right:h() * scale )
		suspicion_right:set_center( suspicion_left:center() )
		suspicion_left:set_texture_rect( 128, 0, -128, 128 )
		
		local hud_stealthmeter_bg = self._misc_panel:bitmap( { name = "hud_stealthmeter_bg", visible = false, texture = "guis/textures/pd2/hud_stealthmeter_bg", color = Color(0.2,1,1,1), alpha = 0, valign = {1/2,0}, w = 96, h = 96, blend_mode="normal" } )
		hud_stealthmeter_bg:set_size( hud_stealthmeter_bg:w() * scale, hud_stealthmeter_bg:h() * scale )
		hud_stealthmeter_bg:set_center( suspicion_left:center() )
		
		local suspicion_detected = self._suspicion_panel:text( { name="suspicion_detected", text=managers.localization:to_upper_text( "hud_detected" ), font_size=28, font=tweak_data.menu.eroded_font, layer=2, align="center", vertical="center", alpha=0 } )
		suspicion_detected:set_text( utf8.to_upper( managers.localization:text( "hud_suspicion_detected" ) ) )
		suspicion_detected:set_center( suspicion_left:center() )
		
		local hud_stealth_eye = self._misc_panel:bitmap( { name = "hud_stealth_eye", visible = false, texture = "guis/textures/pd2/hud_stealth_eye", alpha = 0, w = 24, h = 24, valign = "center", blend_mode="add", layer=1 } )
		hud_stealth_eye:set_center( suspicion_left:center_x(), suspicion_left:top() - 10 )
		
		local hud_stealth_exclam = self._misc_panel:bitmap( { name = "hud_stealth_exclam", visible = false, texture = "guis/textures/pd2/hud_stealth_exclam", alpha = 0, w = 24, h = 24, valign = "center", blend_mode="add", layer=1 } )
		hud_stealth_exclam:set_center( suspicion_left:center_x(), suspicion_left:top() - 4 )
		
		self._eye_animation = nil
		self._suspicion_value = 0
	
		self._suspicion_text_panel = self._suspicion_panel:panel({
			name = "suspicion_text_panel",
			visible = true,
			x = 0,
			y = 0,
			h = self._suspicion_panel:h(),
			w = self._suspicion_panel:w(),
			layer = 1
		})
		self._suspicion_text = self._suspicion_text_panel:text({
			name = "suspicion_text",
			visible = true,
			text = "",
			valign = "center",
			align = "center",
			layer = 2,
			color = Color.white,
			font = tweak_data.menu.eroded_font,
			font_size = 36,
			h = 64
		})
		self._suspicion_text:set_y((math.round(self._suspicion_text_panel:h() / 4)))
		for i = 1, 4 do
			self["_suspicion_bgtext" .. i] = self._suspicion_text_panel:text({
				name = "suspicion_bgtext" .. i,
				visible = true,
				text = "",
				valign = "center",
				align = "center",
				layer = 1,
				color = Color.black,
				font = tweak_data.menu.eroded_font,
				font_size = 36,
				h = 64
			})
		end
		self._suspicion_bgtext1:set_x(self._suspicion_bgtext1:x() - 1)
		self._suspicion_bgtext1:set_y((math.round(self._suspicion_text_panel:h() / 4)) - 1)
		self._suspicion_bgtext2:set_x(self._suspicion_bgtext2:x() + 1)
		self._suspicion_bgtext2:set_y((math.round(self._suspicion_text_panel:h() / 4)) - 1)
		self._suspicion_bgtext3:set_x(self._suspicion_bgtext3:x() - 1)
		self._suspicion_bgtext3:set_y((math.round(self._suspicion_text_panel:h() / 4)) + 1)
		self._suspicion_bgtext4:set_x(self._suspicion_bgtext4:x() + 1)
		self._suspicion_bgtext4:set_y((math.round(self._suspicion_text_panel:h() / 4)) + 1)
	end

	function HUDSuspicion:_set_suspicion_text_text(panel, text)
		panel:child("suspicion_text"):set_text(text)
		for i = 1, 4 do
			panel:child("suspicion_bgtext" .. i):set_text(text)
		end
	end

	function HUDSuspicion:ColorGradient(perc, ...)
		if perc >= 1 then
			local r, g, b = select(select('#', ...) - 2, ...)
			return r, g, b
		elseif perc <= 0 then
			local r, g, b = ...
			return r, g, b
		end
		local num = select('#', ...) / 3
		local segment, relperc = math.modf(perc*(num-1))
		local r1, g1, b1, r2, g2, b2 = select((segment*3)+1, ...)
		local r_ret = r1 + (r2-r1)*relperc
		local g_ret = g1 + (g2-g1)*relperc
		local b_ret = b1 + (b2-b1)*relperc
		return math.round(r_ret*100)/100, math.round(g_ret*100)/100, math.round(b_ret*100)/100
	end

	function HUDSuspicion:_animate_detection_text(_suspicion_panel, ...)
		while self._animating_text do
			local t = 0
			while t <= 0.01 do
				t = t + coroutine.yield()
				if -1 ~= self._suspicion_value then
					local r,g,b = self:ColorGradient(math.round(self._suspicion_value*100)/100, 0, 0.71, 1, 0.99, 0.08, 0)
					_suspicion_panel:child("suspicion_text"):set_color(Color(1, r, g, b))
					self:_set_suspicion_text_text(_suspicion_panel, math.round(self._suspicion_value*100) .. "%")
					self:_set_suspicion_text_visibility(_suspicion_panel)
				end
			end
		end
	end

	function HUDSuspicion:animate_eye(...)
		hudsuspicions_animate_eye_original(self, ...)
		self._animating_text = true
		self._text_animation = self._suspicion_panel:child("suspicion_text_panel"):animate(callback(self, self, "_animate_detection_text"))
	end

	function HUDSuspicion:hide(...)
		hudsuspicion_hide_original(self, ...)
		if self._text_animation then
			self._animating_text = false
			self._text_animation = nil
		end
	end
end