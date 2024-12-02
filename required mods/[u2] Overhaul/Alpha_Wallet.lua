function PlayerProfileGuiObject:init(ws)
	local panel = ws:panel():panel()
	managers.menu_component:close_contract_gui()
	local next_level_data = managers.experience:next_level_data() or {}
	local max_left_len = 0
	local max_right_len = 0
	local font = tweak_data.menu.default_font_no_outline
	local font_size = 20
	local bg_ring = panel:bitmap({
		texture = "guis/textures/pd2/level_ring_small",
		w = font_size * 4.5,
		h = font_size * 4.5,
		x = 5,
		--y = 10,
		color = Color.black
	})
	local exp_ring = panel:bitmap({
		texture = "guis/textures/pd2/level_ring_small",
		w = font_size * 4.5,
		h = font_size * 4.5,
		x = 5,
		--y = 10,
		color =  Color((next_level_data.current_points or 1) / (next_level_data.points or 1), 1, 1),
		render_template = "VertexColorTexturedRadial",
		blend_mode = "add",
		layer = 1
	})
	local player_level = managers.experience:current_level()
	local level_string = tostring(player_level)
	local level_text = panel:text({
		font = font,
		font_size = 28,
		text = level_string,
		color = tweak_data.hud.prime_color 
	})
	self:_make_fine_text(level_text)
	level_text:set_center(exp_ring:center())
	max_left_len = math.max(max_left_len, level_text:w())
	local money_text = panel:text({
		text = self:get_text("u2_cash_wallet") .. managers.money:total_string(),
		font_size = font_size,
		font = font,
		y = 5,
		color = tweak_data.screen_color_blue 
	})
	self:_make_fine_text(money_text)
	money_text:set_left(math.round(exp_ring:right()))
	max_left_len = math.max(max_left_len, money_text:w())
	local total_money_text = panel:text({
		text = self:get_text("u2_offshore_wallet") .. managers.experience:cash_string(managers.money:offshore()),
		font_size = font_size,
		font = font,
		color = tweak_data.screen_color_blue
		
	})
	self:_make_fine_text(total_money_text)
	total_money_text:set_left(math.round(exp_ring:right()))
	total_money_text:set_top(math.round(money_text:bottom()))
	max_left_len = math.max(max_left_len, total_money_text:w())
	
	-- no inbuilt function to count total skillpoints for current level? this will do
	local function is_special_level(level)
		return level % 10 == 0
	end
	
	local computed_points = 0
	for lvl = 1, player_level do
		if is_special_level(lvl) then
			computed_points = computed_points + 3
		else
			computed_points = computed_points + 1
		end
	end
	
	local free_skillpoints = managers.skilltree:points()
	local spent_skillpoints = computed_points - free_skillpoints
	local total_skillpoints = computed_points
	local free_skills_text, spent_skills_text, total_skills_text
	spent_skills_text = panel:text({
		text = self:get_text("u2_spent_skillpoints_wallet") .. spent_skillpoints,
		font_size = font_size,
		font = font,
		color = tweak_data.screen_color_blue,
		layer = 1
	})
	self:_make_fine_text(spent_skills_text)
	spent_skills_text:set_left(math.round(exp_ring:right()))
	spent_skills_text:set_top(math.round(total_money_text:bottom()))
	
	free_skills_text = panel:text({
		text = self:get_text("u2_unspent_skillpoints_wallet") .. free_skillpoints,
		font_size = font_size,
		font = font,
		color = tweak_data.screen_color_blue,
		layer = 1
	})
	self:_make_fine_text(free_skills_text)
	free_skills_text:set_left(math.round(exp_ring:right()))
	free_skills_text:set_top(math.round(spent_skills_text:bottom()))

	total_skills_text = panel:text({
		text = self:get_text("u2_total_skillpoints_wallet") .. total_skillpoints,
		font_size = font_size,
		font = font,
		color = tweak_data.screen_color_blue,
		layer = 1
	})
	self:_make_fine_text(total_skills_text)
	total_skills_text:set_left(math.round(exp_ring:right()))
	total_skills_text:set_top(math.round(free_skills_text:bottom()))

	self._panel = panel
	self._panel:set_size( 300, 110 )
	self._panel:set_bottom( self._panel:parent():h() - 70 )
	
	BoxGuiObject:new( self._panel, { sides={1, 1, 1, 1} } )
	
	bg_ring:move(-5, 0)
	exp_ring:move(-5, 0)
	level_text:set_center(exp_ring:center())
	
	local level_glow = panel:bitmap({
		w = 100,
		h = 100,
		texture = "guis/textures/pd2/crimenet_marker_glow",
		color = tweak_data.screen_colors.button_stage_3,
		layer = 0,
		blend_mode = "add"
	})
	level_glow:set_center(exp_ring:center())
	
	local animate_level_haze = function(o)
		while true do
			over(1, function(p)
				o:set_alpha(math.lerp(0.4, 0.85, math.sin(p * 180)))
			end)
		end
	end
	level_glow:animate(animate_level_haze)
	
	local current_level_exp = panel:text({
		font = font,
		font_size = 10,
		text = self:get_text("u2_current_level_exp") .. next_level_data.current_points,
		color = tweak_data.hud.prime_color 
	})
	self:_make_fine_text(current_level_exp)
	current_level_exp:move(10, 88)
	
	local missing_exp = next_level_data.points - next_level_data.current_points
	local next_level_in = panel:text({
		font = font,
		font_size = 10,
		text = self:get_text("u2_next_level_exp") .. missing_exp,
		color = tweak_data.hud.prime_color 
	})
	self:_make_fine_text(next_level_in)
	next_level_in:move(10, 98)
	
	self._panel:rect( { color=Color(0.5, 0, 0, 0), layer=-1 } )
	self._panel:polyline( { color=Color.white:with_alpha(0.5), blend_mode="add", line_width=1, closed=true, points={ Vector3( 0, 0, 0 ), Vector3( self._panel:w(), 0, 0 ), Vector3( self._panel:w(), self._panel:h(), 0 ), Vector3( 0, self._panel:h(), 0 ) } } )

	----------------------------------------------------------
	trigger = _G.u2_core:validate_settings()
	if (#trigger > 0) then
		local error_panel = ws:panel():panel()
		self._error_panel = error_panel
		self._error_panel:set_size(300, 20)
		self._error_panel:set_bottom(self._panel:top()-10)
		self._error_panel:rect( { color=Color(0.5, 0, 0, 0), layer=-1 } )
		self._error_panel:polyline( { color=Color.red, blend_mode="add", line_width=1, closed=true, points={ Vector3( 0, 0, 0 ), Vector3( self._error_panel:w(), 0, 0 ), Vector3( self._error_panel:w(), self._error_panel:h(), 0 ), Vector3( 0, self._error_panel:h(), 0 ) } } )
		local errors_detected = self._error_panel:text({
			x = 3,
			font = font,
			font_size = 19,
			text = self:get_text("u2_errors_detected"),
			color = Color.white
		})
		self:_make_fine_text(errors_detected)
	else
		LocalizationManager:add_localized_strings( {
			["u2_ver"] = string.format("PAYDAY 2 u2 Overhaul\nRevision %s - %s", _G.u2_core.info.version, _G.u2_core.info.revision)
		} )
		local version_panel = ws:panel():panel()
		self._version_panel = version_panel
		self._version_panel:set_size(300, 30)
		self._version_panel:set_bottom(self._panel:top())
		local u2_version_text = self._version_panel:text({
			font = font,
			font_size = 12,
			text = self:get_text("u2_ver"),
			color = _G.u2_core.colors.half_transparent.purple:with_alpha(0.15)
		})
		self:_make_fine_text(u2_version_text)
	end
end