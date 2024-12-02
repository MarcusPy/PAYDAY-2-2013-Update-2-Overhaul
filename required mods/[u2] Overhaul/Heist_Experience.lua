--[[ 

menu_es_risk 
menu_es_base_xp_stage
menu_es_base_xp_job
menu_es_alive_players_bonus
menu_es_skill_bonus
menu_es_day_bonus
menu_es_skill_points_info

]]

if RequiredScript == "lib/managers/experiencemanager" then
	function ExperienceManager:get_xp_dissected( success, num_winners )
		local has_active_job = managers.job:has_active_job()
		local job_and_difficulty_stars = has_active_job and managers.job:current_job_and_difficulty_stars() or 1
		local job_stars = has_active_job and managers.job:current_job_stars() or 1
		local difficulty_stars = job_and_difficulty_stars - job_stars
		local player_stars = managers.experience:level_to_stars()
		local days_multiplier = managers.experience:get_current_job_day_multiplier()
		local is_level_limited = player_stars < job_and_difficulty_stars
		
		local total_stars = math.min( job_and_difficulty_stars, player_stars )
		local total_difficulty_stars = math.max( 0, total_stars - job_stars )
		local xp_multiplier = managers.experience:get_contract_difficulty_multiplier( total_difficulty_stars ) * 1.75 -- 75% more difficulty based xp because progression is very sluggish
		
		total_stars = math.min( job_stars, total_stars )
		
		local contract_xp = 0
		local total_xp = 0
		
		local stage_xp_dissect = 0
		local job_xp_dissect = 0
		local level_limit_dissect = 0
		local risk_dissect = 0
		local failed_level_dissect = 0
		local alive_crew_dissect = 0
		local skill_dissect = 0
		local base_xp = 0
		local days_dissect = 0
		
		if success and has_active_job and managers.job:on_last_stage() then
			job_xp_dissect = managers.experience:get_job_xp_by_stars( job_stars )
			contract_xp = contract_xp + managers.experience:get_job_xp_by_stars( total_stars )
			
			level_limit_dissect = level_limit_dissect + job_xp_dissect
		end
		stage_xp_dissect = managers.experience:get_stage_xp_by_stars( job_stars )
		contract_xp = contract_xp + managers.experience:get_stage_xp_by_stars( total_stars )
		level_limit_dissect = level_limit_dissect + stage_xp_dissect
		
		base_xp = contract_xp
		contract_xp = contract_xp + math.round( contract_xp*xp_multiplier )
		risk_dissect = math.round( level_limit_dissect*managers.experience:get_contract_difficulty_multiplier( difficulty_stars ) )
		level_limit_dissect = math.round( level_limit_dissect + risk_dissect )
		
		
		
		if is_level_limited then
			-- local level_limit_tweak_data = tweak_data.experience_manager.level_limit
			
			-- if managers.experience:current_level() <= level_limit_tweak_data.low_cap_level then
			if managers.experience:current_level() <= tweak_data:get_value( "experience_manager", "level_limit", "low_cap_level" ) then
				contract_xp = contract_xp + contract_xp * tweak_data:get_value( "experience_manager", "level_limit", "low_cap_multiplier" )
				contract_xp = math.round( math.min( contract_xp, level_limit_dissect ) )
			else
				local diff_in_experience = level_limit_dissect - contract_xp
				local diff_in_stars = job_and_difficulty_stars - player_stars
				
				local tweak_multiplier = tweak_data:get_value( "experience_manager", "level_limit", "pc_difference_multipliers", diff_in_stars ) or 0
				
				contract_xp = contract_xp + diff_in_experience * tweak_multiplier
				contract_xp = math.round( math.min( contract_xp, level_limit_dissect ) )
			end
		end
		level_limit_dissect = contract_xp - level_limit_dissect
		
		
		
		if not success then
			failed_level_dissect = contract_xp
			-- contract_xp = math.round( contract_xp * (tweak_data.experience_manager.stage_failed_multiplier or 1) )
			contract_xp = math.round( contract_xp * (tweak_data:get_value( "experience_manager", "stage_failed_multiplier" ) or 1) )
			failed_level_dissect = contract_xp - failed_level_dissect
		end
		total_xp = contract_xp
		
		if success then
			-- local num_players_bonus = (num_winners and tweak_data.experience_manager.alive_humans_multiplier[ num_winners ] or 1)
			local num_players_bonus = (num_winners and tweak_data:get_value( "experience_manager", "alive_humans_multiplier", num_winners ) or 1)
			
			alive_crew_dissect = math.round( contract_xp * num_players_bonus - contract_xp )
			-- contract_xp = math.round( contract_xp * num_players_bonus )
			-- alive_crew_dissect = contract_xp - alive_crew_dissect
			total_xp = total_xp + alive_crew_dissect
			total_xp = total_xp * 10
		end
		
		------------- SKILLS
		local multiplier = managers.player:upgrade_value( "player", "xp_multiplier", 1 )
		multiplier = multiplier * managers.player:upgrade_value( "player", "passive_xp_multiplier", 1 )
		multiplier = multiplier * managers.player:team_upgrade_value( "xp", "multiplier", 1 )
		
		skill_dissect = math.round( contract_xp * multiplier - contract_xp )
		-- contract_xp = 
		-- skill_dissect = contract_xp - skill_dissect
		total_xp = total_xp + skill_dissect * 10
		
		
		------------- DAYS
		days_dissect = math.round( contract_xp * days_multiplier - contract_xp )
		total_xp = total_xp + days_dissect
		
		
		
		local dissection_table = {
			bonus_risk = math.round(risk_dissect),
			bonus_num_players = math.round(alive_crew_dissect),
			bonus_failed = math.round(failed_level_dissect),
			bonus_low_level = math.round(level_limit_dissect),
			bonus_skill = math.round(skill_dissect),
			bonus_days = math.round(days_dissect),
			
			stage_xp = math.round(stage_xp_dissect),
			job_xp = math.round(job_xp_dissect),
			base = math.round(base_xp),
			total = math.round(total_xp),
			last_stage = success and has_active_job and managers.job:on_last_stage(),
		}
		
		if Application:production_build() then
			local rounding_error = dissection_table.total - ( dissection_table.stage_xp + dissection_table.job_xp + dissection_table.bonus_risk + dissection_table.bonus_num_players + dissection_table.bonus_failed + dissection_table.bonus_low_level + dissection_table.bonus_skill + dissection_table.bonus_days )
			dissection_table.rounding_error = rounding_error
		else
			dissection_table.rounding_error = 0
		end
		
		return math.round(total_xp), dissection_table
	end
