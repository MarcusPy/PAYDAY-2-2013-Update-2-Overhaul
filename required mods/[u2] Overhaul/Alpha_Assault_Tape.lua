HUDAssaultCorner._custom_lines_assault = {
	string.format("u2 Overhaul - Revision %s - %s", _G.u2_core.info.version, _G.u2_core.info.revision)
}

HUDAssaultCorner._custom_line_chance = 5

function HUDAssaultCorner:init(hud, full_hud)
	self._hud_panel = hud.panel
	self._full_hud_panel = full_hud.panel
	if self._hud_panel:child("assault_panel") then
		self._hud_panel:remove(self._hud_panel:child("assault_panel"))
	end
	local size = 200
	local assault_panel = self._hud_panel:panel({
		visible = false,
		name = "assault_panel",
		w = 400,
		h = 100
	})
	--assault_panel:set_top( 0 )
	assault_panel:set_center( self._hud_panel:w(), 0 )
	--assault_panel:set_right( self._hud_panel:w() )
	self._assault_mode = "normal"
	self._assault_color = Color.red
	self._assault_survived_color = Color.green
	self._current_assault_color = self._assault_color
	local icon_assaultbox = assault_panel:bitmap({
		halign = "right",
		valign = "top",
		color = Color.red,
		name = "icon_assaultbox",
		blend_mode = "add",
		visible = true,
		layer = 0,
		texture = "guis/textures/pd2/hud_icon_assaultbox",
		x = 0,
		y = 0,
		w = 24,
		h = 24
	})
	local yellow_tape = assault_panel:rect({
		visible = true,
		name = "yellow_tape",
		h = tweak_data.hud.location_font_size * 1.5,
		w = size * 3.333,
		color = self._assault_color,
		layer = 1
	})
	yellow_tape:set_center(10, 50)
	yellow_tape:set_rotation(30)
	yellow_tape:set_blend_mode("add")
	assault_panel:panel({
		name = "text_panel",
		layer = 1,
		w = yellow_tape:w()
	}):set_center(yellow_tape:center())
	------------------------------
	self._assault_corner_color = Color.red
	self._assault_corner2_color = Color.blue
	self._wave_corner_color = Color.green
	self._wave_corner2_color = Color(1, 0.8, 0)
	self._captain_corner_color = Color.blue
	self._captain_corner2_color = Color.white
	local corner_panel = self._hud_panel:panel({
		visible = false,
		name = "corner_panel",
		w = 200,
		h = 200
	})
	corner_panel:set_top( 0 )
	corner_panel:set_right( self._hud_panel:w() )
	local corner = corner_panel:rect({
		visible = true,
		name = "corner",
		h = 198, --tweak_data.hud.location_font_size * 5.5,
		w = size * 2,
		color = self._assault_corner_color,
		layer = 1
	})
	corner:set_top(-104)
	corner:set_rotation(45)
	local corner2 = corner_panel:rect({
		visible = true,
		name = "corner2",
		h = 158,
		w = size * 2,
		color = self._assault_corner2_color,
		layer = 1
	})
	corner2:set_top(-104)
	corner2:set_rotation(45)
	local corner_title = corner_panel:text({ 
		name="corner_title", 
		text="ASSAULT", 
		layer = 11, 
		valign="top", 
		align = "center", 
		vertical = "center", 
		x = 0, 
		y = 0, 
		color = self._assault_corner2_color, 
		font_size = 28, 
		font = "fonts/font_medium_shadow_mf" 
		})
	corner_title:set_rotation(45)
	corner_title:set_top(-38)
	corner_title:set_right( 257 )
	------------------------------
	if self._hud_panel:child("hostages_panel") then
		self._hud_panel:remove(self._hud_panel:child("hostages_panel"))
	end
	local hostages_panel = self._hud_panel:panel({
		name = "hostages_panel",
		w = 0,
		h = 0,
		x = self._hud_panel:w() - size
	})
	local num_hostages = hostages_panel:text({
		name = "num_hostages",
		text = "0",
		valign = "top",
		align = "right",
		vertical = "center",
		w = 0,
		h = 0,
		layer = 1,
		x = hostages_panel:w() - 42,
		y = 0,
		color = Color.white,
		font = tweak_data.menu.default_font,
		font_size = tweak_data.hud_corner.numhostages_size * 1.5
	})
	local texture, rect = tweak_data.hud_icons:get_icon_data( "interaction_trade" )
	local hostages_icon = hostages_panel:bitmap({ 
		name = "hostages_icon", 
		texture = texture, 
		texture_rect = rect, 
		valign="top", 
		layer = 1, 
		x = hostages_panel:w() - num_hostages:w() - rect[4], 
		y = 0
	})
	----------------------------
	if self._hud_panel:child("wave_panel") then
		self._hud_panel:remove(self._hud_panel:child("wave_panel"))
	end
	self._max_waves = 0
	self._wave_number = 0
	if self:has_waves() then
		self._wave_panel_size = {250, 38}
		local wave_w, wave_h = 38, 38
		local wave_panel = self._hud_panel:panel({
			name = "wave_panel",
			w = 0,
			h = 0,
			x = self._hud_panel:w() - size * 1.5
		})
		local num_waves = wave_panel:text({
			name = "num_waves",
			text = "",
			valign = "center",
			vertical = "center",
			align = "center",
			halign = "right",
			w = 40,
			h = 48,
			layer = 1,
			x = wave_panel:w() - 42,
			y = 0,
			color = Color.white,
			font = tweak_data.menu.default_font,
			font_size = tweak_data.hud_corner.numhostages_size * 1.5
		})
		local waves_icon = wave_panel:bitmap({
			name = "waves_icon",
			texture = "guis/textures/hud_icons",
			texture_rect = {
				240,
				48,
				48,
				48
			},
			valign = "top",
			layer = 1,
			x = wave_panel:w() - num_waves:w() - 64, 
			y = 0
		})
	end
	----------------------------
	if self._hud_panel:child("point_of_no_return_panel") then
		self._hud_panel:remove(self._hud_panel:child("point_of_no_return_panel"))
	end
	local size = 300
	local point_of_no_return_panel = self._hud_panel:panel({
		visible = false,
		name = "point_of_no_return_panel",
		w = size,
		h = 100,
		x = self._hud_panel:w() - size
	})
	self._noreturn_data = self:_get_noreturn_data()
	local w = point_of_no_return_panel:w()
	local size = 200 - tweak_data.hud.location_font_size
	local point_of_no_return_text = point_of_no_return_panel:text({
		name = "point_of_no_return_text",
		text = "",
		blend_mode = "add",
		layer = 1,
		valign = "center",
		align = "right",
		vertical = "center",
		x = 0,
		y = 0,
		color = self._noreturn_data.color,
		font_size = 30,
		font = "fonts/font_large_mf"
	})
	point_of_no_return_text:set_text(utf8.to_upper(managers.localization:text(self._noreturn_data.text_id, {
		time = ""
	})))
	local _, _, w, h = point_of_no_return_text:text_rect()
	point_of_no_return_text:set_size(w * 2, h)
	point_of_no_return_text:set_right(point_of_no_return_panel:w())
	local point_of_no_return_timer = point_of_no_return_panel:text({
		name = "point_of_no_return_timer",
		text = "22:11",
		blend_mode = "add",
		layer = 1,
		valign = "center",
		align = "center",
		vertical = "center",
		x = 0,
		y = 0,
		color = self._noreturn_data.color,
		font_size = 30,
		font = "fonts/font_large_mf"
	})
	local _, _, w, h = point_of_no_return_timer:text_rect()
	point_of_no_return_timer:set_size(w * 2, h * 2)
	point_of_no_return_timer:set_right(point_of_no_return_panel:w())
	point_of_no_return_timer:set_top(point_of_no_return_text:bottom())
	--point_of_no_return_text:set_right( math.round( point_of_no_return_timer:left() ) )
	self:_update_noreturn()
	if self._hud_panel:child("casing_panel") then
		self._hud_panel:remove(self._hud_panel:child("casing_panel"))
	end
	local size = 300
	local casing_panel = self._hud_panel:panel({
		visible = false,
		name = "casing_panel",
		w = size,
		h = 40,
		x = self._hud_panel:w() - size
	})
	self._casing_color = Color.white
	local icon_casingbox = casing_panel:bitmap({
		halign = "right",
		valign = "top",
		color = self._casing_color,
		name = "icon_casingbox",
		blend_mode = "add",
		visible = true,
		layer = 0,
		texture = "guis/textures/pd2/hud_icon_stealthbox",
		x = 0,
		y = 0,
		w = 24,
		h = 24
	})
	icon_casingbox:set_right(icon_casingbox:parent():w())
	self._casing_bg_box = HUDBGBox_create(casing_panel, {
		w = 242,
		h = 38,
		x = 0,
		y = 0
	}, {
		color = self._casing_color,
		blend_mode = "add"
	})
	self._casing_bg_box:set_right(icon_casingbox:left() - 3)
	local w = casing_panel:w()
	local size = 200 - tweak_data.hud.location_font_size
	casing_panel:panel({
		name = "text_panel",
		layer = 1,
		w = yellow_tape:w()
	}):set_center(yellow_tape:center())
