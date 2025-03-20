function HUDTeammate:init( i, teammates_panel, is_player, width )
	self._id = i
	local small_gap = 8
	local gap = 0
	local pad = 4
	
	local main_player = i == HUDManager.PLAYER_PANEL
	self._main_player = main_player

	local names = { "WWWWWWWWWWWWQWWW", "AI Teammate", "FutureCatCar", "WWWWWWWWWWWWQWWW" }

	-- local teammate_panel = teammates_panel:panel( { name =""..i, w = math.round(pw), x = math.floor((pw + small_gap) * (i-1) + (i == 4 and gap or 0)) } )
	local teammate_panel = teammates_panel:panel( { visible = false, name =""..i, w = math.round(width), x = 0 } )
	if not main_player then
		teammate_panel:set_h( 84 )
		teammate_panel:set_bottom( teammates_panel:h() )
	end
	self._player_panel = teammate_panel:panel( { name ="player" } ) -- A panel containing player only components
	-- self._sides = BoxGuiObject:new( self._player_panel, { sides = { 1, 1, 1, 1 } } )
	-- teammate_panel:set_debug( true )
		
	local name = teammate_panel:text( { name = "name", text=" "..utf8.to_upper(names[i]), layer = 1, color = Color.white, y = 0, vertical = "bottom", font_size = tweak_data.hud_players.name_size, font = tweak_data.hud_players.name_font } )
	local _,_,name_w,_ = name:text_rect()
	managers.hud:make_fine_text( name )
	-- name:set_h( name:h() - 2 ) -- Warning, packing the string height 
	-- name:set_leftbottom( 0, teammate_panel:h() + 1 )
	name:set_leftbottom( name:h(), teammate_panel:h() - (64 + 6) )
	
	if not main_player then
		name:set_x( 48 + name:h() + 4 )
		name:set_bottom( teammate_panel:h() - (24 + 6) )
	end
	
	local tabs_texture = "guis/textures/pd2/hud_tabs"
	-- local bg_rect = { 0, 45, 67, 19 }
	local bg_rect = { 84, 0, 44, 32 }
	local cs_rect = { 84, 34, 19, 19 }
	local csbg_rect = { 105, 34, 19, 19 }
	
	local bg_color = Color.white/3
	
	-- teammate_panel:rect( { name = "name_bg", visible = true, layer = 0, color = bg_color, x = name:x(), y = name:y() - 1 , w = name_w + 4, h = name:h() - 1 } )
	teammate_panel:bitmap( { name = "name_bg", texture = tabs_texture, texture_rect = bg_rect, visible = true, layer = 0, color = bg_color, x = name:x(), y = name:y() -1, w = name_w + 4, h = name:h() } )
	-- teammate_panel:rect( { name = "callsign", visible = true, color = tweak_data.chat_colors[i]:with_alpha( 0.68 ), blend_mode = "normal",  x = name_w + 4, y = name:y() - 1, w = teammate_panel:w() - name_w - 4, h = name:h() - 1 } )
	-- teammate_panel:rect( { name = "callsign", visible = true, color = tweak_data.chat_colors[i]:with_alpha( 0.68 ), blend_mode = "normal",  x = 0, y = name:y() - 1, w = name:h() - 1, h = name:h() - 1 } )
	teammate_panel:bitmap( { name = "callsign_bg", texture = tabs_texture, texture_rect = csbg_rect, layer = 0, color = bg_color, blend_mode = "normal", x = name:x() - name:h(), y = name:y()+1, w = name:h() - 2, h = name:h() - 2 } )
	teammate_panel:bitmap( { name = "callsign", texture = tabs_texture, texture_rect = cs_rect, layer = 1, color = tweak_data.chat_colors[i]:with_alpha( 1 ), blend_mode = "normal",  x = name:x() - name:h(), y = name:y()+1, w = name:h() - 2, h = name:h() - 2 } )
		
	local box_ai_bg = teammate_panel:bitmap( { visible = false, name = "box_ai_bg", texture = "guis/textures/pd2/box_ai_bg", color = Color.white, alpha = 0, y = 0, w = teammate_panel:w() } )
	box_ai_bg:set_bottom( name:top() )
	local box_bg = teammate_panel:bitmap( { visible = false, name = "box_bg", texture = "guis/textures/pd2/box_bg", color = Color.white, y = 0, w = teammate_panel:w() } )
	box_bg:set_bottom( name:top() ) 
		
	-- local data = tweak_data.hud_icons.mask_clown1
	local texture, rect = tweak_data.hud_icons:get_icon_data( "pd2_mask_"..i )
	-- local y = teammate_panel:h()/2 -- - rect[4]/2
	local size = 64 -- rect[3]*1.25
	local mask_pad = 2
	local mask_pad_x = 3
	local y = teammate_panel:h() - name:h() - size + mask_pad
	local mask = teammate_panel:bitmap( { visible = false, name = "mask", layer = 1, color = Color.white, texture = texture, texture_rect = rect, x = -mask_pad_x, w = size, h = size, y = y } )
	
	--[[
		local v2 = true
		local weapon = teammate_panel:bitmap( { name = "weapon", visible = false and not v2, layer = 1, color = Color.white, w = 48, h = 64, x = mask:right() - 10, y = y } )
		-- weapon:set_debug( true )
		weapon:set_bottom( mask:bottom() + 11 - 3 ) -- 19 ) -- 19 is from height of health_bg + offset from bottom
		local center_y_line = math.round( weapon:center_y() )
			
		local weapon_panel1 = teammate_panel:panel( { name = "weapon_panel1", visible = true and not v2, layer = 3, w = 64, h = 64, x = mask:right() + pad, y = y } )
		weapon_panel1:set_center( weapon:center() )
		-- weapon_panel1:set_debug( true )
		-- weapon_panel1:bitmap( { halign = "scale", valign = "scale", name = "bg", texture = "guis/textures/pd2/weapons", texture_rect = { 64, 0, 64, 64 }, blend_mode = "normal" } )
		weapon_panel1:bitmap( { halign = "scale", valign = "scale", name = "weapon", texture = "guis/textures/pd2/weapons", texture_rect = { 0, 64, 64, 64 }, layer = 1 } )
			
		local weapon_panel2 = teammate_panel:panel( { name = "weapon_panel2", visible = true and not v2, layer = 3, w = 64, h = 64, x = mask:right() + pad, y = y } )
		weapon_panel2:set_center( weapon:center() )
		-- weapon_panel2:set_position( weapon_panel2:x() + 8, weapon_panel2:y() - 8 )
		-- weapon_panel2:set_debug( true )
		-- weapon_panel2:bitmap( { halign = "scale", valign = "scale", name = "bg", texture = "guis/textures/pd2/weapons", texture_rect = { 64, 0, 64, 64 }, blend_mode = "normal" } )
		weapon_panel2:bitmap( { halign = "scale", valign = "scale", name = "weapon", color = Color.white, alpha = 0, texture = "guis/textures/pd2/weapons", texture_rect = { 0, 0, 64, 64 }, layer = 1 } ) -- , texture = "guis/textures/pd2/weapons", texture_rect = { 64, 0, 64, 64 } } )
				
		local ammo_pad = self._player_panel:bitmap( { name = "ammo_pad", visible = true and not v2, layer = 2, texture = "guis/textures/ammocounter", x = weapon:right() - 11, y = weapon_panel1:y() } )
		ammo_pad:set_center_y( weapon:center_y() )
		-- ammo_pad:set_x( math.round( ammo_pad:x() ) )
		-- ammo_pad:set_y( math.round( ammo_pad:y() ) )
		local ammo_total = self._player_panel:text( { name = "ammo_total", visible = true and not v2, text=""..math.random( 150 ), color = Color.black, blend_mode= "normal", layer = 3, w = 44, h = 64, x = mask:right() + pad, y = y, vertical = "center", align = "right", font_size = 29, font = tweak_data.hud_players.ammo_font } )
		ammo_total:set_center( ammo_pad:center() )
		ammo_total:set_y( math.round( ammo_total:y() + 1 ) )
			
		local ammo_clip = self._player_panel:rect( { name = "ammo_clip", visible = true and not v2, layer = 3, color = Color.black:with_alpha( 1 ), w = 4, h = 21, x = ammo_pad:x() + 14, y = ammo_pad:y() + 22 } )
		ammo_clip:set_bottom( ammo_pad:y() + 43 )		
	
		local ammo_pad_secondary = teammate_panel:bitmap( { name = "ammo_pad_secondary", color = Color( 0.75, 0.5, 0.5, 0.5 ), visible = is_player and not v2, layer = 0, texture = "guis/textures/ammocounter", w = 52, h = 52, x = weapon:right() - 8, y = weapon_panel1:y() } )
		ammo_pad_secondary:set_center_x( ammo_pad:right() + 3 )
		ammo_pad_secondary:set_center_y( ammo_pad:center_y() )
	
		local ammo_total_secondary = teammate_panel:text( { name = "ammo_total_secondary", text="999", color = Color.black:with_alpha( 0.75 ), visible = is_player and not v2, blend_mode= "normal", layer = 1, w = 38, h = 52, x = mask:right() + pad, y = y, vertical = "center", align = "right", font_size = 20, font = tweak_data.hud_players.ammo_font } )
		ammo_total_secondary:set_center( ammo_pad_secondary:center() ) -- , ammo_total_secondary:center_y() )
		ammo_total_secondary:set_y( math.round( ammo_total_secondary:y() ) )
			
		-- local ammo_total = teammate_panel:rect( { name = "ammo_total", visible = true, layer = 1, color = Color.black:with_alpha( 0.0 ), w = 48, h = 48, x = weapon:x(), y = weapon:y() } )
		-- ammo_total:set_bottom( mask:bottom() )
		-- local ammo_clip = teammate_panel:text( { name = "ammo_clip", text="Q", color = Color.white, layer = 5, w = 48, h = 48, x = mask:right() + pad, y = y, vertical = "bottom", align = "right", font_size = 24, font = tweak_data.hud_players.name_font } )
		-- ammo_clip:set_bottom( mask:bottom() )
		
	]]
									
	-- local health_bg = teammate_panel:rect( { name = "health_bg", layer = 1, color = Color( 0.5, 0.5, 0.5 ), w = teammate_panel:w() - weapon:left() , h = 12, x = weapon:left(), y = mask:y() } )
	-- local health = teammate_panel:rect( { name = "health", layer = 2, color = Color.green, w = (health_bg:w()-2)/2, h =  health_bg:h()-2, x = health_bg:x() + 1, y = health_bg:y() + 1 } )
	-- local armor = teammate_panel:rect( { name = "armor", layer = 3, color = Color.white, w = (health_bg:w()-2)/2, h =  health_bg:h()-2, x = (health_bg:x())+health_bg:w()/2, y = health_bg:y() + 1 } )
	
	--[[
	local bitmap_w = 236
	-- 2, 18, 232, 11
	local health_panel = self._player_panel:panel( { visible = false, name = "health_panel", layer = 1, w = teammate_panel:w() - weapon:left(), x = weapon:left(), y = mask:y() } )
	local health_bg = health_panel:bitmap( { name = "health_bg", texture = "guis/textures/pd2/healthshield", texture_rect = { 0, 0, bitmap_w, 16 }, color = Color( 1, 1, 1 ), w = (health_panel:w()) - weapon:w(), x = weapon:w() } )
	health_panel:set_height( health_bg:h() )
	-- health_bg:set_bottom( mask:bottom() - 4 )
	health_panel:set_top( mask:top() + 2 )
	health_bg:set_h( health_bg:h() - 4 )
	health_bg:set_y( 4 )
	-- local health = teammate_panel:bitmap( { name = "health", texture = "guis/textures/pd2/healthshield", texture_rect = { 2, 18, bitmap_w/2, 11 }, layer = 2, color = Color( 102/256, 204/256, 51/256 ), w = (health_bg:w()-4)/2, x = health_bg:x() + 2, y = health_bg:y() + 2 } )
	local health = health_panel:bitmap( { name = "health", texture = "guis/textures/pd2/healthshield", texture_rect = { 0, 16, bitmap_w, 16 }, layer = 2, color = Color.white, w = (health_panel:w()) - weapon:w(), x = weapon:w(), y = 4, h = health_panel:h() - 4, layer = 2 } )
	-- local armor = teammate_panel:bitmap( { name = "armor", texture = "guis/textures/pd2/healthshield", texture_rect = { 2 + bitmap_w/2, 18, bitmap_w/2, 11 }, layer = 3, color = Color( 34/256, 155/256, 205/256 ), w = (health_bg:w()-4)/2, x = (health_bg:x())+health_bg:w()/2, y = health_bg:y() + 2 } )
	
	local revives_left = health_panel:text( { name = "revives_left", visible = true, text= "", layer = 2, color = Color.white, w = weapon:w() - 4, x = 0, y = 4, h = health_panel:h() - 4, vertical = "center", align = "right", font_size = tweak_data.hud.small_font_size, font = tweak_data.hud.small_font } )
	
	
	local armor = health_panel:bitmap( { name = "armor", texture = "guis/textures/pd2/healthshield", texture_rect = { 0, 32, bitmap_w, 16 }, color = Color.white, w = (health_panel:w()), y = 0, h = 4, layer = 1 } )
	
	-- self._healtharmor_dividers = {}
	
	local healtharmor_divider
	
	for i=1, tweak_data.player.damage.ARMOR_STEPS do
		healtharmor_divider = health_panel:bitmap( { name = "healtharmor_divider_"..i, texture = "guis/textures/pd2/healthshield_divider", layer = 4, color = Color( 1, 1, 1 ), x = armor:left(), y = armor:y(), h = armor:h() } )
		healtharmor_divider:set_center_x( (i / tweak_data.player.damage.ARMOR_STEPS) * health_panel:w() )
	end
	
	-- local healtharmor_divider = health_panel:bitmap( { name = "healtharmor_divider", texture = "guis/textures/pd2/healthshield_divider", layer = 4, color = Color( 1, 1, 1 ), x = armor:left(), y = armor:y() } )
	]]
	
	local radial_size = main_player and 64 or 48
	
		
	----- RADIAL HEALTH
	local radial_health_panel = self._player_panel:panel( { name = "radial_health_panel", layer = 1, w = radial_size + 4, h = radial_size + 4, x = 0, y = mask:y() } )
	radial_health_panel:set_bottom( self._player_panel:h() )
	-- radial_health_panel:set_debug( true )
	
	local radial_bg = radial_health_panel:bitmap( { name = "radial_bg", texture = "guis/textures/pd2/hud_radialbg", alpha = 1, w = radial_health_panel:w(), h = radial_health_panel:h(), layer = 0 } )
	
	local radial_health = radial_health_panel:bitmap( { name = "radial_health", texture = "guis/textures/pd2/hud_health", render_template = "VertexColorTexturedRadial", blend_mode = "add", alpha = 1, w = radial_health_panel:w(), h = radial_health_panel:h(), layer = 2 } )
	radial_health:set_color( Color( 1, 1, 0, 0 ) )
	
	local radial_shield = radial_health_panel:bitmap( { name = "radial_shield", texture = "guis/textures/pd2/hud_shield", render_template = "VertexColorTexturedRadial", blend_mode = "add", alpha = 1, w = radial_health_panel:w(), h = radial_health_panel:h(), layer = 1 } )
	radial_shield:set_color( Color( 1, 1, 0, 0 ) )
	
	local damage_indicator = radial_health_panel:bitmap( { name = "damage_indicator", texture = "guis/textures/pd2/hud_radial_rim", blend_mode = "add", alpha = 0, w = radial_health_panel:w(), h = radial_health_panel:h(), layer = 1 } )
	damage_indicator:set_color( Color( 1, 1, 1, 1 ) )
	
	local x,y,w,h = radial_health_panel:shape()
	teammate_panel:bitmap( { name = "condition_icon", layer = 4, visible = false, color = Color.white, x = x, y = y, w = w, h = h } )
	local condition_timer = teammate_panel:text( { name = "condition_timer", visible = false, text="000", layer = 5, color = Color.white, y = 0, align = "center", vertical = "center", font_size = tweak_data.hud_players.timer_size, font = tweak_data.hud_players.timer_font } )
	condition_timer:set_shape( radial_health_panel:shape() )
	
	----- Weapon panels
	local w_selection_w = 13
	local weapon_panel_w = 80
	local extra_clip_w = 4
	local ammo_text_w = (weapon_panel_w - w_selection_w)/2
	
	local font_bottom_align_correction = 3
	
	local tabs_texture = "guis/textures/pd2/hud_tabs"
	local bg_rect = { 0, 0, 67, 32 }
	local weapon_selection_rect1 = { 67, 0, 13, 32 }
	local weapon_selection_rect2 = { 67, 32, 13, 32 }
	
	local weapons_panel = self._player_panel:panel( { name = "weapons_panel", visible = true, layer = 0, w = weapon_panel_w, h = radial_health_panel:h(), x = radial_health_panel:right() + 4, y = radial_health_panel:y() } )

	local primary_weapon_panel = weapons_panel:panel( { name = "primary_weapon_panel", visible = false, layer = 1, w = weapon_panel_w, h = 32, x = 0, y = 0 } )
	primary_weapon_panel:bitmap( { name = "bg", texture = tabs_texture, texture_rect = bg_rect, visible = true, layer = 0, color = bg_color, w = weapon_panel_w, x = 0 } )
	primary_weapon_panel:text( { name = "ammo_clip", visible = main_player and true, text="0"..math.random( 40 ), color = Color.white, blend_mode= "normal", layer = 1, w = ammo_text_w + extra_clip_w, h = primary_weapon_panel:h(), x = 0, y = 0 + font_bottom_align_correction, vertical = "bottom", align = "center", font_size = 32, font = tweak_data.hud_players.ammo_font } )

	primary_weapon_panel:text( { name = "ammo_total", visible = true, text="000", color = Color.white, blend_mode= "normal", layer = 1, w = ammo_text_w - extra_clip_w, h = primary_weapon_panel:h(), x = ammo_text_w + extra_clip_w, y = 0 + font_bottom_align_correction, vertical = "bottom", align = "center", font_size = 24, font = tweak_data.hud_players.ammo_font } )
	primary_weapon_panel:bitmap( { name = "weapon_selection", texture = tabs_texture, texture_rect = weapon_selection_rect1, visible = main_player and true, layer = 1, color = Color.white, w = w_selection_w, x = weapon_panel_w - w_selection_w } )
	
	if not main_player then
		local ammo_total = primary_weapon_panel:child( "ammo_total" )
		-- ammo_total:set_debug( true )
		local _x,_y,_w,_h = ammo_total:text_rect()
		primary_weapon_panel:set_size( _w + 8, _h )
		ammo_total:set_shape( 0, 0, primary_weapon_panel:size() )
		ammo_total:move( 0, font_bottom_align_correction )
		
		primary_weapon_panel:set_x( 0 )
		primary_weapon_panel:set_bottom( weapons_panel:h() )
		local eq_rect = { 84, 0, 44, 32 }
		primary_weapon_panel:child( "bg" ):set_image( tabs_texture, eq_rect[1], eq_rect[2], eq_rect[3], eq_rect[4] )
		primary_weapon_panel:child( "bg" ):set_size( primary_weapon_panel:size() )
	end
	
	local secondary_weapon_panel = weapons_panel:panel( { name = "secondary_weapon_panel", visible = false, layer = 1, w = weapon_panel_w, h = 32, x = 0, y = primary_weapon_panel:bottom() } )
	secondary_weapon_panel:bitmap( { name = "bg", texture = tabs_texture, texture_rect = bg_rect, visible = true, layer = 0, color = bg_color, w = weapon_panel_w, x = 0 } )
	secondary_weapon_panel:text( { name = "ammo_clip", visible = main_player and true, text=""..math.random( 40 ), color = Color.white, blend_mode= "normal", layer = 1, w = ammo_text_w + extra_clip_w, h = secondary_weapon_panel:h(), x = 0, y = 0 + font_bottom_align_correction, vertical = "bottom", align = "center", font_size = 32, font = tweak_data.hud_players.ammo_font } )
	secondary_weapon_panel:text( { name = "ammo_total", visible = true, text="000", color = Color.white, blend_mode= "normal", layer = 1, w = ammo_text_w - extra_clip_w, h = secondary_weapon_panel:h(), x = ammo_text_w + extra_clip_w, y = 0 + font_bottom_align_correction, vertical = "bottom", align = "center", font_size = 24, font = tweak_data.hud_players.ammo_font } )
	secondary_weapon_panel:bitmap( { name = "weapon_selection", texture = tabs_texture, texture_rect = weapon_selection_rect2, visible = main_player and true, layer = 1, color = Color.white, w = w_selection_w, x = weapon_panel_w - w_selection_w } )
	secondary_weapon_panel:set_bottom( weapons_panel:h() )
	
	if not main_player then
		local ammo_total = secondary_weapon_panel:child( "ammo_total" )
		-- ammo_total:set_debug( true )
		local _x,_y,_w,_h = ammo_total:text_rect()
		secondary_weapon_panel:set_size( _w + 8, _h )
		ammo_total:set_shape( 0, 0, secondary_weapon_panel:size() )
		ammo_total:move( 0, font_bottom_align_correction )
		
		secondary_weapon_panel:set_x( primary_weapon_panel:right() )
		secondary_weapon_panel:set_bottom( weapons_panel:h() )
		local eq_rect = { 84, 0, 44, 32 }
		secondary_weapon_panel:child( "bg" ):set_image( tabs_texture, eq_rect[1], eq_rect[2], eq_rect[3], eq_rect[4] )
		secondary_weapon_panel:child( "bg" ):set_size( secondary_weapon_panel:size() )
	end
	
	----- Deployable equipment
	local eq_rect = { 84, 0, 44, 32 }
	local temp_scale = 1
	
	local deployable_equipment_panel = self._player_panel:panel( { name = "deployable_equipment_panel", layer = 1, w = 48, h = 32, x = weapons_panel:right() + 4, y = weapons_panel:y() } )
	-- deployable_equipment_panel:rect( { name = "bg", visible = true, layer = 0, color = bg_color, w = deployable_equipment_panel:w(), x = 0 } )
	deployable_equipment_panel:bitmap( { name = "bg", texture = tabs_texture, texture_rect = eq_rect, visible = true, layer = 0, color = bg_color, w = deployable_equipment_panel:w(), x = 0 } )
	local equipment = deployable_equipment_panel:bitmap( { name = "equipment", visible = false, layer = 1, color = Color.white, w = deployable_equipment_panel:h() * temp_scale, h = deployable_equipment_panel:h() * temp_scale, x = -(deployable_equipment_panel:h()*temp_scale - deployable_equipment_panel:h())/2, y = -(deployable_equipment_panel:h()*temp_scale - deployable_equipment_panel:h())/2 } )
	local amount = deployable_equipment_panel:text( { name = "amount", visible = false, text = tostring(12), font = "fonts/font_medium_mf", font_size = 22, color = Color.white, align = "right", vertical = "center", layer = 2, x = -2, y = 2, w = deployable_equipment_panel:w(), h = deployable_equipment_panel:h() } )
	-- deployable_equipment_panel:set_debug( true )
	if not main_player then
		local scale = 0.75
		-- deployable_equipment_panel:set_debug( true )
		deployable_equipment_panel:set_size( deployable_equipment_panel:w() * 0.9, deployable_equipment_panel:h() * scale )
		equipment:set_size( equipment:w() * scale, equipment:h() * scale )
		equipment:set_center_y( deployable_equipment_panel:h()/2 )
		equipment:set_x( equipment:x() + 4 )
		amount:set_center_y( deployable_equipment_panel:h()/2 )
		amount:set_right( deployable_equipment_panel:w() - 4 )
		deployable_equipment_panel:set_x( weapons_panel:right() - 8 )
		deployable_equipment_panel:set_bottom( weapons_panel:bottom() )
		local bg = deployable_equipment_panel:child( "bg" )
		bg:set_size( deployable_equipment_panel:size() )
	end
	
	----- Cable ties
	local texture, rect = tweak_data.hud_icons:get_icon_data( tweak_data.equipments.specials.cable_tie.icon )
	local cable_ties_panel = self._player_panel:panel( { name = "cable_ties_panel", visible = true, layer = 1, w = 48, h = 32, x = weapons_panel:right() + 4, y = weapons_panel:y() } )
	cable_ties_panel:bitmap( { name = "bg", texture = tabs_texture, texture_rect = eq_rect, visible = true, layer = 0, color = bg_color, w = deployable_equipment_panel:w(), x = 0 } )
	local cable_ties = cable_ties_panel:bitmap( { name = "cable_ties", visible = false, texture = texture, texture_rect = rect, layer = 1, color = Color.white, w = deployable_equipment_panel:h() * temp_scale, h = deployable_equipment_panel:h() * temp_scale, x = -(deployable_equipment_panel:h()*temp_scale - deployable_equipment_panel:h())/2, y = -(deployable_equipment_panel:h()*temp_scale - deployable_equipment_panel:h())/2 } )
	local amount = cable_ties_panel:text( { name = "amount", visible = false, text = tostring(12), font = "fonts/font_medium_mf", font_size = 22, color = Color.white, align = "right", vertical = "center", layer = 2, x = -2, y = 2, w = deployable_equipment_panel:w(), h = deployable_equipment_panel:h() } )
	cable_ties_panel:set_bottom( weapons_panel:bottom() )
	if not main_player then
		local scale = 0.75
		--- cable_ties_panel:set_debug( true )
		cable_ties_panel:set_size( cable_ties_panel:w() * 0.9, cable_ties_panel:h() * scale )
		cable_ties:set_size( cable_ties:w() * scale, cable_ties:h() * scale )
		cable_ties:set_center_y( cable_ties_panel:h()/2 )
		cable_ties:set_x( cable_ties:x() + 4 )
		amount:set_center_y( cable_ties_panel:h()/2 )
		amount:set_right( cable_ties_panel:w() - 4 )
		cable_ties_panel:set_x( deployable_equipment_panel:right() )
		cable_ties_panel:set_bottom( deployable_equipment_panel:bottom() )
		local bg = cable_ties_panel:child( "bg" )
		bg:set_size( cable_ties_panel:size() )
	end
	
	----- CARRY
	local bag_rect = { 32, 33, 32, 31 }
	local bg_rect = { 84, 0, 44, 32 }
	
	local bag_w = bag_rect[3] -- * 1.5
	local bag_h = bag_rect[4] -- * 1.5
	
	-- local carry_panel = self._player_panel:panel( { name = "carry_panel", visible = false, layer = 1, w = self._player_panel:w(), h = bag_rect[ 4 ] + 2, x = name:x(), y = name:top() - 4 - (bag_rect[ 4 ] + 2) } )
	local carry_panel = self._player_panel:panel( { name = "carry_panel", visible = false, layer = 1, w = bag_w, h = bag_h + 2, x = 0, y = radial_health_panel:top() - (bag_h) } )
	carry_panel:set_x( 24 - (bag_w)/2 )
	carry_panel:set_center_x( radial_health_panel:center_x() )
	carry_panel:bitmap( { name = "bg", texture = tabs_texture, texture_rect = bg_rect, visible = false, layer = 0, color = bg_color, x = 0, y = 0 , w = 100, h = carry_panel:h() } )
	carry_panel:bitmap( { name = "bag", texture = tabs_texture, w = bag_w, h = bag_h, texture_rect = bag_rect, visible = true, layer = 0, color = Color.white, x = 1, y = 1 } )
	carry_panel:text( { name = "value", visible = false, text= "", layer = 0, color = Color.white, x = bag_rect[ 3 ] + 4, y = 0, vertical = "center", font_size = tweak_data.hud.small_font_size, font = "fonts/font_small_mf" } )
	
	-- Interact
	local interact_panel = self._player_panel:panel( { name = "interact_panel", visible = false, layer = 3,  } )
	interact_panel:set_shape( weapons_panel:shape() )
	interact_panel:set_shape( radial_health_panel:shape() )
	interact_panel:set_size( radial_size*1.25, radial_size*1.25 )
	interact_panel:set_center( radial_health_panel:center() )
	local radius = interact_panel:h()/2 - 4
	self._interact = CircleBitmapGuiObject:new( interact_panel, { use_bg = true, rotation = 360, radius = radius, blend_mode = "add", color = Color.white, layer = 0 } )
	self._interact:set_position( 4, 4 )
	-- self._interact:set_current( 0.5 )
	
	self._special_equipment = {}
	self._panel = teammate_panel
	
	-- self:_rec_round_object( self._panel )
