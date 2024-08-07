function ContractBoxGui:create_contract_box()
	if not managers.network:session() then
		return
	end
	
	if( self._contract_panel and alive( self._contract_panel ) ) then
		self._panel:remove( self._contract_panel )
	end
	if( self._contract_text_header and alive( self._contract_text_header ) ) then
		self._panel:remove( self._contract_text_header )
	end
	self._contract_panel = nil
	self._contract_text_header = nil
	
	local contact_data = managers.job:current_contact_data()
	local job_data = managers.job:current_job_data()
	
	self._contract_panel = self._panel:panel( { name="contract_box_panel", w=350, h=100, layer=0 } )
	self._contract_panel:rect( { color=Color(0.5, 0, 0, 0), layer=-1, halign="grow", valign="grow" } )
	-- self._contract_panel:polyline( { color=tweak_data.screen_color_blue:with_alpha(0.5), blend_mode="add", line_width=1, closed=true, points={ Vector3( 0, 0, 0 ), Vector3( self._contract_panel:w(), 0, 0 ), Vector3( self._contract_panel:w(), self._contract_panel:h(), 0 ), Vector3( 0, self._contract_panel:h(), 0 ) } } )
		
	local font = tweak_data.menu.pd2_small_font
	local font_size = tweak_data.menu.pd2_small_font_size
	if contact_data then
		self._contract_text_header = self._panel:text( { text=utf8.to_upper( managers.localization:text( contact_data.name_id )..": "..managers.localization:text( job_data.name_id ) ), font_size=tweak_data.menu.pd2_medium_font_size, font=tweak_data.menu.pd2_medium_font, color=tweak_data.screen_colors.text, blend_mode="add" } )
		-- self._contact_image = self._contract_panel:bitmap( { name = "contact_image", texture=managers.job:current_contact_data().image, w = 100, h = 128, x=5, y=5, texture_rect={0,0,100,128}, layer=1 } )
		
		-- self._contract_panel:video( { video = "movies/contact_" .. managers.job:current_contact_id(), width = self._contract_panel:w(), height = self._contract_panel:h(), blend_mode="add", loop=true } )
	
		local length_text_header	= self._contract_panel:text( { text=managers.localization:to_upper_text( "cn_menu_contract_length_header" ), font_size=font_size, font=font, color=tweak_data.screen_colors.text } )
		local paygrade_text_header	= self._contract_panel:text( { text=managers.localization:to_upper_text( "cn_menu_contract_paygrade_header" ), font_size=font_size, font=font, color=tweak_data.screen_colors.text } )
		local exp_text_header	= self._contract_panel:text( { text=managers.localization:to_upper_text( "menu_experience" ), font_size=font_size, font=font, color=tweak_data.screen_colors.text } )
		local payout_text_header	= self._contract_panel:text( { text=managers.localization:to_upper_text( "cn_menu_contract_payout_header" ), font_size=font_size, font=font, color=tweak_data.screen_colors.text } )
		
		do
			local _, _, tw, th = self._contract_text_header:text_rect()
			self._contract_text_header:set_size( tw, th )
		end
		
		local w = 0
		do
			local _, _, tw, th = length_text_header:text_rect()
			w = math.max( w, tw )
			length_text_header:set_size( tw, th )
		end
		do
			local _, _, tw, th = paygrade_text_header:text_rect()
			w = math.max( w, tw )
			paygrade_text_header:set_size( tw, th )
		end
		do
			local _, _, tw, th = exp_text_header:text_rect()
			w = math.max( w, tw )
			exp_text_header:set_size( tw, th )
		end
		do
			local _, _, tw, th = payout_text_header:text_rect()
			w = math.max( w, tw )
			payout_text_header:set_size( tw, th )
		end
		w = w + 10
		-- self._contact_text_header:set_left( 10 )
		length_text_header:set_right( w )
		paygrade_text_header:set_right( w )
		exp_text_header:set_right( w )
		payout_text_header:set_right( w )
		
		-- self._contact_text_header:set_top( 10 )
		paygrade_text_header:set_top( 10 )
		length_text_header:set_top( paygrade_text_header:bottom() )
		exp_text_header:set_top( length_text_header:bottom() )
		payout_text_header:set_top( exp_text_header:bottom() )
		
		
		-- self._contact_text = self._contract_panel:text( { text=managers.localization:text( contact_data.name_id ), align="left", vertical="top", font_size=font_size * 1.1, font=font, color=tweak_data.screen_color_white } )
		-- self._contact_text:set_position( self._contact_text_header:right() + 3, self._contact_text_header:top() )
		
		
		local length_text = self._contract_panel:text( { text=managers.localization:to_upper_text( "cn_menu_contract_length", {stages=#job_data.chain} ), align="left", vertical="top", font_size=font_size, font=font, color=tweak_data.screen_colors.text } )
		length_text:set_position( length_text_header:right() + 5, length_text_header:top() )
		
		
		--[[
		local stars_panel = self._contract_panel:panel( { name="stars_panel" } )
		local num_stars = 0
		local x = 0
		local star_size = 21
		local difficulty = Global.game_settings.difficulty or "easy"
		local difficulty_id = math.max( 0, ( tweak_data:difficulty_to_index( difficulty ) or 0 ) - 2 )
		local job_stars = math.ceil( job_data.jc/10 )
		 
		for i = 1, job_stars + difficulty_id do
			stars_panel:bitmap( { texture="guis/textures/pd2/crimenet_star", x=x, w=star_size, h=star_size, blend_mode="add", color=(i<=job_stars) and tweak_data.screen_color_white or tweak_data.screen_color_red } )
			x = x + star_size * 0.72
			num_stars = num_stars + 1
		end
		]]
		
		-- Stars
		local filled_star_rect = { 0, 32, 32, 32 }
		local empty_star_rect = { 32, 32, 32, 32 }
		
		local job_stars = managers.job:current_job_stars()
		local job_and_difficulty_stars = managers.job:current_job_and_difficulty_stars()
		local difficulty_stars = job_and_difficulty_stars - job_stars
		local risk_color = tweak_data.screen_colors.risk -- Color(255, 255, 204, 0)/255 
		
		local cy = paygrade_text_header:center_y()
		local sx = paygrade_text_header:right() + 5
		
		local level_data = { texture="guis/textures/pd2/mission_briefing/difficulty_icons", texture_rect=filled_star_rect, w=16, h=16, color=tweak_data.screen_colors.text, alpha=1 }
		local risk_data = { texture="guis/textures/pd2/crimenet_skull", w=16, h=16, color=risk_color, alpha=1 }
		--[[for i = 1, job_and_difficulty_stars do
			local x = sx + (i-1)*18
			local is_risk = i > job_stars
			local star_data = is_risk and risk_data or level_data
			
			local star = self._contract_panel:bitmap( star_data )
			star:set_x( x )
			star:set_center_y( math.round( cy ) )
		end]]
		
		
		for i = 1, 10 do
			local x = sx + (i-1)*18
			local alpha = (i>job_and_difficulty_stars) and 0.25 or 1
			local color = ((i>job_and_difficulty_stars) or (i<=job_stars)) and Color.white or risk_color
			local star = self._contract_panel:bitmap( { name="star"..tostring(i) , texture="guis/textures/pd2/skilltree/locked", x=x, y=0, w=16, h=16, alpha=alpha, color = color } )
			star:set_center_y( math.round( cy ) )
		end
		
		--[[
		for i = 1, difficulty_id do
			stars_panel:bitmap( { texture="guis/textures/pd2/crimenet_star", x=x, w=star_size, h=star_size, blend_mode="add", color=tweak_data.screen_color_red } )
			x = x + star_size * 0.72
			num_stars = num_stars + 1
		end]]
		-- stars_panel:set_position( self._paygrade_text_header:right() + 3, self._paygrade_text_header:top() )
		
		local plvl = managers.experience:current_level()
		local player_stars = math.max( math.ceil( plvl / 10 ), 1 )
		
		local days_multiplier = 0
		-- local day_tweak = job_data.professional and tweak_data.experience_manager.pro_day_multiplier or tweak_data.experience_manager.day_multiplier
		-- for i=1, #job_data.chain do
		-- 	days_multiplier = days_multiplier + (day_tweak[i] - 1)
		-- end
		-- days_multiplier = 1 + ( days_multiplier / #job_data.chain )
		
		for i=1, #job_data.chain do
			local day_mul = job_data.professional and tweak_data:get_value( "experience_manager", "pro_day_multiplier", i ) or tweak_data:get_value( "experience_manager", "day_multiplier", i )
			days_multiplier = days_multiplier + (day_mul-1)
		end
		days_multiplier = 1 + ( days_multiplier / #job_data.chain )
		local last_day_mul = job_data.professional and tweak_data:get_value( "experience_manager", "pro_day_multiplier", #job_data.chain ) or tweak_data:get_value( "experience_manager", "day_multiplier", #job_data.chain )
		
		
		local xp_stage_stars = managers.experience:get_stage_xp_by_stars( job_stars )
		local xp_job_stars = managers.experience:get_job_xp_by_stars( job_stars )
		local xp_multiplier = managers.experience:get_contract_difficulty_multiplier( difficulty_stars )
		
		local experience_manager = tweak_data.experience_manager.level_limit
		-- if player_stars <= job_and_difficulty_stars+experience_manager.low_cap_level then
		if player_stars <= job_and_difficulty_stars+tweak_data:get_value( "experience_manager", "level_limit", "low_cap_level" ) then
			local diff_stars = math.clamp( job_and_difficulty_stars - player_stars, 1, #experience_manager.pc_difference_multipliers )
			-- local level_limit_mul = experience_manager.pc_difference_multipliers[ diff_stars ]
			local level_limit_mul = tweak_data:get_value( "experience_manager", "level_limit", "pc_difference_multipliers", diff_stars )
			
			local plr_difficulty_stars = math.max( difficulty_stars-diff_stars, 0 )
			local plr_xp_multiplier = managers.experience:get_contract_difficulty_multiplier( plr_difficulty_stars ) or 0
			local white_player_stars = player_stars - plr_difficulty_stars
			
			
			local xp_plr_stage_stars = managers.experience:get_stage_xp_by_stars( white_player_stars )
			xp_plr_stage_stars = xp_plr_stage_stars + xp_plr_stage_stars * plr_xp_multiplier
			local xp_stage = xp_stage_stars + xp_stage_stars * xp_multiplier
			local diff_stage = xp_stage - xp_plr_stage_stars
			
			local new_xp_stage = xp_plr_stage_stars + diff_stage * level_limit_mul
			xp_stage_stars = xp_stage_stars * ( new_xp_stage / xp_stage )
			
			
			local xp_plr_job_stars = managers.experience:get_job_xp_by_stars( white_player_stars )
			xp_plr_job_stars = xp_plr_job_stars + xp_plr_job_stars * plr_xp_multiplier
			local xp_job = xp_job_stars + xp_job_stars * xp_multiplier
			local diff_job = xp_job - xp_plr_job_stars
			
			local new_xp_job = xp_plr_job_stars + diff_job * level_limit_mul
			xp_job_stars = xp_job_stars * ( new_xp_job / xp_job )
		end
		
		local pure_job_experience = (xp_job_stars * last_day_mul + xp_stage_stars + xp_stage_stars * (#job_data.chain-1) * days_multiplier )
		local job_experience = math.round( pure_job_experience )
		local job_xp = self._contract_panel:text( { font=font, font_size=font_size, text=tostring( job_experience ), color=tweak_data.screen_colors.text } )
		do
			local _, _, tw, th = job_xp:text_rect()
			job_xp:set_size( tw, th )
		end
		job_xp:set_position( math.round( exp_text_header:right()+5 ), math.round( exp_text_header:top() ) )
		
		local risk_xp = self._contract_panel:text( { font=font, font_size=font_size, text=" +"..tostring( math.round( pure_job_experience * xp_multiplier ) ), color=risk_color } )
		do
			local _, _, tw, th = risk_xp:text_rect()
			risk_xp:set_size( tw, th )
		end
		risk_xp:set_position( math.round( job_xp:right() ), job_xp:top() )
				
		
		local money_stage_stars = managers.money:get_stage_payout_by_stars( job_stars )
		local money_job_stars = managers.money:get_job_payout_by_stars( job_stars )
		local money_multiplier = managers.money:get_contract_difficulty_multiplier( difficulty_stars )
		
		local money_manager = tweak_data.money_manager.level_limit
		-- if player_stars <= job_and_difficulty_stars+money_manager.low_cap_level then
		if player_stars <= job_and_difficulty_stars+tweak_data:get_value( "money_manager", "level_limit", "low_cap_level" ) then
			local diff_stars = math.clamp( job_and_difficulty_stars - player_stars, 1, #money_manager.pc_difference_multipliers )
			-- local level_limit_mul = money_manager.pc_difference_multipliers[ diff_stars ]
			local level_limit_mul = tweak_data:get_value( "money_manager", "level_limit", "pc_difference_multipliers", diff_stars )
			
			local plr_difficulty_stars = math.max( difficulty_stars-diff_stars, 0 )
			local plr_money_multiplier = managers.money:get_contract_difficulty_multiplier( plr_difficulty_stars ) or 0
			local white_player_stars = player_stars - plr_difficulty_stars
			
			local cash_plr_stage_stars = managers.money:get_stage_payout_by_stars( white_player_stars, true )
			cash_plr_stage_stars = cash_plr_stage_stars + cash_plr_stage_stars * plr_money_multiplier
			local cash_stage = money_stage_stars + money_stage_stars * money_multiplier
			local diff_stage = cash_stage - cash_plr_stage_stars
			
			local new_cash_stage = cash_plr_stage_stars + diff_stage * level_limit_mul
			money_stage_stars = money_stage_stars * ( new_cash_stage / cash_stage )
			
			
			local cash_plr_job_stars = managers.money:get_job_payout_by_stars( white_player_stars, true )
			cash_plr_job_stars = cash_plr_job_stars + cash_plr_job_stars * plr_money_multiplier
			local cash_job = money_job_stars + money_job_stars * money_multiplier
			local diff_job = cash_job - cash_plr_job_stars
			
			local new_cash_job = cash_plr_job_stars + diff_job * level_limit_mul
			money_job_stars = money_job_stars * ( new_cash_job / cash_job )
		end
		
		-- local job_money = self._contract_panel:text( { font=font, font_size=font_size, text=managers.experience:cash_string( math.round( (money_job_stars + tweak_data.money_manager.flat_job_completion + (money_stage_stars + tweak_data.money_manager.flat_stage_completion) * (#job_data.chain)) ) ), color=tweak_data.screen_colors.text } )
		local job_money = self._contract_panel:text( { font=font, font_size=font_size, text=managers.experience:cash_string( math.round( (money_job_stars + tweak_data:get_value( "money_manager", "flat_job_completion" ) + (money_stage_stars + tweak_data:get_value( "money_manager", "flat_stage_completion" )) * (#job_data.chain)) ) ), color=tweak_data.screen_colors.text } )
		do
			local _, _, tw, th = job_money:text_rect()
			job_money:set_size( tw, th )
		end
		job_money:set_position( math.round( payout_text_header:right()+5 ), math.round( payout_text_header:top() ) )

		local risk_money = self._contract_panel:text( { font=font, font_size=font_size, text=" +"..managers.experience:cash_string( math.round( (money_job_stars + money_stage_stars * (#job_data.chain)) * money_multiplier ) ), color=risk_color } )
		do
			local _, _, tw, th = risk_money:text_rect()
			risk_money:set_size( tw, th )
		end
		risk_money:set_position( math.round( job_money:right() ), job_money:top() )
			
		self._contract_panel:set_h( payout_text_header:bottom() + 10 )
		-- local amount = managers.money:get_job_payout_by_stars( job_and_difficulty_stars )
		-- self._payout_text = self._contract_panel:text( { text=managers.experience:cash_string( amount ), align="left", vertical="top", font_size=font_size * 1.1, font=font, color=tweak_data.screen_color_white } )
		-- self._payout_text:set_position( self._payout_text_header:right() + 5, self._payout_text_header:top() )
	elseif managers.menu:debug_menu_enabled() then
		local debug_start = self._contract_panel:text( { text="Use DEBUG START to start your level", font_size=font_size, font=font, color=tweak_data.screen_colors.text, x=10, y=10, wrap=true, word_wrap=true } )
		debug_start:grow( -debug_start:x() -10, debug_start:y()-10 )
	end
	self._contract_panel:set_rightbottom( self._panel:w() - 10, self._panel:h() - 50 )
	
	
	if self._contract_text_header then
		self._contract_text_header:set_bottom( self._contract_panel:top() )
		self._contract_text_header:set_left( self._contract_panel:left() )
		
		local wfs_text = self._panel:child( "wfs" )
		if wfs_text and not managers.menu:is_pc_controller() then
			wfs_text:set_rightbottom( self._panel:w() - 20 , self._contract_text_header:top() )
		end
	end
	
	local wfs = self._panel:child("wfs")
	if wfs then
		self._contract_panel:grow( 0, wfs:h() + 5 )
		self._contract_panel:move( 0, - (wfs:h() + 5) )
		if self._contract_text_header then self._contract_text_header:move( 0, - (wfs:h() + 5) ) end
		wfs:set_world_rightbottom( self._contract_panel:world_right() - 5, self._contract_panel:world_bottom() )
		
	end
	
	BoxGuiObject:new( self._contract_panel, { sides={1, 1, 1, 1} } )
	
	for i=1, 4 do
		local peer = managers.network:session():peer( i )
		if( peer ) then
			local peer_pos = managers.menu_scene:character_screen_position( i )
			local peer_name = peer:name()
			
			if( peer_pos ) then
				self:create_character_text( i, peer_pos.x, peer_pos.y, peer_name )
			end
		end
	end
	self._enabled = true
end