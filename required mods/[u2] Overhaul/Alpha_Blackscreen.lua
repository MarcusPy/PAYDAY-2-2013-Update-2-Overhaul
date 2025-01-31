function HUDBlackScreen:init(hud)
	self._hud_panel = hud.panel
	if self._hud_panel:child("blackscreen_panel") then
		self._hud_panel:remove(self._hud_panel:child("blackscreen_panel"))
	end
	self._blackscreen_panel = self._hud_panel:panel({
		visible = true,
		name = "blackscreen_panel",
		y = 0,
		valign = "grow",
		halign = "grow",
		layer = 0
	})
	local mid_text = self._blackscreen_panel:text({
		name = "mid_text",
		visible = true,
		text = "000",
		layer = 1,
		color = Color.white,
		y = 0,
		valign = {0.4, 0},
		align = "center",
		vertical = "center",
		font_size = tweak_data.hud.default_font_size,
		font = tweak_data.hud.medium_font,
		w = self._blackscreen_panel:w()
	})
	local _, _, _, h = mid_text:text_rect()
	mid_text:set_h(h)
	mid_text:set_center_x(self._blackscreen_panel:center_x())
	mid_text:set_center_y(self._blackscreen_panel:h() / 3)
	local is_server = Network:is_server()
	local continue_button = managers.menu:is_pc_controller() and "[ENTER]" or nil
	local text = utf8.to_upper(managers.localization:text("hud_skip_blackscreen", {BTN_ACCEPT = continue_button}))
	local skip_text = self._blackscreen_panel:text({
		name = "skip_text",
		visible = is_server,
		text = text,
		layer = 1,
		color = Color.white,
		y = 0,
		align = "right",
		vertical = "bottom",
		font_size = nil,
		font = tweak_data.hud.medium_font_noshadow
	})
	local loading_text = utf8.to_upper(managers.localization:text("menu_loading_progress", {prog = 0}))
	local loading_text_object = self._blackscreen_panel:text({
		name = "loading_text",
		visible = false,
		text = loading_text,
		layer = 1,
		color = Color.white,
		y = 0,
		align = "right",
		vertical = "bottom",
		font_size = nil,
		font = tweak_data.hud.medium_font_noshadow
	})
	self._circle_radius = 16
	self._sides = 64
	skip_text:set_x(skip_text:x() - self._circle_radius * 3)
	skip_text:set_y(skip_text:y() - self._circle_radius)
	loading_text_object:set_x(loading_text_object:x() - self._circle_radius * 3)
	loading_text_object:set_y(loading_text_object:y() - self._circle_radius)
	self._skip_circle = CircleBitmapGuiObject:new(self._blackscreen_panel, {
		image = "guis/textures/pd2/hud_progress_32px",
		radius = self._circle_radius,
		sides = self._sides,
		current = self._sides,
		total = self._sides,
		blend_mode = "normal",
		color = Color.white,
		layer = 2
	})
	self._skip_circle:set_position(self._blackscreen_panel:w() - self._circle_radius * 3, self._blackscreen_panel:h() - self._circle_radius * 3)
end

function HUDBlackScreen:set_job_data()
	if not managers.job:has_active_job() then
		return
	end
	local job_panel = self._blackscreen_panel:panel( { visible = true, name = "job_panel", y = 0, valign = "grow", halign = "grow", layer = 1 } ) -- valign = {1/3,0}, layer = 3 } )
	
	local risk_panel = job_panel:panel( {  } )
	local filled_star_rect = { 0, 32, 32, 32 }
	local last_risk_level
	for i=1, managers.job:current_difficulty_stars() do
		last_risk_level = risk_panel:bitmap( { texture="guis/textures/pd2/skilltree/locked", w=50, h=50, color=Color(245/255,0,108/255), alpha=0.5 } )
		last_risk_level:move( (i-1) * last_risk_level:w(), 0 )	
	end
	if last_risk_level then
		risk_panel:set_size( last_risk_level:right(), last_risk_level:bottom() )
		risk_panel:set_center( job_panel:w()/2, job_panel:h()/2 )
		risk_panel:set_position( math.round(risk_panel:x()), math.round(risk_panel:y()) )
		
		local risk_text = job_panel:text( { text=managers.localization:to_upper_text( tweak_data.difficulty_name_id ), font=tweak_data.menu.pd2_large_font, font_size=tweak_data.menu.pd2_small_large_size, align="center", vertical="bottom", color=tweak_data.screen_colors.risk } )
		risk_text:set_bottom( risk_panel:top() )
		risk_text:set_center_x( risk_panel:center_x() )
	end
end

function HUDBlackScreen:set_mid_text(text)
	local mid_text = self._blackscreen_panel:child("mid_text")
	mid_text:set_alpha(0)
	local current_map = managers.job:current_level_id()
	--mid_text:set_text(utf8.to_upper("9pm, Debug Text st."))
	mid_text:set_text(utf8.to_upper(managers.localization:text("u2_level_data_".. current_map)))
end