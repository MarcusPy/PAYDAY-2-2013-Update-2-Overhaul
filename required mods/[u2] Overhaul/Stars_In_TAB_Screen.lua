function HUDStatsScreen:init()
	self._hud_panel = managers.hud:script( managers.hud.STATS_SCREEN_SAFERECT ).panel
	self._full_hud_panel = managers.hud:script( managers.hud.STATS_SCREEN_FULLSCREEN ).panel
	self._full_hud_panel:clear()
	
	local left_panel = self._full_hud_panel:panel( { name = "left_panel", valign = "scale", w = self._full_hud_panel:w()/3 }  )
	left_panel:set_x( -left_panel:w() )
	left_panel:rect( { name = "rect_bg", color = Color( 0.0, 0.0, 0.0 ):with_alpha( 0.75 ), valign = "scale", blend_mode = "normal" } )
	-- left_panel:bitmap( { name = "blur_bg", color = Color( 1, 1, 1 ):with_alpha( 0.75 ), valign = "scale", blend_mode = "normal", layer = -1 } )
	local blur_bg = left_panel:bitmap( { name = "blur_bg", texture="guis/textures/test_blur_df", w = left_panel:w(), h = left_panel:h(), valign = "scale", render_template="VertexColorTexturedBlur3D", layer=-1 } )
			
	local objectives_title = left_panel:text( { layer = 1, name = "objectives_title", color = Color.white, font_size = tweak_data.hud_stats.objectives_title_size, font= tweak_data.hud_stats.objectives_font, text=utf8.to_upper( managers.localization:text( "hud_objective" ) ), align = "left", vertical = "top", w = 512, h = 32 } )
	local x, y = managers.gui_data:corner_safe_to_full( 0, 0 )
	objectives_title:set_position( math.round( x ), math.round( y ) )
	objectives_title:set_valign( {math.round( y )/managers.gui_data:full_scaled_size().h,0} )
	managers.hud:make_fine_text( objectives_title )
	-- objectives_title:set_debug( true )
	
	local pad = 8
	local objectives_panel = left_panel:panel( { layer = 1, name = "objectives_panel", x = math.round( objectives_title:x() + pad ), y = math.round( objectives_title:bottom() ), w = left_panel:w() - (objectives_title:x() + pad) } )
	objectives_panel:set_valign( {math.round( y )/managers.gui_data:full_scaled_size().h,0} )
	-- objectives_panel:set_debug( true )
	
	--------------------------------------------------------------------------------------------------------
	-- Loot panel
	local loot_wrapper_panel = left_panel:panel( { visible = true, layer = 1, name = "loot_wrapper_panel", x = 0, y = 0 + math.round( managers.gui_data:full_scaled_size().height/2 ), h = math.round( managers.gui_data:full_scaled_size().height/2 ), w = left_panel:w() } )
	loot_wrapper_panel:set_valign( "center" )
	-- , valign = {1/2,1/2}
	-- loot_wrapper_panel:set_debug( true )
	
	local secured_loot_title = loot_wrapper_panel:text( { layer = 1, valign = "center", name = "secured_loot_title", color = Color.white, font_size = tweak_data.hud_stats.loot_title_size, font= tweak_data.hud_stats.objectives_font, text = utf8.to_upper( managers.localization:text( "hud_secured_loot" ) ), align = "left", vertical = "top", w = 512, h = 32 } )
	secured_loot_title:set_position( math.round( x ), 0 )
	managers.hud:make_fine_text( secured_loot_title )
	
	local mission_bags_title = loot_wrapper_panel:text( { layer = 1, valign = "center", name = "mission_bags_title", color = Color.white, font_size = tweak_data.hud_stats.loot_size, font= tweak_data.hud_stats.objectives_font, text = utf8.to_upper( managers.localization:text( "hud_mission_bags" ) ), align = "left", vertical = "top", w = 512, h = 32 } )
	mission_bags_title:set_position( math.round( x + pad ), 32 )
	managers.hud:make_fine_text( mission_bags_title )
	
	local mission_bags_panel = loot_wrapper_panel:panel( { visible = true, name = "mission_bags_panel", x = 0, y = 0, h = 32, w = left_panel:w() } )
	mission_bags_panel:set_lefttop( mission_bags_title:leftbottom() )
	mission_bags_panel:set_position( mission_bags_panel:x(), mission_bags_panel:y() + 4)
	-- mission_bags_panel:bitmap( { name = "bag_test", texture="guis/textures/pd2/hud_bag" } )
	-- "guis/textures/pd2/hud_bag"
	
	local bonus_bags_title = loot_wrapper_panel:text( { layer = 1, valign = "center", name = "bonus_bags_title", color = Color.white, font_size = tweak_data.hud_stats.loot_size, font= tweak_data.hud_stats.objectives_font, text = utf8.to_upper( managers.localization:text( "hud_bonus_bags" ) ), align = "left", vertical = "top", w = 512, h = 32 } )
	bonus_bags_title:set_position( math.round( x + pad ), 96 )
	managers.hud:make_fine_text( bonus_bags_title )
	
	local bonus_bags_panel = loot_wrapper_panel:panel( { visible = true, name = "bonus_bags_panel", x = 0, y = 0, h = 20, w = left_panel:w() } )
	bonus_bags_panel:set_lefttop( bonus_bags_title:leftbottom() )
	bonus_bags_panel:set_position( bonus_bags_panel:x(), bonus_bags_panel:y() + 4 )
	bonus_bags_panel:grow( -bonus_bags_panel:x(), 0 )
	-- bonus_bags_panel:bitmap( { name = "bag_test", texture="guis/textures/pd2/hud_bag" } )
	
	local bonus_bags_payout = loot_wrapper_panel:text( { layer = 1, valign = "center", name = "bonus_bags_payout", color = Color.white, font_size = tweak_data.hud_stats.loot_size, font= tweak_data.hud_stats.objectives_font, text = "", align = "left", vertical = "top", w = 512, h = 32 } )
	bonus_bags_payout:set_text( utf8.to_upper( managers.localization:text( "hud_bonus_bags_payout", { MONEY = managers.experience:cash_string( 0 ) } ) ) )
	bonus_bags_payout:set_position( bonus_bags_title:left(), bonus_bags_panel:bottom() - 0 )
	managers.hud:make_fine_text( bonus_bags_payout )
	bonus_bags_payout:set_w( loot_wrapper_panel:w() )
	
	local instant_cash_title = loot_wrapper_panel:text( { layer = 1, valign = "center", name = "instant_cash_title", color = Color.white, font_size = tweak_data.hud_stats.loot_size, font= tweak_data.hud_stats.objectives_font, text = utf8.to_upper( managers.localization:text( "hud_instant_cash" ) ), align = "left", vertical = "top", w = 512, h = 32 } )
	instant_cash_title:set_position( math.round( x + pad ), 192 )
	managers.hud:make_fine_text( instant_cash_title )
	
	local instant_cash_text = loot_wrapper_panel:text( { layer = 1, valign = "center", name = "instant_cash_text", color = Color.white, font_size = tweak_data.hud_stats.loot_size, font= tweak_data.hud_stats.objectives_font, text = managers.experience:cash_string( 0 ), align = "left", vertical = "top", w = 512, h = 32 } )
	instant_cash_text:set_position( instant_cash_title:left(), instant_cash_title:bottom() )
	managers.hud:make_fine_text( instant_cash_text )
	instant_cash_text:set_w( loot_wrapper_panel:w() )
	
	
	
		
	-- HIDDEN CHALLENGES PANEL!
	local challenges_wrapper_panel = left_panel:panel( { visible = false, layer = 1, valign = {1/2,1/2}, name = "challenges_wrapper_panel", x = 0, y = y + math.round( managers.gui_data:scaled_size().height/2 ), h = math.round( managers.gui_data:scaled_size().height/2 ), w = left_panel:w() } )
	-- challenges_wrapper_panel:set_debug( true )
	local _, by = managers.gui_data:corner_safe_to_full( 0, managers.gui_data:corner_scaled_size().height ) -- + managers.gui_data:corner_scaled_size().y/2 )
	challenges_wrapper_panel:set_bottom( by )
	challenges_wrapper_panel:set_valign( {by/managers.gui_data:full_scaled_size().h,0} ) 
	
	local last_completed_challenge_title = challenges_wrapper_panel:text( { layer = 1, valign = "center", name = "last_completed_challenge_title", color = Color.white, font_size = tweak_data.hud_stats.objectives_title_size, font= tweak_data.hud_stats.objectives_font, text_id="victory_last_completed_challenge", align = "left", vertical = "top", w = 512, h = 32 } )
	last_completed_challenge_title:set_position( math.round( x ), 0 )
	managers.hud:make_fine_text( last_completed_challenge_title )
	
	local challenges_panel = challenges_wrapper_panel:panel( { layer = 1, valign = "center", name = "challenges_panel", x = math.round( objectives_title:x() + pad ), y = last_completed_challenge_title:bottom(), w = left_panel:w() - (last_completed_challenge_title:x() + pad) } )
	
	local near_completion_title = challenges_wrapper_panel:text( { layer = 1, valign = "center", name = "near_completion_title", color = Color.white, font_size = tweak_data.hud_stats.objectives_title_size, font= tweak_data.hud_stats.objectives_font, text_id="menu_near_completion_challenges", align = "left", vertical = "top", w = 512, h = 32 } )
	near_completion_title:set_position( math.round( x ), math.round( challenges_wrapper_panel:h()/3 ) )
	managers.hud:make_fine_text( near_completion_title )
	
	local near_completion_panel = challenges_wrapper_panel:panel( { layer = 1, valign = "center", name = "near_completion_panel", x = math.round( objectives_title:x() + pad ), y = near_completion_title:bottom(), w = left_panel:w() - (near_completion_title:x() + pad) } )
	
	local right_panel = self._full_hud_panel:panel( { name = "right_panel", valign = "scale", w = self._full_hud_panel:w()/3 }  )
	right_panel:set_x( self._full_hud_panel:w() )
	right_panel:rect( { name = "rect_bg", color = Color( 0.0, 0.0, 0.0 ):with_alpha( 0.75 ), valign = "scale", blend_mode = "normal" } )
	local blur_bg = right_panel:bitmap( { name = "blur_bg", texture="guis/textures/test_blur_df", w = right_panel:w(), h = right_panel:h(), valign = "scale", render_template="VertexColorTexturedBlur3D", layer=-1 } )
	
	-----------------------------------------------------------------------
	-- Day panel
	local days_title = right_panel:text( { layer = 1, x = 20, y = y, name = "days_title", color = Color.white, font_size = tweak_data.hud_stats.loot_size, font= tweak_data.hud_stats.objectives_font, text = "DAY 1 OF 3", align = "left", vertical = "top", w = 512, h = 32 } )
	managers.hud:make_fine_text( days_title )
	days_title:set_w( right_panel:w() )
		
	local day_wrapper_panel = right_panel:panel( { visible = true, layer = 1, name = "day_wrapper_panel", x = 0, y = y + math.round( managers.gui_data:scaled_size().height/2 ), h = math.round( managers.gui_data:scaled_size().height/1.5 ), w = right_panel:w() } )
	day_wrapper_panel:set_position( days_title:x() + pad, days_title:bottom() )
	-- day_wrapper_panel:set_debug( true )
	day_wrapper_panel:set_w( right_panel:w() - x - day_wrapper_panel:x() )
	
	local day_title = day_wrapper_panel:text( { layer = 0, x = 0, y = 0, name = "day_title", color = Color.white, font_size = tweak_data.hud_stats.objectives_title_size, font= tweak_data.hud_stats.objectives_font, text = "BLUH!", align = "left", vertical = "top", w = 512, h = 32 } )
	managers.hud:make_fine_text( day_title )
	day_title:set_w( day_wrapper_panel:w() )
	
	local paygrade_title = day_wrapper_panel:text( { name = "paygrade_title", font=tweak_data.menu.pd2_medium_font, font_size=tweak_data.hud_stats.loot_size, text=managers.localization:to_upper_text( "cn_menu_contract_paygrade_header" ), color=Color.white } )
	managers.hud:make_fine_text( paygrade_title )
	paygrade_title:set_top( math.round( day_title:bottom() ) )
	
	-- Stars
		local job_data = managers.job:current_job_data()
		if job_data then
			local job_stars = managers.job:current_job_stars()
			local job_and_difficulty_stars = managers.job:current_job_and_difficulty_stars()
			
			local risk_color = tweak_data.screen_colors.risk -- Color(255, 255, 204, 0)/255
			local filled_star_rect = { 0, 32, 32, 32 }
			local empty_star_rect = { 32, 32, 32, 32 }
						
			local cy = paygrade_title:center_y()
			local sx = paygrade_title:right() + 8
			-- local sx = 0
			local level_data = { texture="guis/textures/pd2/mission_briefing/difficulty_icons", texture_rect=filled_star_rect, w=16, h=16, color=tweak_data.screen_colors.text, alpha=1 }
			local risk_data = { texture="guis/textures/pd2/crimenet_skull", w=16, h=16, color=risk_color, alpha=1 }
			--[[for i = 1, job_and_difficulty_stars do
				local x = sx + (i-1)*18
				local is_risk = i > job_stars
				local star_data = is_risk and risk_data or level_data
				
				local star = day_wrapper_panel:bitmap( star_data )
				star:set_x( x )
				star:set_center_y( math.round( cy ) )
			end]]
			
			
			for i = 1, 10 do -- job_and_difficulty_stars do
				local x = sx + (i-1)*20
				local alpha = (i>job_and_difficulty_stars) and 0.25 or 1
				local color = ((i>job_and_difficulty_stars) or (i<=job_stars)) and Color.white or risk_color 
				local star = day_wrapper_panel:bitmap( { texture="guis/textures/pd2/skilltree/locked", x=x, y=0, w=18, h=18, alpha=alpha, color = color } )
				star:set_center_y( math.round( cy ) )
			end
			
		end
	
	local day_payout = day_wrapper_panel:text( { layer = 0, x = 0, y = 0, name = "day_payout", color = Color.white, font_size = tweak_data.hud_stats.loot_size, font= tweak_data.hud_stats.objectives_font, text = "BLUH!", align = "left", vertical = "top", w = 512, h = 32 } )
	day_payout:set_text( utf8.to_upper( managers.localization:text( "hud_day_payout", { MONEY = managers.experience:cash_string( 0 ) } ) ) )
	managers.hud:make_fine_text( day_payout )
	day_payout:set_w( day_wrapper_panel:w() )
	day_payout:set_y( math.round( paygrade_title:bottom() ) )
	
	
	local bains_plan = day_wrapper_panel:text( { name = "bains_plan", text = managers.localization:to_upper_text("menu_description"), font = tweak_data.hud_stats.objective_desc_font, font_size = tweak_data.hud_stats.day_description_size+2, color = Color(1, 1, 1, 1), align = "left", vertical = "top", wrap = true, word_wrap = true, h = 128 } )
	managers.hud:make_fine_text( bains_plan )
	bains_plan:set_y( math.round( day_payout:bottom() + 20 ) )
	
	local day_description = day_wrapper_panel:text( { name = "day_description", text = "sdsd", font = tweak_data.hud_stats.objective_desc_font, font_size = tweak_data.hud_stats.day_description_size, color = Color(1, 1, 1, 1), align = "left", vertical = "top", wrap = true, word_wrap = true, h = 128 } )
	day_description:set_y( math.round( bains_plan:bottom() ) )
	day_description:set_h( day_wrapper_panel:h() )
	
	--------------------------------------------------------------------------
	--
	
	local profile_wrapper_panel = right_panel:panel( { layer = 1, valign = {1/2,1/2}, name = "profile_wrapper_panel", x = 20, y = y + math.round( managers.gui_data:scaled_size().height/2 ), h = math.round( managers.gui_data:scaled_size().height/2 ), w = left_panel:w() } )
	profile_wrapper_panel:set_w( right_panel:w() - x - profile_wrapper_panel:x() )
	-- challenges_wrapper_panel:set_debug( true )
	local _, by = managers.gui_data:corner_safe_to_full( 0, managers.gui_data:corner_scaled_size().height ) -- + managers.gui_data:corner_scaled_size().y/2 )
	profile_wrapper_panel:set_bottom( by )
	profile_wrapper_panel:set_valign( {by/managers.gui_data:full_scaled_size().h,0} )
	-- profile_wrapper_panel:set_debug( true )
	
	--[[local next_level_data = managers.experience:next_level_data() or {}
		
	local bg_ring = profile_wrapper_panel:bitmap( { texture="guis/textures/pd2/endscreen/exp_ring", w=64, h=64, color=Color.black, alpha=0.4 } )
	local exp_ring = profile_wrapper_panel:bitmap( { texture="guis/textures/pd2/endscreen/exp_ring", w=64, h=64, color=Color((next_level_data.current_points or 1) / (next_level_data.points or 1), 1, 1), render_template="VertexColorTexturedRadial", blend_mode="add", layer=1 } )
	bg_ring:set_bottom( profile_wrapper_panel:h() )
	exp_ring:set_bottom( profile_wrapper_panel:h() )
	
	local level_text = profile_wrapper_panel:text( { name = "level_text", font=tweak_data.menu.pd2_medium_font, font_size=tweak_data.hud_stats.day_description_size, text=tostring(managers.experience:current_level()), color=tweak_data.screen_colors.text } )	
	managers.hud:make_fine_text( level_text )
	level_text:set_center( exp_ring:center() )
	
	-- managers.localization:text( "menu_cash", { money=managers.money:total_string() } )
	local money_text = profile_wrapper_panel:text( { name = "money_text", text=utf8.to_upper( managers.localization:text( "menu_cash", { money=managers.money:total_string() } ) ), font_size=tweak_data.hud_stats.day_description_size, font=tweak_data.menu.pd2_small_font, color=tweak_data.screen_colors.text } )
	managers.hud:make_fine_text( money_text )	
	money_text:set_left( math.round( exp_ring:right() ) )
	money_text:set_bottom( math.round( exp_ring:center_y() ) )
	
	local next_level_in = profile_wrapper_panel:text( { name = "next_level_in", text="", font_size=tweak_data.menu.pd2_small_font_size, font=tweak_data.menu.pd2_small_font, color=tweak_data.screen_colors.text } )
	local points = next_level_data.points - next_level_data.current_points
	next_level_in:set_text( utf8.to_upper( managers.localization:text( "menu_next_level" ).." "..points ) )
	managers.hud:make_fine_text( next_level_in )	
	next_level_in:set_left( math.round( exp_ring:right() ) )
	next_level_in:set_top( math.round( exp_ring:center_y() ) )]]
		
	-- local loot_text = right_panel:text( { layer = 1, name = "loot_text", color = Color.white, font_size = tweak_data.hud_stats.objectives_title_size, font= tweak_data.hud_stats.objectives_font, text="$250.000", align = "right", vertical = "top", w = right_panel:w()/3, h = 32 } )
	-- loot_text:set_position( math.round( -x ), math.round( y ) )
	
	-- local small_loot_text = right_panel:text( { layer = 1, name = "small_loot_text", color = Color.white, font_size = tweak_data.hud_stats.objectives_title_size, font= tweak_data.hud_stats.objectives_font, text="$250.000", align = "right", vertical = "top", w = right_panel:w()/3, h = 32 } )
	-- small_loot_text:set_position( math.round( -x ), math.round( y + 28 ) )
	
	-- local total_loot_text = right_panel:text( { layer = 1, name = "total_loot_text", color = Color.white, font_size = tweak_data.hud_stats.objectives_title_size, font= tweak_data.hud_stats.objectives_font, text="$250.000", align = "right", vertical = "top", w = right_panel:w()/3, h = 32 } )
	-- total_loot_text:set_position( math.round( -x ), math.round( y + 60 ) )
	
	-- right_panel:set_debug( true )
	-- self._full_hud_panel:set_debug( false )
	self:_rec_round_object( left_panel )
	self:_rec_round_object( right_panel )
end