elseif RequiredScript == "lib/managers/hud/hudstageendscreen" then
	function HUDStageEndScreen:stage_init( t, dt )
		local data = self._data
		
		self._lp_text:show()
		self._lp_circle:show()
		self._lp_backpanel:child("bg_progress_circle"):show()
		self._lp_forepanel:child("level_progress_text"):show()
		
		if( data.gained == 0 ) then
			self._lp_text:set_text( tostring( data.start_t.level ) )
			self._lp_circle:set_color( Color(1, 1, 1) )
			managers.menu_component:post_event("box_tick")
			
			self:step_stage_to_end()
			return
		end
		
		self._lp_circle:set_alpha( 0 )
		self._lp_backpanel:child("bg_progress_circle"):set_alpha( 0 )
		self._lp_text:set_alpha( 0 )
		
		self._bonuses_panel = self._lp_forepanel:panel( { x=self._lp_curr_xp:x(), y=10 } )
		self._bonuses_panel:grow( -self._bonuses_panel:x(), -self._bonuses_panel:y() )
		
		local stage_text = managers.localization:to_upper_text( "menu_es_base_xp_stage" )
		local base_text = self._bonuses_panel:text( { name="base_text", font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.text, text="" } )
		local xp_text = self._bonuses_panel:text( { name="xp_text", font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.text, text=""})--text=managers.money:add_decimal_marks_to_string( tostring(data.bonuses.stage_xp) ) } )
		
		local _, _, tw, th = base_text:text_rect()
		base_text:set_h( th )
		
		xp_text:set_world_left( self._lp_xp_curr:world_left() )
		
		
		local delay = 0.80
		local y = math.round( base_text:bottom() )
		if data.bonuses.last_stage then
			local job_text = managers.localization:to_upper_text( "menu_es_base_xp_job" )
			local job_xp_fade_panel = self._bonuses_panel:panel( {alpha=0} )
			local base_text = job_xp_fade_panel:text( { name="base_text", font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.text, text="", y=y } )
			local sign_text = job_xp_fade_panel:text( { name="sign_text", font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.text, y=y, text="", align="right" } )
			local xp_text = job_xp_fade_panel:text( { name="xp_text", font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.text, y=y, text=""})--text=managers.money:add_decimal_marks_to_string( tostring(data.bonuses.job_xp) ) } )
			
			local _, _, tw, th = base_text:text_rect()
			base_text:set_h( th )
			
			xp_text:set_world_left( self._lp_xp_curr:world_left() )
			sign_text:set_world_right( self._lp_xp_curr:world_left() )
			
			delay = 0.85+0.60
			y = math.round( base_text:bottom() )
			--job_xp_fade_panel:animate( callback( self, self, "spawn_animation" ), 0.60, "box_tick" )
		end
		
		
		local bonuses_to_string_converter = { "bonus_risk", "bonus_failed", "bonus_days", "bonus_num_players", "bonus_skill" }
		-- local bonuses_to_value_converter = { risk_xp, alive_bonus, 0, failed_bonus, 0 }
		
		
		if data.bonuses.rounding_error ~= 0 then
			Application:debug("GOT A ROUNDING ERROR IN EXPERIENCE GIVING:", data.bonuses.rounding_error)
		end
			
		local index = 2
		for i, func_name in ipairs( bonuses_to_string_converter ) do
			local bonus = data.bonuses[func_name] 
			if bonus and bonus~=0 then
				local panel = self._bonuses_panel:panel( { alpha=0, y=y } )
				delay = (callback( self, self, func_name )( panel, delay, bonus ) or delay) + 0.60
				
				y = y + panel:h()
				index = index + 1
			end
		end
		
		
		local sum_line = self._bonuses_panel:rect( { color=Color(0.0, 1, 1, 1), alpha=0.0, h=2 } )
		sum_line:set_y( y )
		-- sum_line:animate( callback( self, self, "spawn_animation" ), delay )

		self._lp_xp_gain:set_world_top( sum_line:world_top() )
		if SystemInfo:platform() == Idstring( "WIN32" ) then
			self._lp_xp_gain:move( 0, self._lp_xp_gain:h() )
		end
		self._lp_xp_gained:set_top( self._lp_xp_gain:top() )
		
		local sum_text = self._bonuses_panel:text( { font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, text="= ", align="right", alpha=0 } )
		sum_text:set_world_righttop( self._lp_xp_gain:world_left(), self._lp_xp_gain:world_top() )
		--sum_text:animate( callback( self, self, "spawn_animation" ), delay+1, "box_tick" )
		
		self._lp_circle:set_color( Color( (data.start_t.current / data.start_t.total), 1, 1 ) )
		self._wait_t = t + 1
		self._start_ramp_up_t = delay
		self._ramp_up_timer = 0
		
		-- managers.menu_component:post_event("menu_enter")
		managers.menu_component:post_event("box_tick")
		self:step_stage_up()
	end

	function HUDStageEndScreen:bonus_days( panel, delay, bonus )
		local text = panel:text( { font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.text, text=""})--text=managers.localization:to_upper_text("menu_es_day_bonus") } )
		local _, _, w, h = text:text_rect()
		panel:set_h( h )
		text:set_size( w, h )
		text:set_center_y( panel:h()/2 )
		text:set_position( math.round( text:x() ), math.round( text:y() ) )
		
		--panel:animate( callback( self, self, "spawn_animation" ), delay, "box_tick" )
		
		local sign_text = panel:text( { font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.text, text="", alpha=0, align="right" } )
		sign_text:set_world_right( self._lp_xp_curr:world_left() )
		sign_text:animate( callback( self, self, "spawn_animation" ), delay + 0.0, false )
		
		local value_text = panel:text( { font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.text, text=""})--text=managers.money:add_decimal_marks_to_string( tostring(math.abs(bonus)) ), alpha=0 } )
		value_text:set_world_left( self._lp_xp_curr:world_left() )
		--value_text:animate( callback( self, self, "spawn_animation" ), delay + 0.0, false )
		return delay + 0.0
	end

	function HUDStageEndScreen:bonus_skill( panel, delay, bonus )
		local text = panel:text( { font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.text, text=""})--text=managers.localization:to_upper_text("menu_es_skill_bonus") } )
		local _, _, w, h = text:text_rect()
		panel:set_h( h )
		text:set_size( w, h )
		text:set_center_y( panel:h()/2 )
		text:set_position( math.round( text:x() ), math.round( text:y() ) )
		
		--panel:animate( callback( self, self, "spawn_animation" ), delay, "box_tick" )
		
		local sign_text = panel:text( { font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.text, text="", alpha=0, align="right" } )
		sign_text:set_world_right( self._lp_xp_curr:world_left() )
		--sign_text:animate( callback( self, self, "spawn_animation" ), delay + 0.0, false )
		
		local value_text = panel:text( { font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.text, text=""})--text=managers.money:add_decimal_marks_to_string( tostring(math.abs(bonus)) ), alpha=0 } )
		value_text:set_world_left( self._lp_xp_curr:world_left() )
		--value_text:animate( callback( self, self, "spawn_animation" ), delay + 0.0, false )
		return delay + 0.0
	end

	function HUDStageEndScreen:bonus_risk( panel, delay, bonus )
		local risk_text = panel:text( { font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.risk, text=""})--text=managers.localization:to_upper_text("menu_es_risk_bonus") } )
		local _, _, w, h = risk_text:text_rect()
		risk_text:set_size( w, h )
		
		panel:set_h( h )
		
		local has_active_job = managers.job:has_active_job()
		local job_and_difficulty_stars = has_active_job and managers.job:current_job_and_difficulty_stars() or 1
		local job_stars = has_active_job and managers.job:current_job_stars() or 1
		local difficulty_stars = job_and_difficulty_stars - job_stars
		
		
		local risk_icons = { "risk_swat", "risk_fbi", "risk_death_squad" }
		local x = 0
		
		panel:animate( callback( self, self, "spawn_animation" ), delay, "box_tick" )
		
		local sign_text = panel:text( { font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.risk, text="", alpha=0, align="right" } )
		sign_text:set_world_right( self._lp_xp_curr:world_left() )
		sign_text:animate( callback( self, self, "spawn_animation" ), delay, false )
		
		for i=1, math.min( difficulty_stars, #risk_icons ) do
			local texture, rect = tweak_data.hud_icons:get_icon_data( risk_icons[i] )
			local risk = panel:bitmap( { texture="guis/textures/pd2/skilltree/locked", x=w+x, w=65, h=65, color=tweak_data.screen_colors.risk, alpha=0 } )
			x = x + risk:w() + 4
			
			risk:animate( callback( self, self, "spawn_animation" ), delay + i*0.65 )
			panel:set_h( math.max( h, risk:bottom() ) )
		end
		
		--[[local value_text = panel:text( { font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.risk, text=managers.money:add_decimal_marks_to_string( tostring(math.abs(bonus)) ), alpha=0 } )
		value_text:set_world_left( self._lp_xp_curr:world_left() )
		value_text:animate( callback( self, self, "spawn_animation" ), delay, false )]]
		
		return delay
	end

	function HUDStageEndScreen:bonus_num_players( panel, delay, bonus )
		local text = panel:text( { font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.text, text=""})--text=managers.localization:to_upper_text("menu_es_alive_players_bonus") } )
		local _, _, w, h = text:text_rect()
		panel:set_h( h )
		text:set_size( w, h )
		text:set_center_y( panel:h()/2 )
		text:set_position( math.round( text:x() ), math.round( text:y() ) )
		
		--panel:animate( callback( self, self, "spawn_animation" ), delay, "box_tick" )
		
		local sign_text = panel:text( { font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.text, text="", alpha=0, align="right" } )
		sign_text:set_world_right( self._lp_xp_curr:world_left() )
		--sign_text:animate( callback( self, self, "spawn_animation" ), delay + 0.0, false )
		
		--[[local value_text = panel:text( { font=tweak_data.menu.pd2_small_font, font_size=tweak_data.menu.pd2_small_font_size, color=tweak_data.screen_colors.text, text=managers.money:add_decimal_marks_to_string( tostring(math.abs(bonus)) ), alpha=0 } )
		value_text:set_world_left( self._lp_xp_curr:world_left() )
		value_text:animate( callback( self, self, "spawn_animation" ), delay + 0.0, false )]]
		
		return delay + 0.0
	end

end