end

function HUDTeammate:teammate_progress(enabled, tweak_data_id, timer, success)
	self._player_panel:child("weapons_panel"):set_alpha(enabled and 0.2 or 1)
	self._player_panel:child("interact_panel"):stop()
	self._player_panel:child("interact_panel"):set_visible(enabled)

	if enabled then
		self._player_panel:child("interact_panel"):animate(callback(HUDManager, HUDManager, "_animate_label_interact"), self._interact, timer)
	elseif success then
--[[
		local panel = self._player_panel
		local bitmap = panel:bitmap({
			blend_mode = "add",
			texture = "guis/textures/restoration/hud_progress_active",
			layer = 2,
			align = "center",
			rotation = 360,
			valign = "center"
		})

		bitmap:set_size(self._interact:size())
		bitmap:set_position(self._player_panel:child("interact_panel"):x() + 4, self._player_panel:child("interact_panel"):y() + 4)

		local radius = self._interact:radius()
		local circle = CircleBitmapGuiObject:new(panel, {
			blend_mode = "normal",
			rotation = 360,
			layer = 3,
			radius = radius,
			color = Color.white:with_alpha(1)
		})

		circle:set_position(bitmap:position())
		bitmap:animate(callback(HUDInteraction, HUDInteraction, "_animate_interaction_complete"), circle)
]]
	end
end