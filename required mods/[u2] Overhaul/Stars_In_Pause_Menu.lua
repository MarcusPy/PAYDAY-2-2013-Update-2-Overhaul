function IngameContractGui:init( ws )
	self._panel = ws:panel():panel( { w = math.round( ws:panel():w()/2.6 ), h = math.round( ws:panel():h()/1.2 ) } )
	-- self._panel:set_center_y( ws:panel():h()/2 )
	self._panel:set_y( CoreMenuRenderer.Renderer.border_height + tweak_data.menu.pd2_large_font_size )
	
	local job_data = managers.job:current_job_data()
	
	if job_data and managers.job:current_job_id() == "safehouse" and Global.mission_manager.saved_job_values.playedSafeHouseBefore then
	-- if managers.job:is_current_job_safehouse() and managers.mission:has_played_safehouse() then
		self._panel:set_visible( false )
	end
		
	local contract_text = self._panel:text( { layer = 1, rotation = 360, vertical="bottom", font=tweak_data.menu.pd2_large_font, font_size=tweak_data.menu.pd2_large_font_size, text="", color=tweak_data.screen_colors.text } )
	contract_text:set_text( self:get_text( "cn_menu_contract_header" ).." "..(job_data and self:get_text( job_data.name_id ) or "") )
	
	-- contract_text:set_y( -self._panel:y() )
	contract_text:set_bottom( 0 )
	
	local text_panel = self._panel:panel( { layer = 1, w = self._panel:w() - 32, h = self._panel:h() - 32 } )
	text_panel:set_center( self._panel:w()/2, self._panel:h()/2 )
	-- text_panel:set_debug( true )
	
	local briefing_title = text_panel:text( { font=tweak_data.menu.pd2_medium_font, font_size=tweak_data.menu.pd2_medium_font_size, text="", color=tweak_data.screen_colors.text } )
	briefing_title:set_text( self:get_text( "menu_briefing" ) )
	managers.hud:make_fine_text( briefing_title )
	
	local font_size = tweak_data.menu.pd2_small_font_size
	local text = job_data and managers.localization:text( job_data.briefing_id ) or "" -- self:get_text( job_data.briefing_id ) or ""
	local briefing_description = text_panel:text( { name = "briefing_description", text = text, font = tweak_data.menu.pd2_small_font--[[tweak_data.hud_stats.objective_desc_font]], font_size = font_size, color = Color(1, 1, 1, 1), align = "left", vertical = "top", wrap = true, word_wrap = true, h = 128 } )
	managers.hud:make_fine_text( briefing_description )
	briefing_description:set_h( briefing_description:h() + 10 )
	briefing_description:set_top( briefing_title:bottom() )
	
	if managers.job:is_current_job_professional() then
		local pro_warning_text = text_panel:text( { name = "pro_warning_text", text = self:get_text( "menu_pro_warning" ), font = tweak_data.menu.pd2_small_font--[[tweak_data.hud_stats.objective_desc_font]], font_size = font_size, color = Color(255, 255, 50, 53)/255, align = "left", vertical = "top", wrap = true, word_wrap = true, h = 128 } )
		managers.hud:make_fine_text( pro_warning_text )
		pro_warning_text:set_h( pro_warning_text:h() + 10 )
		pro_warning_text:set_bottom( text_panel:center_y() )
	end
	
	local risk_color = Color(255, 255, 204, 0)/255
	local risk_title = text_panel:text( { font=tweak_data.menu.pd2_small_font, font_size=font_size, text=self:get_text( "menu_risk" ), color=risk_color } )
	managers.hud:make_fine_text( risk_title )
	risk_title:set_top( text_panel:center_y() )
	
	local menu_risk_id = "menu_risk_pd"
	if Global.game_settings.difficulty == "hard" then
		menu_risk_id = "menu_risk_swat"
	elseif Global.game_settings.difficulty == "overkill" then
		menu_risk_id = "menu_risk_fbi"
	elseif Global.game_settings.difficulty == "overkill_145" then
		menu_risk_id = "menu_risk_special"
	end
	
	local risk_text = text_panel:text( { w = text_panel:w(), h = text_panel:h(), name = "risk_text", text = self:get_text( menu_risk_id ).." ", font = tweak_data.hud_stats.objective_desc_font, font_size = font_size, color = risk_color, align = "left", vertical = "top", wrap = true, word_wrap = true } )
	managers.hud:make_fine_text( risk_text )
	risk_text:set_h( risk_text:h() + 10 )
	risk_text:set_top( risk_title:bottom() + 10 )
			
	local potential_rewards_title = text_panel:text( { font=tweak_data.menu.pd2_small_font, font_size=font_size, text=self:get_text( "menu_potential_rewards" ), color=Color.white } )
	managers.hud:make_fine_text( potential_rewards_title )
	potential_rewards_title:set_top( risk_text:bottom() + 4 )
	
	local paygrade_title = text_panel:text( { font=tweak_data.menu.pd2_small_font, font_size=font_size, text=self:get_text( "cn_menu_contract_paygrade_header" ), color=Color.white } )
	managers.hud:make_fine_text( paygrade_title )
	paygrade_title:set_top( potential_rewards_title:bottom() + 4 )
	
	local experience_title = text_panel:text( { font=tweak_data.menu.pd2_small_font, font_size=font_size, text=self:get_text( "menu_experience" ), color=Color.white } )
	managers.hud:make_fine_text( experience_title )
	experience_title:set_top( paygrade_title:bottom() )
	
	local stage_cash_title = text_panel:text( { font=tweak_data.menu.pd2_small_font, font_size=font_size, text=self:get_text( "menu_cash_stage", { money = "" } ), color=Color.white } )
	managers.hud:make_fine_text( stage_cash_title )
	stage_cash_title:set_top( experience_title:bottom() )
	
	local cash_title = text_panel:text( { font=tweak_data.menu.pd2_small_font, font_size=font_size, text=self:get_text( "menu_cash_job", { money = "" } ), color=Color.white } )
	managers.hud:make_fine_text( cash_title )
	cash_title:set_top( stage_cash_title:bottom() )
		
	local sx = math.max( paygrade_title:w(), experience_title:w() )
	sx = math.max( sx, stage_cash_title:w() )
	sx = math.max( sx, cash_title:w() ) + 24
	
	if job_data then
		local job_stars = managers.job:current_job_stars()
		local job_and_difficulty_stars = managers.job:current_job_and_difficulty_stars()
		local difficulty_stars = job_and_difficulty_stars - job_stars
		
		-- Risk images	
		local rsx = risk_title:right() + 12
		for i,name in ipairs( { "risk_pd", "risk_swat", "risk_fbi", "risk_death_squad" } ) do	
			if i ~= 1 then
				local texture, rect = tweak_data.hud_icons:get_icon_data( name )
				local active = (i <= difficulty_stars + 1)
				local color = (active and i~=1) and risk_color or Color.white
				local alpha = active and 1 or 0.25
				local risk = text_panel:bitmap( { name=name, texture="guis/textures/pd2/skilltree/locked", x=0, y=0, w=25, h=25, alpha=alpha, color = color } )
				risk:set_x( rsx )
				risk:set_center_y( math.round( risk_title:center_y() - 3 ) )
				rsx = rsx + risk:w() + 12
			end
		end
		
		-- Stars
		local filled_star_rect = { 0, 32, 32, 32 }
		local empty_star_rect = { 32, 32, 32, 32 }
		
		local cy = paygrade_title:center_y()
		-- local sx = paygrade_title:right() + 8
		
		local level_data = { texture="guis/textures/pd2/mission_briefing/difficulty_icons", texture_rect=filled_star_rect, w=20, h=20, color=tweak_data.screen_colors.text, alpha=1 }
		local risk_data = { texture="guis/textures/pd2/crimenet_skull", w=20, h=20, color=risk_color, alpha=1 }
		--[[for i = 1, job_and_difficulty_stars do
			local star = text_panel:bitmap( (i>job_stars) and risk_data or level_data )
			
			star:set_x( sx + (i-1)*22 )
			star:set_center_y( cy )
		end]]
		
		
		for i = 1, 10 do -- job_and_difficulty_stars do
			local x = sx + (i-1)*18
			local alpha = (i>job_and_difficulty_stars) and 0.25 or 1
			local color = ((i>job_and_difficulty_stars) or (i<=job_stars)) and Color.white or risk_color 
			local star = text_panel:bitmap( { texture="guis/textures/pd2/skilltree/locked", x=x, y=0, w=15, h=15, alpha=alpha, color = color } )
			star:set_center_y( math.round( cy ) )
		end
		local plvl = managers.experience:current_level()
		local player_stars = math.max( math.ceil( plvl / 10 ), 1 )
		
		-- Experience
		local cy = experience_title:center_y()
		local num_days = #job_data.chain or 1
		local days_multiplier = 0
		
		-- local day_tweak = job_data.professional and tweak_data.experience_manager.pro_day_multiplier or tweak_data.experience_manager.day_multiplier
		-- for i=1, num_days do
		-- 	days_multiplier = days_multiplier + (day_tweak[i] - 1)
		-- end
		-- days_multiplier = 1 + ( days_multiplier / num_days )
		
		for i=1, num_days do
			local day_mul = job_data.professional and tweak_data:get_value( "experience_manager", "pro_day_multiplier", i ) or tweak_data:get_value( "experience_manager", "day_multiplier", i )
			days_multiplier = days_multiplier + (day_mul-1)
		end
		days_multiplier = 1 + ( days_multiplier / num_days )
		local last_day_mul = job_data.professional and tweak_data:get_value( "experience_manager", "pro_day_multiplier", num_days ) or tweak_data:get_value( "experience_manager", "day_multiplier", num_days )
		
		
		local xp_stage_stars = managers.experience:get_stage_xp_by_stars( job_stars )
		local xp_job_stars = managers.experience:get_job_xp_by_stars( job_stars )
		-- local xp_job_and_difficulty_stars = managers.experience:get_job_xp_by_stars( job_and_difficulty_stars )
		
		local xp_multiplier = managers.experience:get_contract_difficulty_multiplier( difficulty_stars )
		
		local experience_manager = tweak_data.experience_manager.level_limit
		if player_stars <= job_and_difficulty_stars+tweak_data:get_value( "experience_manager", "level_limit", "low_cap_level" ) then
			local diff_stars = math.clamp( job_and_difficulty_stars - player_stars, 1, #experience_manager.pc_difference_multipliers )
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
		
		local pure_job_experience = xp_job_stars * last_day_mul + xp_stage_stars + xp_stage_stars * (num_days-1) * days_multiplier
		local job_experience = math.round( pure_job_experience )
		local job_xp = text_panel:text( { font=tweak_data.menu.pd2_small_font, font_size=font_size, text="", color=Color.white } )
		job_xp:set_text( tostring(job_experience) )
		managers.hud:make_fine_text( job_xp )
		job_xp:set_x( sx )
		job_xp:set_center_y( cy )
		
		local add_xp = text_panel:text( { font=tweak_data.menu.pd2_small_font, font_size=font_size, text="", color=risk_color } )
		-- add_xp:set_text( " +"..(xp_job_and_difficulty_stars - xp_job_stars) )
		add_xp:set_text( " +"..(math.round( pure_job_experience * xp_multiplier ) ) )
		managers.hud:make_fine_text( add_xp )
		add_xp:set_x( job_xp:right() )
		add_xp:set_center_y( cy )
		-- Money
		
		local money_stage_stars = managers.money:get_stage_payout_by_stars( job_stars )
		local money_job_stars = managers.money:get_job_payout_by_stars( job_stars )
		-- local money_job_and_difficulty_stars = managers.money:get_job_payout_by_stars( job_and_difficulty_stars )
		
		local money_multiplier = managers.money:get_contract_difficulty_multiplier( difficulty_stars )
		
		local money_manager = tweak_data.money_manager.level_limit
		-- if player_stars <= job_and_difficulty_stars+money_manager.low_cap_level then
		if player_stars <= job_and_difficulty_stars+tweak_data:get_value("money_manager", "level_limit", "low_cap_level" ) then
			local diff_stars = math.clamp( job_and_difficulty_stars - player_stars, 1, #money_manager.pc_difference_multipliers )
			-- local level_limit_mul = money_manager.pc_difference_multipliers[ diff_stars ]
			local level_limit_mul = tweak_data:get_value("money_manager", "level_limit", "pc_difference_multipliers", diff_stars )
			
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
		
		local cy = stage_cash_title:center_y()
		-- local stage_cash = text_panel:text( { font=tweak_data.menu.pd2_small_font, font_size=font_size, text=tostring(num_days) .. " x " .. managers.experience:cash_string(money_stage_stars+tweak_data.money_manager.flat_stage_completion), color=tweak_data.screen_colors.text } )
		local stage_cash = text_panel:text( { font=tweak_data.menu.pd2_small_font, font_size=font_size, text=tostring(num_days) .. " x " .. managers.experience:cash_string(money_stage_stars+tweak_data:get_value( "money_manager", "flat_stage_completion" )), color=tweak_data.screen_colors.text } )
		managers.hud:make_fine_text( stage_cash )
		stage_cash:set_x( sx )
		stage_cash:set_center_y( cy )
		
		local stage_add_cash = text_panel:text( { font=tweak_data.menu.pd2_small_font, font_size=font_size, text="", color=risk_color } )
		stage_add_cash:set_text( " +"..tostring(num_days) .. " x " .. managers.experience:cash_string(math.round( money_stage_stars*money_multiplier ) ) )
		managers.hud:make_fine_text( stage_add_cash )
		stage_add_cash:set_x( stage_cash:right() )
		stage_add_cash:set_center_y( cy )
		
		
		local cy = cash_title:center_y()
		local job_cash = text_panel:text( { font=tweak_data.menu.pd2_small_font, font_size=font_size, text="", color=Color.white } )
		-- job_cash:set_text( managers.experience:cash_string( money_job_stars + tweak_data.money_manager.flat_job_completion ) )
		job_cash:set_text( managers.experience:cash_string( money_job_stars + tweak_data:get_value( "money_manager", "flat_job_completion" ) ) )
		managers.hud:make_fine_text( job_cash )
		job_cash:set_x( sx )
		job_cash:set_center_y( cy )
		
		local add_cash = text_panel:text( { font=tweak_data.menu.pd2_small_font, font_size=font_size, text="", color=risk_color } )
		-- add_cash:set_text( " +"..managers.experience:cash_string( money_job_and_difficulty_stars - money_job_stars ) )
		add_cash:set_text( " +"..managers.experience:cash_string(math.round( money_job_stars * money_multiplier ) ) )
		managers.hud:make_fine_text( add_cash )
		add_cash:set_x( job_cash:right() )
		add_cash:set_center_y( cy )
		
		-- local payday_value = money_job_stars + tweak_data.money_manager.flat_job_completion + money_job_stars * money_multiplier + money_stage_stars * num_days + money_stage_stars * money_multiplier * num_days + tweak_data.money_manager.flat_stage_completion * num_days
		local payday_value = money_job_stars + tweak_data:get_value( "money_manager", "flat_job_completion" ) + money_job_stars * money_multiplier + money_stage_stars * num_days + money_stage_stars * money_multiplier * num_days + tweak_data:get_value( "money_manager", "flat_stage_completion" ) * num_days
		local payday_text = text_panel:text( { font=tweak_data.menu.pd2_large_font, font_size=tweak_data.menu.pd2_large_font_size, text=self:get_text( "menu_payday", { MONEY = managers.experience:cash_string( math.round( payday_value ) ) } ), color=Color.white } )
		managers.hud:make_fine_text( payday_text )
		payday_text:set_bottom( text_panel:h() )
	end
	self:_rec_round_object( self._panel )
	
	self._sides = BoxGuiObject:new( self._panel, { sides = { 1, 1, 1, 1 } } )
end