end

function HUDAssaultCorner:_animate_text(text_panel, bg_box, color, color_function)
	local text_list = text_panel:script().text_list
	local text_index = 0
	local texts = {}
	local padding = 10
	local y = 27
	local function create_new_text(text_panel, text_list, text_index, texts)
		if texts[text_index] and texts[text_index].text then
			text_panel:remove(texts[text_index].text)
			texts[text_index] = nil
		end
		local text_id = text_list[text_index]
		local text_string = ""
		if type(text_id) == "string" then

			local tab = {}
			
			if self._assault then
				tab = self._custom_lines_assault
			end
			if #tab > 0 and text_id ~= "hud_assault_end_line" and text_id ~= "hud_assault_padlock" and self._custom_line_chance > math.random(100) then
				text_string = tab[math.random(#tab)]
			else
				text_string = managers.localization:to_upper_text(text_id)
			end
		elseif text_id == Idstring("risk") then
			local use_stars = true
			if use_stars then
				for i = 1, managers.job:current_difficulty_stars() do
					text_string = text_string .. managers.localization:get_default_macro("BTN_SKULL")
				end
			end

		end
		local mod_color = color_function and color_function() or color or self._assault_color
		local text = text_panel:text({
			text = text_string,
			layer = 1,
			align = "center",
			vertical = "center",
			rotation = 30,
			color = Color.black,
			font_size = tweak_data.hud_corner.assault_size * 1.2,
			font = tweak_data.hud_corner.assault_font,
			w = 10,
			h = 10
		})
		local _, _, w, h = text:text_rect()
		text:set_size(w, h)
		texts[text_index] = {
			x = text_panel:w() + w * 0.5 + padding * 2,
			text = text
		}
	end
	while true do
		local dt = coroutine.yield()
		local last_text = texts[text_index]
		if last_text and last_text.text then
			if last_text.x + last_text.text:w() * 0.5 + padding < text_panel:w() then
				text_index = text_index % #text_list + 1
				create_new_text(text_panel, text_list, text_index, texts)
			end
		else
			text_index = text_index % #text_list + 1
			create_new_text(text_panel, text_list, text_index, texts)
		end
		--self._tape_speed = 90
		for i, data in pairs(texts) do
			if( data.text ) then
				data.x = data.x - dt * self._tape_speed
				data.text:set_center_x( math.cos(30) * data.x )
				data.text:set_center_y( math.sin(30) * (data.x - text_panel:w()*0.5) + y )
				
				if( data.x + data.text:w()*0.5 < 0 ) then
					text_panel:remove( data.text )
					data.text = nil
				end
			end
		end
	end
end

function HUDAssaultCorner:get_assault_mode()
	return self._assault_mode
end

function HUDAssaultCorner:sync_set_assault_mode(mode)
	if self._assault_mode == mode then
		return
	end
	self._assault_mode = mode
	local corner_panel = self._hud_panel:child("corner_panel")
	local color = self._assault_color
	local corner_color = self._assault_corner_color
	local corner2_color = self._assault_corner2_color
	local text = "ASSAULT"
	corner_panel:child( "corner_title" ):set_text(text)
	corner_panel:child( "corner" ):set_color(corner_color)
	corner_panel:child( "corner2" ):set_color(corner2_color)
	self._current_assault_color = color
	self:_set_text_list(self:_get_assault_strings())
	self:_update_assault_hud_color(color)
end

function HUDAssaultCorner:_update_assault_hud_color(color)
	self._current_assault_color = color
	self._hud_panel:child("assault_panel"):child("yellow_tape"):set_color(color)
end

function HUDAssaultCorner:_animate_assault( assault_panel )
	
	local dt = 0
	
	local entering = true
	
	local offset = 6
	local tape_center_x = assault_panel:parent():w() - offset
	local tape_center_y = 0 + offset
	local offscreen_pos = offset + 200
	local current_pos = offscreen_pos
	
	assault_panel:set_center( tape_center_x + current_pos, tape_center_y - current_pos )
	while true do
		dt = coroutine.yield()
		
		self._tape_speed = 160
		if( not self._assault ) then
			current_pos = current_pos + dt * (130+offset)
			assault_panel:set_center( tape_center_x + current_pos, tape_center_y - current_pos )
			
			if( current_pos >= offscreen_pos ) then
				if self._remove_hostage_offset then
					self:_set_hostage_offseted(false)
				end
				break;	-- done!
			end
			self._tape_speed = 160
		elseif( entering ) then
			current_pos = current_pos - dt * (130+offset)
			assault_panel:set_center( tape_center_x + current_pos, tape_center_y - current_pos )
			
			self._tape_speed = 160
			if( current_pos <= 0 ) then
				assault_panel:set_center( tape_center_x, tape_center_y )
				entering = false
				current_pos = 0
			end
		end
	end
	
end

function HUDAssaultCorner:sync_start_assault(assault_number)
	if self._point_of_no_return or self._casing then
		return
	end
	--self:_hide_hostages()
	local corner_panel = self._hud_panel:child("corner_panel")
	local color = self._assault_color
	local corner_color = self._assault_corner_color
	local corner2_color = self._assault_corner2_color
	local text = "ASSAULT"
	corner_panel:child( "corner_title" ):set_text(text)
	corner_panel:child( "corner" ):set_color(corner_color)
	corner_panel:child( "corner2" ):set_color(corner2_color)
	self:_update_assault_hud_color(color)
	self._start_assault_after_hostage_offset = true
	self:_set_hostage_offseted(true)
	self:set_assault_wave_number(assault_number)
end

function HUDAssaultCorner:set_assault_wave_number(assault_number)
	self._wave_number = assault_number
	local panel = self._hud_panel:child("wave_panel")
	print("found panel")
	if panel then
		local wave_text = panel:child("num_waves")
		if wave_text then
			wave_text:set_text(self:get_completed_waves_string())
		end
	end
end

function HUDAssaultCorner:start_assault_callback()
	self:_start_assault(self:_get_assault_strings())
end

function HUDAssaultCorner:_get_assault_strings()
	if self._assault_mode == "normal" then
		local current_stars = managers.job:current_difficulty_stars() + 2
		local diff_id = tweak_data.difficulties[current_stars]
		local diff_name = tweak_data.difficulty_name_ids[diff_id]
		
		if current_stars > 2 then
			local ids_risk = Idstring("risk")
			return {
				"u2_hud_assault_police",
				"hud_assault_end_line",
				diff_name,
				"hud_assault_end_line",
				"u2_hud_assault_cover_police",
				"hud_assault_end_line",
				
				"u2_hud_assault_swat",
				"hud_assault_end_line",
				diff_name,
				"hud_assault_end_line",
				"u2_hud_assault_cover_swat",
				"hud_assault_end_line",
				
				"u2_hud_assault_fbi",
				"hud_assault_end_line",
				diff_name,
				"hud_assault_end_line",
				"u2_hud_assault_cover_fbi",
				"hud_assault_end_line"
			}
		else
			return {
				"u2_hud_assault_police",
				"u2_hud_assault_cover_police",
				"hud_assault_end_line",
				"u2_hud_assault_swat",
				"u2_hud_assault_cover_swat",
				"hud_assault_end_line",
				"u2_hud_assault_fbi",
				"u2_hud_assault_cover_fbi",
				"hud_assault_end_line"
			}
		end
	end
end

function HUDAssaultCorner:sync_end_assault(result)
	if self._point_of_no_return or self._casing then
		return
	end
	self:_end_assault()
end

function HUDAssaultCorner:_set_text_list(text_list)
	local assault_panel = self._hud_panel:child("assault_panel")
	local text_panel = assault_panel:child("text_panel")
	text_panel:script().text_list = text_panel:script().text_list or {}
	while #text_panel:script().text_list > 0 do
		table.remove(text_panel:script().text_list)
	end
	for _, text_id in ipairs(text_list) do
		table.insert(text_panel:script().text_list, text_id)
	end
end

function HUDAssaultCorner:_start_assault(text_list)
	text_list = text_list or {""}
	local assault_panel = self._hud_panel:child("assault_panel")
	local text_panel = assault_panel:child("text_panel")
	local corner_panel = self._hud_panel:child("corner_panel")
	self:_set_text_list(text_list)
	local started_now = not self._assault
	self._assault = true
	if self._hud_panel:child("assault_panel"):child("text_panel") then
		self._hud_panel:child("assault_panel"):child("text_panel"):stop()
		self._hud_panel:child("assault_panel"):child("text_panel"):clear()
	else
		assault_panel:panel({name = "text_panel"})
	end
	corner_panel:set_visible(false)
	corner_panel:stop()
	corner_panel:animate(callback(self, self, "_animate_assault_corner"))
	assault_panel:set_visible(true)
	text_panel:stop()
	assault_panel:stop()
	assault_panel:animate(callback(self, self, "_animate_assault"))
	text_panel:animate(callback(self, self, "_animate_text"), nil, nil, nil)
	self:_set_feedback_color(self._assault_color)

	if self:has_waves() then
		self._hud_panel:child("wave_panel"):child("num_waves"):set_text(self:get_completed_waves_string())
		self._hud_panel:child("wave_panel"):set_visible(true)
	end
end

function HUDAssaultCorner:_animate_assault_corner( corner_panel )
	local corner = corner_panel:child( "corner" )
	local corner2 = corner_panel:child( "corner2" )
	local corner_title = corner_panel:child( "corner_title" )
	while true do
		local a = 0.25 + (math.sin( Application:time()*750 )+1)/4
		-- print( "a", a, 1 - a )
		corner:set_color( corner:color():with_alpha( 0.75 ) )
		corner2:set_color( corner2:color():with_alpha( 0.75 ) )
		corner_title:set_color( Color( a, 0, 0.8-a ) )
		-- o:set_color( o:color():with_alpha( 0.5 + (math.sin( Application:time()*750 )+1)/4 ) )
		coroutine.yield()
	end
end

function HUDAssaultCorner:_animate_wave_corner( corner_panel )
	local corner = corner_panel:child( "corner" )
	local corner2 = corner_panel:child( "corner2" )
	local corner_title = corner_panel:child( "corner_title" )
	while true do
		local a = 0.25 + (math.sin( Application:time()*375 )+1)/4
		-- print( "a", a, 1 - a )
		corner:set_color( corner:color():with_alpha( 0.75 ) )
		corner2:set_color( corner2:color():with_alpha( 0.75 ) )
		corner_title:set_color( Color(1, 0.8, 0):with_alpha ( a ) )
		-- o:set_color( o:color():with_alpha( 0.5 + (math.sin( Application:time()*750 )+1)/4 ) )
		coroutine.yield()
	end
end

function HUDAssaultCorner:assault_attention_color_function()
	return self._current_assault_color
end

function HUDAssaultCorner:_end_assault()
	if not self._assault then
		self._start_assault_after_hostage_offset = nil
		return
	end
	self._remove_hostage_offset = true
	self._start_assault_after_hostage_offset = nil
	self:_set_feedback_color(nil)
	local corner_panel = self._hud_panel:child("corner_panel")
	corner_panel:set_visible(false)
	corner_panel:stop()
	local assault_panel = self._hud_panel:child("assault_panel")
	local text_panel = assault_panel:child("text_panel")
	self._hud_panel:child("assault_panel"):child("text_panel"):stop()
	self._hud_panel:child("assault_panel"):child("text_panel"):clear()
	if self:has_waves() then
		assault_panel:set_visible(true)
		wave_panel = self._hud_panel:child("wave_panel")
		self:_update_assault_hud_color(self._assault_survived_color)
		self:_set_text_list({"hud_assault_end_line", "u2_hud_assault_over", "hud_assault_end_line", "u2_hud_assault_reinforce"})
		text_panel:animate(callback(self, self, "_animate_text"), nil, nil, nil)
		self._hud_panel:child("wave_panel"):set_visible(true)		
		wave_panel:animate(callback(self, self, "_animate_wave_completed"), self)
	else
		self:_close_assault_panel()
	end
end

function HUDAssaultCorner:_close_assault_panel()
	local corner_panel = self._hud_panel:child("corner_panel")
	corner_panel:set_visible(false)
	corner_panel:stop()
	self:sync_set_assault_mode("normal")
	self._assault = false
	if self._remove_hostage_offset then
		self:_set_hostage_offseted(false)
		local hostage_panel = self._hud_panel:child("hostages_panel")
		hostage_panel:animate(callback(self, self, "_offset_hostage", false))
	end
end
function HUDAssaultCorner:_show_icon_assaultbox(icon_assaultbox)
	local TOTAL_T = 2
	local t = TOTAL_T
	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt
		local alpha = math.round(math.abs((math.sin(t * 360 * 2))))
		icon_assaultbox:set_alpha(alpha)
	end
	icon_assaultbox:set_alpha(1)
end
function HUDAssaultCorner:_hide_icon_assaultbox(icon_assaultbox)
	local TOTAL_T = 1
	local t = TOTAL_T
	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt
		local alpha = math.round(math.abs((math.cos(t * 360 * 2))))
		icon_assaultbox:set_alpha(alpha)
		if self._remove_hostage_offset and t < 0.03 then
			self:_set_hostage_offseted(false)
		end
	end
	if self._remove_hostage_offset then
		self:_set_hostage_offseted(false)
	end
	icon_assaultbox:set_alpha(0)
	if not self._casing then
		self:_show_hostages()
	end
end
function HUDAssaultCorner:_show_hostages()
	if not self._point_of_no_return then
		self._hud_panel:child("hostages_panel"):show()
	end
end
function HUDAssaultCorner:_hide_hostages()
	self._hud_panel:child("hostages_panel"):hide()
end
function HUDAssaultCorner:_set_hostage_offseted(is_offseted)
	local hostage_panel = self._hud_panel:child("hostages_panel")
	self._remove_hostage_offset = nil
	hostage_panel:stop()
	hostage_panel:animate(callback(self, self, "_offset_hostage", is_offseted))
	local wave_panel = self._hud_panel:child("wave_panel")
	if wave_panel then
		wave_panel:stop()
		wave_panel:animate(callback(self, self, "_offset_hostage", is_offseted))
	end
end
function HUDAssaultCorner:_offset_hostage(is_offseted, hostage_panel)
	local TOTAL_T = 0.18
	local OFFSET = false and self._hud_panel:child("corner_panel"):h() or self._hud_panel:child("assault_panel"):h() + 8
	local from_y = is_offseted and 0 or OFFSET
	local target_y = is_offseted and OFFSET or 0
	local t = (1 - math.abs(hostage_panel:y() - target_y) / OFFSET) * TOTAL_T
	while TOTAL_T > t do
		local dt = coroutine.yield()
		t = math.min(t + dt, TOTAL_T)
		local lerp = t / TOTAL_T
		hostage_panel:set_y(math.lerp(from_y, target_y, lerp))
		if self._start_assault_after_hostage_offset and lerp > 0.4 then
			self._start_assault_after_hostage_offset = nil
			self:start_assault_callback()
		end
		if hostage_panel:y() == 0 then
			wait(1)
			self:_show_hostages()
		end
	end
	if self._start_assault_after_hostage_offset then
		self._start_assault_after_hostage_offset = nil
		self:start_assault_callback()
	end
end
function HUDAssaultCorner:set_control_info(data)
	self._hud_panel:child( "hostages_panel" ):child( "num_hostages" ):set_text( ""..data.nr_hostages )
end
function HUDAssaultCorner:feed_point_of_no_return_timer(time, is_inside)
	time = math.floor(time)
	local minutes = math.floor(time / 60)
	local seconds = math.round(time - minutes * 60)
	local text = (minutes < 10 and "0" .. minutes or minutes) .. ":" .. (seconds < 10 and "0" .. seconds or seconds)
	self._hud_panel:child("point_of_no_return_panel"):child("point_of_no_return_timer"):set_text(text)
end
function HUDAssaultCorner:show_point_of_no_return_timer(id)
	local delay_time = self._assault and 1.2 or 0
	self:_end_assault()
	self:_update_noreturn(id)
	local point_of_no_return_panel = self._hud_panel:child("point_of_no_return_panel")
	point_of_no_return_panel:stop()
	point_of_no_return_panel:animate(callback(self, self, "_animate_show_noreturn"), delay_time)
	self:_hide_hostages()
	self._hud_panel:child("point_of_no_return_panel"):set_visible(true)
	-- self:_set_feedback_color(self._noreturn_color)
	self._point_of_no_return = true
end
function HUDAssaultCorner:hide_point_of_no_return_timer()
	self._hud_panel:child("point_of_no_return_panel"):set_visible(false)
	self._point_of_no_return = false
	self:_show_hostages()
	self:_set_feedback_color(nil)
end
function HUDAssaultCorner:flash_point_of_no_return_timer(beep)
	local function flash_timer(o)
		local t = 0
		while t < 0.5 do
			t = t + coroutine.yield()
			local n = 1 - math.sin(t * 180)
			local r = math.lerp(self._noreturn_color.r, 1, n)
			local g = math.lerp(self._noreturn_color.g, 0.8, n)
			local b = math.lerp(self._noreturn_color.b, 0.2, n)
			o:set_color(Color(r, g, b))
			o:set_font_size(math.lerp(50, 50 * 1.25, n))
		end
	end
	local point_of_no_return_timer = self._hud_panel:child( "point_of_no_return_panel" ):child( "point_of_no_return_timer" )
	point_of_no_return_timer:animate(flash_timer)
end
function HUDAssaultCorner:show_casing(mode)
	local delay_time = self._assault and 1.2 or 0
	self:_end_assault()
	local casing_panel = self._hud_panel:child("casing_panel")
	local text_panel = casing_panel:child("text_panel")
	text_panel:script().text_list = {}
	self._casing_bg_box:script().text_list = {}
	self._mode = mode
	local msg
	if mode == "civilian" then
		msg = {
			"hud_casing_mode_ticker_clean",
			"hud_assault_end_line",
			"hud_casing_mode_ticker_clean",
			"hud_assault_end_line"
		}
	else
		msg = {
			"hud_casing_mode_ticker",
			"hud_assault_end_line",
			"hud_casing_mode_ticker",
			"hud_assault_end_line"
		}
	end
	for _, text_id in ipairs(msg) do
		table.insert(text_panel:script().text_list, text_id)
		table.insert(self._casing_bg_box:script().text_list, text_id)
	end
	if self._casing_bg_box:child("text_panel") then
		self._casing_bg_box:child("text_panel"):stop()
		self._casing_bg_box:child("text_panel"):clear()
	else
		self._casing_bg_box:panel({name = "text_panel"})
	end
end
function HUDAssaultCorner:hide_casing()
	if self._casing_bg_box:child("text_panel") then
		self._casing_bg_box:child("text_panel"):stop()
		self._casing_bg_box:child("text_panel"):clear()
	end
	local icon_casingbox = self._hud_panel:child("casing_panel"):child("icon_casingbox")
	icon_casingbox:stop()
	local function close_done()
		self._casing_bg_box:set_visible(false)
		local icon_casingbox = self._hud_panel:child("casing_panel"):child("icon_casingbox")
		icon_casingbox:stop()
		icon_casingbox:animate(callback(self, self, "_hide_icon_assaultbox"))
	end
	self._casing_bg_box:stop()
	self._casing_bg_box:animate(callback(nil, _G, "HUDBGBox_animate_close_left"), close_done)
	self._casing = false
end
function HUDAssaultCorner:_animate_simple_text(text)
	local _, _, w, _ = text:text_rect()
	text:set_w(w + 10)
	text:set_visible(true)
	text:set_x(text:parent():w())
	local x = text:x()
	local t = 0
	local speed = 90
	while true do
		local dt = coroutine.yield()
		t = t + dt
		x = x - speed * dt
		text:set_x(x)
		if 0 > text:right() then
			text:set_x(text:parent():w())
			x = text:x()
		end
	end
end
function HUDAssaultCorner:_animate_show_casing(casing_panel, delay_time)
	local icon_casingbox = casing_panel:child("icon_casingbox")
	wait(delay_time)
	casing_panel:set_visible(true)
	icon_casingbox:stop()
	icon_casingbox:animate(callback(self, self, "_show_icon_assaultbox"))
	local open_done = function()
	end
	self._casing_bg_box:stop()
	self._casing_bg_box:animate(callback(nil, _G, "HUDBGBox_animate_open_left"), 0.75, 242, open_done, {
		attention_color = self._casing_color,
		attention_forever = true
	})
	local text_panel = self._casing_bg_box:child("text_panel")
	text_panel:stop()
	text_panel:animate(callback(self, self, "_animate_text"), self._casing_bg_box, Color.white)
end
function HUDAssaultCorner:_animate_show_noreturn(point_of_no_return_panel, delay_time)
	local point_of_no_return_text = point_of_no_return_panel:child("point_of_no_return_text")
	local point_of_no_return_timer = point_of_no_return_panel:child("point_of_no_return_timer")
	wait(delay_time)
	point_of_no_return_panel:set_visible(true)
	point_of_no_return_text:animate(callback(self, self, "_animate_show_texts"), {point_of_no_return_text, point_of_no_return_timer})
end
function HUDAssaultCorner:_animate_show_texts(anim_object, texts)
	for _, text in ipairs(texts) do
		text:set_visible(true)
	end
	local TOTAL_T = 0.5
	local t = TOTAL_T
	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt
		local alpha = math.round(math.abs((math.sin(t * 360 * 3))))
		for _, text in ipairs(texts) do
			text:set_alpha(alpha)
		end
	end
	for _, text in ipairs(texts) do
		text:set_alpha(1)
	end
end
function HUDAssaultCorner:test()
	self._hud_panel:child("point_of_no_return_panel"):animate(callback(self, self, "_animate_test_point_of_no_return"))
end
function HUDAssaultCorner:_animate_test_point_of_no_return(panel)
	managers.hud:show_point_of_no_return_timer()
	local t = 15
	local prev_time = t
	while t > 0 do
		local dt = coroutine.yield()
		t = t - dt
		local sec = math.floor(t)
		if sec < math.floor(prev_time) then
			prev_time = sec
			managers.hud:flash_point_of_no_return_timer(sec <= 10)
		end
		managers.hud:feed_point_of_no_return_timer(math.max(t, 0), false)
	end
	managers.hud:hide_point_of_no_return_timer()
end
function HUDAssaultCorner:_set_feedback_color(color)
	if self._feedback_color ~= color then
		self._feedback_color = color
		if color then
			self._feedback_color_t = 2.8
			managers.hud:add_updator("feedback_color", callback(self, self, "_update_feedback_alpha"))
		else
			managers.hud:remove_updator("feedback_color")
			--managers.platform:set_feedback_color(nil)
		end
	end
end
function HUDAssaultCorner:_update_feedback_alpha(t, dt)
	self._feedback_color_t = self._feedback_color_t - dt
	local alpha_curve = math.sin(self._feedback_color_t * 180)
	local alpha = math.abs(alpha_curve)
	local color = self._feedback_color
	if color == self._assault_color then
		if alpha_curve < 0 then
			color = Color.blue
		else
			color = Color.red
		end
	end
	--managers.platform:set_feedback_color(color:with_alpha(alpha))
end

function HUDAssaultCorner:_animate_wave_completed(panel, assault_hud)
	local wave_text = panel:child("num_waves")
	wait(1.4)
	wave_text:set_text(self:get_completed_waves_string())
	wait(7.2)
	self:_close_assault_panel()
end

function HUDAssaultCorner:has_waves()
	return self._max_waves < math.huge
end

function HUDAssaultCorner:get_completed_waves_string()
	return ""
end

function HUDAssaultCorner:_get_noreturn_data(id)
	local noreturn_data = {
		color = Color.red,
		text_id = ""
	}

	return noreturn_data
end

function HUDAssaultCorner:_update_noreturn(id)
	local point_of_no_return_panel = self._hud_panel:child("point_of_no_return_panel")
	local point_of_no_return_text = point_of_no_return_panel:child("point_of_no_return_text")
	local point_of_no_return_timer = point_of_no_return_panel:child("point_of_no_return_timer")
	local noreturn_data = self:_get_noreturn_data(id)

	if noreturn_data.color ~= self._noreturn_data.color then
		point_of_no_return_text:set_color(noreturn_data.color)
		point_of_no_return_timer:set_color(noreturn_data.color)
	end

	if noreturn_data.text_id ~= self._noreturn_data.text_id then
		point_of_no_return_text:set_text(managers.localization:to_upper_text(noreturn_data.text_id))
	end

	self._noreturn_data = noreturn_data
end
