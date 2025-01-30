function HUDMissionBriefing:init( hud, workspace )
	self._backdrop = MenuBackdropGUI:new( workspace )
	self._backdrop:create_black_borders()
	
	self._hud = hud
	self._workspace = workspace
	
	--self._workspace:panel():set_debug( false )
	
	
	-- self._current_contact = managers.job:current_contact_id()
	self._singleplayer = Global.game_settings.single_player
	
	local bg_font = tweak_data.menu.pd2_massive_font
	local title_font = tweak_data.menu.pd2_large_font
	local content_font = tweak_data.menu.pd2_medium_font
	local text_font = tweak_data.menu.pd2_small_font
	
	local bg_font_size = tweak_data.menu.pd2_massive_font_size
	local title_font_size = tweak_data.menu.pd2_large_font_size
	local content_font_size = tweak_data.menu.pd2_medium_font_size
	local text_font_size = tweak_data.menu.pd2_small_font_size
	
	local interupt_stage = managers.job:interupt_stage()
	
	
	-- local saferect_shape = self._backdrop:saferect_shape()
	
	self._background_layer_one = self._backdrop:get_new_background_layer()
	self._background_layer_two = self._backdrop:get_new_background_layer()			-- allocating layers in MenuBackdropGUI, calendar do not use layer two or three, but still uses 3 layers
	self._background_layer_three = self._backdrop:get_new_background_layer()		-- other gui elements still uses these
	self._foreground_layer_one = self._backdrop:get_new_foreground_layer()
	
	self._backdrop:set_panel_to_saferect( self._background_layer_one )
	self._backdrop:set_panel_to_saferect( self._foreground_layer_one )
	
	self._ready_slot_panel = self._foreground_layer_one:panel( { name="player_slot_panel", w=self._foreground_layer_one:w()/2, h=text_font_size*4+20 } )
	self._ready_slot_panel:set_bottom( self._foreground_layer_one:h() - 70 )
	self._ready_slot_panel:set_right( self._foreground_layer_one:w() )
	
	
	if( not self._singleplayer ) then
		local voice_icon, voice_texture_rect = tweak_data.hud_icons:get_icon_data( "mugshot_talk" )
		for i = 1, 4 do
			local color_id = i -- managers.criminals:character_color_id_by_name( managers.criminals:character_workname_by_peer_id( i ) )
			local color = tweak_data.chat_colors[ color_id ]
			-- local color = tweak_data.chat_colors[i]
			local slot_panel = self._ready_slot_panel:panel( { name="slot_"..tostring(i), h=text_font_size, y=(i-1)*text_font_size+10, x=10, w=self._ready_slot_panel:w()-20 } )
			
			local criminal = slot_panel:text( { name="criminal", font_size=text_font_size, font=text_font, color=color, text="HOXTON", blend_mode="add", align="left", vertical="center" } )
			local voice  = slot_panel:bitmap( { name="voice", texture=voice_icon, visible=false, layer=2, texture_rect=voice_texture_rect, w=voice_texture_rect[3], h=voice_texture_rect[4], color=color, x=10 } )
			local name   = slot_panel:text( { name="name", text=managers.localization:text( "menu_lobby_player_slot_available" ) .. "  ", font=text_font, font_size=text_font_size, color=color:with_alpha(0.5), align="left", vertical="center", w=256, h=text_font_size, layer=1, blend_mode="add" } )
			local status = slot_panel:text( { name="status", visible=true, text="  ", font=text_font, font_size=text_font_size, align="left", vertical="center", w=256, h=text_font_size, layer=1, blend_mode="add", color=tweak_data.screen_colors.text:with_alpha(0.5) } )
			-- local invert = slot_panel:rect( { name="invert", visible=false, w=256, h=text_font_size, layer=0, color=color:with_alpha(0.5) } )
			
			local _, _, w, _ = criminal:text_rect()
			voice:set_left( w + 2 )
			criminal:set_w( w )
			criminal:set_align( "right" )
			criminal:set_text( "" )
			
			name:set_left( voice:right() + 2 )
			local x, y, w, h = name:text_rect()
			status:set_left( name:x() + w)
		end
		
		BoxGuiObject:new( self._ready_slot_panel, { sides = { 1, 1, 1, 1 } } )
	end
	
	if( not managers.job:has_active_job() ) then
		return
	end
	
	self._current_contact_data = managers.job:current_contact_data()
	self._current_level_data = managers.job:current_level_data()
	self._current_stage_data = managers.job:current_stage_data()
	self._current_job_data = managers.job:current_job_data()
	
	self._job_class = self._current_job_data and self._current_job_data.jc or 0
	local contact_gui = self._background_layer_two:gui( self._current_contact_data.assets_gui, {} )
	
	local contact_pattern = contact_gui:has_script() and contact_gui:script().pattern
	if( contact_pattern ) then
		self._backdrop:set_pattern( contact_pattern, 0.10, "add" )
	end
	
	-- local contact_gui_id = Idstring( "guis/mission_briefing/preload_contact_"..tostring(self._current_contact) )
	-- local stage_gui_id = Idstring( "guis/mission_briefing/preload_stage_"..tostring(self._current_stage_data.level_id) )
	
	-- self._preloaded_contact_gui = self._workspace:panel():gui( contact_gui_id, {} )
	-- self._preloaded_stage_gui = self._workspace:panel():gui( stage_gui_id, {} )
	
	local padding_y = 70
	-------------------------- Paygrade
	self._paygrade_panel = self._background_layer_one:panel( {h=2*35, w=6*35, y=padding_y} )
	
	local pg_text = self._foreground_layer_one:text( { name="pg_text", text=utf8.to_upper( managers.localization:text("cn_menu_contract_paygrade_header") ) .. " ", y=padding_y, h=32, align="right", vertical="center", font_size=content_font_size, font=content_font, color=tweak_data.screen_colors.text } )
	local _, _, w, h = pg_text:text_rect()
	pg_text:set_size( w, h )
	-- self._paygrade_panel:bitmap( { name="paygrade_icon", texture="guis/textures/pd2/mission_briefing/difficulty_icons", texture_rect={ 32, 0, 32, 32 }, x=0, y=0, w=32, h=32 } )
	-- local paygrade = math.ceil( self._job_class / 10 )
	-- local difficulty = Global.game_settings.difficulty or "easy"
	
	local job_stars = managers.job:current_job_stars()
	local job_and_difficulty_stars = managers.job:current_job_and_difficulty_stars()
	local difficulty_stars = job_and_difficulty_stars - job_stars
	
	
	local filled_star_rect = { 0, 32, 32, 32 }
	local empty_star_rect = { 32, 32, 32, 32 }
	
	local num_stars = 0
	local x = 0
	local y = 4
	local star_size = 18
	
	local risk_color = tweak_data.screen_colors.risk
	local level_data = { texture="guis/textures/pd2/mission_briefing/difficulty_icons", texture_rect=filled_star_rect, w=16, h=16, color=tweak_data.screen_colors.text, alpha=1 }
	local risk_data = { texture="guis/textures/pd2/crimenet_skull", w=16, h=16, color=risk_color, alpha=1 }
	--[[for i = 1, job_and_difficulty_stars do
		local is_risk = i > job_stars
		local star_data = is_risk and risk_data or level_data
		
		local star = self._paygrade_panel:bitmap( star_data )
		star:set_position( x, y )
		x = x + star_size
		num_stars = num_stars + 1
	end]]
	
	
	for i = 1, 10 do
		local alpha = (i>job_and_difficulty_stars) and 0.25 or 1
		local color = ((i>job_and_difficulty_stars) or (i<=job_stars)) and Color.white or tweak_data.screen_colors.risk
		self._paygrade_panel:bitmap( { texture="guis/textures/pd2/skilltree/locked", x=x, y=y, w=16, h=16, alpha=1, color=color, alpha=alpha } )
		x = x + star_size
		num_stars = num_stars + 1
	end

	--[[
	for i = 1, math.max( 0, ( tweak_data:difficulty_to_index( difficulty ) or 0 ) - 2 ) do
		self._paygrade_panel:bitmap( { texture="guis/textures/pd2/mission_briefing/difficulty_icons", texture_rect=filled_star_rect, color=tweak_data.screen_color_red, x=x, y=y, w=32, h=32, alpha=1 } )
		
		x = x + star_size
		num_stars = num_stars + 1
	end
	]]
	self._paygrade_panel:set_w( 10  * star_size )
	self._paygrade_panel:set_right( self._background_layer_one:w() )
	
	
	pg_text:set_right( self._paygrade_panel:left() )
	
	
	-------------------------- Job Schedule
	self._job_schedule_panel = self._background_layer_one:panel( {h=70, w=self._background_layer_one:w()/2} )
	
	self._job_schedule_panel:set_right( self._foreground_layer_one:w() )
	self._job_schedule_panel:set_top( padding_y + content_font_size + 15 ) -- self._paygrade_panel:bottom() + 90 )
	
	-- Set up some info for interupted stage
	if interupt_stage then
		self._job_schedule_panel:set_alpha( 0.2 )
		
		self._interupt_panel = self._background_layer_one:panel( {h=125, w=self._background_layer_one:w()/2} )
		local interupt_text = self._interupt_panel:text( { name="job_text", text=utf8.to_upper( managers.localization:text("menu_escape") ), h=80, align="left", vertical="top", font_size=70, font=bg_font, color=tweak_data.screen_colors.important_1, layer = 5 } )
		local _,_,w,h = interupt_text:text_rect()
		interupt_text:set_size( w, h )
		interupt_text:rotate( -15 )
		interupt_text:set_center( self._interupt_panel:w()/2, self._interupt_panel:h()/2 )
		self._interupt_panel:set_shape( self._job_schedule_panel:shape() )		
	end
	
	local num_stages = self._current_job_data and #self._current_job_data.chain or 0
	local day_color = tweak_data.screen_colors.item_stage_1
	
	local js_w = self._job_schedule_panel:w() / 7
	local js_h = self._job_schedule_panel:h()
	for i=1, 7 do
		local day_font = text_font
		local day_font_size = text_font_size
		day_color = tweak_data.screen_colors.item_stage_1
		
		if i > num_stages then
			day_color = tweak_data.screen_colors.item_stage_3
		-- elseif i < managers.job:current_stage() then
		elseif i == managers.job:current_stage() then
			day_font = content_font
			day_font_size = content_font_size
		end
		-- day_color = tweak_data.screen_color_white:with_alpha( ( (i > num_stages) and 0.1 ) or ( (i < managers.job:current_stage()) and 0.5 ) or 1 )
		-- self._job_schedule_panel:bitmap( { name="day_rect_"..tostring(i), texture="guis/textures/pd2/mission_briefing/calendar_box", x=1+((i-1)%7)*78, y=10+math.floor((i-1)/7)*55, w=73, h=50, color=day_color, blend_mode="add" } )
		
		--[[
		local poly = self._job_schedule_panel:polyline( { name="day_poly_"..tostring(i), color=day_color, blend_mode="add", x=1+((i-1)%7)*78, y=10+math.floor((i-1)/7)*55, w=73, h=50 } )
		poly:set_points( { Vector3( 0, 0 ), Vector3( 73, 0 ), Vector3( 73, 50 ), Vector3( 0, 50 ) } )
		poly:set_closed( true )
		
		poly = self._job_schedule_panel:polyline( { name="day_poly2_"..tostring(i), color=day_color:with_alpha(day_color.alpha*0.5), blend_mode="add", x=1+((i-1)%7)*78, y=10+math.floor((i-1)/7)*55, w=73, h=50 } )
		poly:set_points( { Vector3( 1, 1 ), Vector3( 72, 1 ), Vector3( 72, 49 ), Vector3( 1, 49 ) } )
		poly:set_closed( true )
		]]
		
		local day_text = self._job_schedule_panel:text( { name="day_"..tostring(i), text=utf8.to_upper( managers.localization:text("menu_day_short", {day=tostring(i)}) ), align="center", vertical="center", font_size=day_font_size, font=day_font, w=js_w, h=js_h, color=day_color, blend_mode="add" } )
		
		day_text:set_left( (i==1 and 0) or self._job_schedule_panel:child( "day_"..tostring(i-1) ):right() )
	end
	
	for i=1, managers.job:current_stage() or 0 do
		local stage_marker = self._job_schedule_panel:bitmap( { name="stage_done_" .. tostring(i), texture="guis/textures/pd2/mission_briefing/calendar_xo", texture_rect={i==managers.job:current_stage() and 80 or 0, 0, 80, 64}, w=80, h=64, layer=1, rotation=math.rand(-10, 10) } )
		stage_marker:set_center( self._job_schedule_panel:child("day_"..tostring(i)):center() )
		stage_marker:move( math.random(4)-2, math.random(4)-2 )
	end
	
	if( managers.job:has_active_job() ) then
		local payday_stamp = self._job_schedule_panel:bitmap( { name="payday_stamp", texture="guis/textures/pd2/mission_briefing/calendar_xo", texture_rect={ 80*2, 0, 96, 64 }, w=96, h=64, layer=2, rotation=math.rand(-5, 5) } )
		payday_stamp:set_center( self._job_schedule_panel:child("day_"..tostring(num_stages)):center() )
		payday_stamp:move( math.random(4)-2-7, math.random(4)-2+8 )
		
		if( payday_stamp:rotation() == 0 ) then
			payday_stamp:set_rotation( 1 )
		end
	end
	
	local job_overview_text = self._foreground_layer_one:text( { name="job_overview_text", text=utf8.to_upper( managers.localization:text("menu_job_overview") ), h=content_font_size, align="left", vertical="bottom", font_size=content_font_size, font=content_font, color=tweak_data.screen_colors.text } )
	local _, _, w, h = job_overview_text:text_rect()
	job_overview_text:set_size( w, h )
	job_overview_text:set_leftbottom( self._job_schedule_panel:left(), pg_text:bottom() )
	
	if pg_text:left() <= job_overview_text:right() + 15 then
		pg_text:move( 0, -pg_text:h() )
		self._paygrade_panel:move( 0, -pg_text:h() )
	end
	
	
	local job_text = self._foreground_layer_one:text( { name="job_text", text=utf8.to_upper(managers.localization:text(self._current_contact_data.name_id) .. ": " .. managers.localization:text(self._current_job_data.name_id)), align="left", vertical="center", font_size=title_font_size, font=title_font, color=tweak_data.screen_colors.text } )
	local _, _, w, h = job_text:text_rect()
	job_text:set_size( w, h )
	
	local big_text = self._background_layer_three:text( { name="job_text", text=utf8.to_upper(managers.localization:text(self._current_job_data.name_id)), align="left", vertical="top", font_size=bg_font_size, font=bg_font, color=tweak_data.screen_colors.button_stage_1, alpha=0.4 } )
	local _, _, w, h = big_text:text_rect()
	big_text:set_size( w, h )
	big_text:set_world_center_y( self._foreground_layer_one:child("job_text"):world_center_y() )
	big_text:set_world_x( self._foreground_layer_one:child("job_text"):world_x() )
	big_text:move( -13, 9 )
	
	self._backdrop:animate_bg_text( big_text )
	
	--[[
	local briefing_dialog = managers.job:current_stage_data().briefing_dialog or managers.job:current_level_data().briefing_dialog
	if briefing_dialog then
		self._delayed_dialog = true
		managers.enemy:add_delayed_clbk( "HUDMissionBriefing_brf_dialog", 
			function()
				Application:debug(managers.job:current_level_data().briefing_dialog)
				
				self._delayed_dialog = nil
				managers.dialog:queue_dialog( managers.job:current_level_data().briefing_dialog, { skip_idle_check=true } ) -- managers.job:current_level_data().briefing_dialog, {} ) 
			end, Application:time() + 2 )
	end]]
end