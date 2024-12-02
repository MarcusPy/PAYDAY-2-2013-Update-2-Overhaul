CrimeNetContractGui = CrimeNetContractGui or class()

function CrimeNetContractGui:init( ws, fullscreen_ws, node )
	self._ws = ws
	self._fullscreen_ws = fullscreen_ws
	
	self._panel = self._ws:panel():panel( { layer=51 } )
	self._fullscreen_panel = self._fullscreen_ws:panel():panel( { layer=50 } )
	self._fullscreen_panel:rect( { color=Color.black, alpha=0.75, layer=0 } )
	
	-- self._sound_source = SoundDevice:create_source( "CrimeNetContractGui" )
	
	self._node = node
	local job_data = self._node:parameters().menu_component_data
	
	
	
	local width = 760
	local height = 540
	
	if not (SystemInfo:platform() == Idstring( "WIN32" )) then
		width = 800
		height = 500
	end
	
	local blur = self._fullscreen_panel:bitmap( { texture="guis/textures/test_blur_df", w=self._fullscreen_ws:panel():w(), h=self._fullscreen_ws:panel():h(), render_template="VertexColorTexturedBlur3D" } )
	local func = function(o)
		local start_blur = 0
		over( 0.6, function(p) o:set_alpha( math.lerp( start_blur, 1, p ) ) end)
	end	
	blur:animate( func )
	
	
	-- cn_menu_contact_header, cn_menu_join_contract_offer, cn_menu_executive_contract_offer, cn_menu_contract_header
	self._contact_text_header = self._panel:text( { text=" ", align="left", vertical="top", font_size=tweak_data.menu.pd2_large_font_size, font=tweak_data.menu.pd2_large_font, color=tweak_data.screen_colors.text } )
	
	do
		local x, y, w, h = self._contact_text_header:text_rect()
		self._contact_text_header:set_size( width, h )
		self._contact_text_header:set_center_x( self._panel:w() * 0.5 )
	end
	
	self._contract_panel = self._panel:panel( { h = height, w = width, layer = 1, x = self._contact_text_header:x(), y = self._contact_text_header:bottom() } )
	
	self._contract_panel:set_center_y( self._panel:h()*0.5 )
	self._contact_text_header:set_bottom( self._contract_panel:top() )
	
	if not job_data.job_id then
		local bottom = self._contract_panel:bottom()
		self._contract_panel:set_h( 160 )
		
		self._contract_panel:set_bottom( bottom )
		self._contact_text_header:set_bottom( self._contract_panel:top() )
	
		Global.a = job_data
		local host_name = job_data.host_name or ""
		local num_players = job_data.num_plrs or 1
		
		local server_text = managers.localization:to_upper_text( "menu_lobby_server_title" ) .. " " .. host_name
		local players_text = managers.localization:to_upper_text( "menu_players_online", { COUNT=tostring(num_players) } )
		
		
		self._contact_text_header:set_text( server_text .. "\n" .. players_text )
		self._contact_text_header:set_font( tweak_data.menu.pd2_medium_font_id )
		self._contact_text_header:set_font_size( tweak_data.menu.pd2_medium_font_size )
		
		
		local x, y, w, h = self._contact_text_header:text_rect()
		self._contact_text_header:set_size( width, h )
		self._contact_text_header:set_top( self._contract_panel:top() )
		self._contact_text_header:move( 10, 10 )
		
		
		
		BoxGuiObject:new( self._contract_panel, { sides={1, 1, 1, 1} } )

		self._step = 1
		self._steps = { }
		return
	end
	BoxGuiObject:new( self._contract_panel, { sides={1, 1, 1, 1} } )
	
	
	job_data.job_id = job_data.job_id or "ukrainian_job"
	
	local narrative = tweak_data.narrative.jobs[ job_data.job_id ]
	
	local text_w = width - 360
	local font_size = tweak_data.menu.pd2_small_font_size
	local font = tweak_data.menu.pd2_small_font
	local risk_color = tweak_data.screen_colors.risk


	self._contact_text_header:set_text( managers.localization:to_upper_text( "menu_cn_contract_title", { job=managers.localization:text(narrative.name_id) } ) )


	-- self._contact_text_header:set_debug(true)
	-- self._contract_panel:set_debug(true)
	local contract_text = self._contract_panel:text( { text=managers.localization:text( narrative.briefing_id ), align="left", vertical="top", w=text_w, font_size=font_size, font=font, color=tweak_data.screen_colors.text, wrap=true, wrap_word=true, x=10, y=10 } )
	do
		local _, _, _, h = contract_text:text_rect()
		-- contract_text:set_h(  )
		
		local scale = 1
		if h + contract_text:top() > math.round( self._contract_panel:h() * 0.5 ) - font_size then
			scale = (math.round( self._contract_panel:h() * 0.5 ) - font_size) / (h + contract_text:top())
		end
		contract_text:set_font_size( font_size * scale )
	end
		
	local contact_w = width-(text_w+20)-10
	local contact_h = contact_w / (16/9)
	
	
	--[[
		info_text:set_y( y )
		info_text:set_h( th ) -- math.min( th, box_h - 20 - 3 * self._real_small_font_size ) )
		
		local scale = 1
		if info_text:h() + y > self._info_texts_panel:h() then
			scale = self._info_texts_panel:h() / (info_text:h() + info_text:y())
		end
		
		info_text:set_font_size( small_font_size * scale )
		_, _, _, th = info_text:text_rect()
		info_text:set_h( th )]]
	local contact_panel = self._contract_panel:panel( { w=contact_w, h=contact_h, x=text_w+20, y=10 } )
	local contact_image = contact_panel:rect( { color=Color( 0.3, 0.0, 0.0, 0.0 ) } )
	local crimenet_videos = narrative.crimenet_videos
	if crimenet_videos then
		local variant = math.random( #crimenet_videos )
		-- print( variant, #crimenet_videos )
		
		contact_panel:video( { video = "movies/" .. crimenet_videos[variant], width = contact_panel:w(), height = contact_panel:h(), blend_mode="add", loop=true, color=tweak_data.screen_colors.button_stage_2 } )
	end
	
	-- 
	-- local contact_image = self._contract_panel:bitmap( { texture="guis/textures/pd2/crimenet_portrait_" .. narrative.contact, w=180, h=230, texture_rect={0,0,100,128}, blend_mode="add", x=contract_text:right()+20, y=10 } )
	local contact_text = self._contract_panel:text( { text=managers.localization:to_upper_text( tweak_data.narrative.contacts[narrative.contact].name_id ), font_size=font_size, font=font, color=tweak_data.screen_colors.text } )
	do
		local x, y, w, h = contact_text:text_rect()
		contact_text:set_size( w, h )
	end
	contact_text:set_position( contact_panel:left(), contact_panel:bottom() + 5 )
	BoxGuiObject:new( contact_panel, { sides={1, 1, 1, 1} } )

	
	if narrative.professional then
		local pro_warning_text = self._contract_panel:text( { name = "pro_warning_text", text = managers.localization:to_upper_text( "menu_pro_warning" ), font = font, font_size = font_size, color = tweak_data.screen_colors.pro_color, align = "left", vertical = "top", wrap = true, word_wrap = true, h = 128, x = 10, w = text_w } )
		self:make_fine_text( pro_warning_text )
		pro_warning_text:set_h( pro_warning_text:h() + 10 )
		pro_warning_text:set_bottom( math.round( self._contract_panel:h() * 0.5 ) )
	end
	
	local risk_title = self._contract_panel:text( { font=font, font_size=font_size, text=managers.localization:to_upper_text( "menu_risk" ), color=risk_color, x = 10 } )
	self:make_fine_text( risk_title )
	risk_title:set_top( math.round( self._contract_panel:h() * 0.5 ) )
	
	local menu_risk_id = "menu_risk_pd"
	if job_data.difficulty == "hard" then
		menu_risk_id = "menu_risk_swat"
	elseif job_data.difficulty == "overkill" then
		menu_risk_id = "menu_risk_fbi"
	elseif job_data.difficulty == "overkill_145" then
		menu_risk_id = "menu_risk_special"
	end
	
	local risk_text = self._contract_panel:text( { name = "risk_text", w = text_w, text = managers.localization:to_upper_text( menu_risk_id ).." ", font = font, font_size = font_size, color = risk_color, align = "left", vertical = "top", wrap = true, word_wrap = true, x = 10 } )
	self:make_fine_text( risk_text )
	risk_text:set_h( risk_text:h() + 10 )
	risk_text:set_top( math.round( risk_title:bottom() + 10 ) )
	risk_text:hide()
			
	local potential_rewards_title = self._contract_panel:text( { font=font, font_size=font_size, text=managers.localization:to_upper_text( "menu_potential_rewards" ), color=tweak_data.screen_colors.text, x = 10 } )
	self:make_fine_text( potential_rewards_title )
	potential_rewards_title:set_top( math.round( risk_text:bottom() + 4 ) )
	
	local paygrade_title = self._contract_panel:text( { font=font, font_size=font_size, text=managers.localization:to_upper_text( "cn_menu_contract_paygrade_header" ), color=tweak_data.screen_colors.text, x = 10 } )
	self:make_fine_text( paygrade_title )
	paygrade_title:set_top( math.round( potential_rewards_title:bottom() + 4 ) )
	
	--[[
	local stage_experience_title
	if #narrative.chain > 1 then
		stage_experience_title = self._contract_panel:text( { font=font, font_size=font_size, text=managers.localization:to_upper_text( "menu_experience_stage" ), color=tweak_data.screen_colors.text, x = 10 } )
		self:make_fine_text( stage_experience_title )
		stage_experience_title:set_top( math.round( paygrade_title:bottom() ) )
	end
	]]
	local experience_title = self._contract_panel:text( { font=font, font_size=font_size, text=managers.localization:to_upper_text( "menu_experience" ), color=tweak_data.screen_colors.text, x = 10 } )
	self:make_fine_text( experience_title )
	experience_title:set_top( math.round( paygrade_title:bottom() ) )
	
	local stage_cash_title
	-- if #narrative.chain > 1 then
		stage_cash_title = self._contract_panel:text( { font=font, font_size=font_size, text=managers.localization:to_upper_text( "menu_cash_stage", { money = "" } ), color=tweak_data.screen_colors.text, x = 10 } )
		self:make_fine_text( stage_cash_title )
		stage_cash_title:set_top( math.round( experience_title:bottom() ) )
	-- end
		
	local cash_title = self._contract_panel:text( { font=font, font_size=font_size, text=managers.localization:to_upper_text( "menu_cash_job", { money = "" } ), color=tweak_data.screen_colors.text, x = 10 } )
	self:make_fine_text( cash_title )
	cash_title:set_top( math.round( stage_cash_title:bottom() ) )
		
	local sx = math.max( paygrade_title:w(), experience_title:w() )
	
	-- if #narrative.chain > 1 then
		sx = math.max( sx, stage_cash_title:w() )
	-- end
	sx = math.max( sx, cash_title:w() ) + 24
	
	-- if false and job_data then
		local plvl = managers.experience:current_level()
		local player_stars = math.max( math.ceil( plvl / 10 ), 1 )
		local job_stars = math.ceil( narrative.jc/10 )
		local difficulty_stars = job_data.difficulty_id - 2
		local job_and_difficulty_stars = job_stars + difficulty_stars
		-- Risk images
		local filled_star_rect = { 0, 32, 32, 32 }
		
		local diff_names = { "risk_pd", "risk_swat", "risk_fbi", "risk_death_squad" }
		
		local rsx = risk_title:right() + 12
		for i,name in ipairs( { "risk_pd", "risk_swat", "risk_fbi", "risk_death_squad" } ) do	
			if i ~= 1 then
				local texture, rect = tweak_data.hud_icons:get_icon_data( name )
				local active = false -- (i <= difficulty_stars + 1)
				local color = (active and i~=1) and risk_color or Color.white
				local alpha = active and 1 or 0.25
				local risk = self._contract_panel:bitmap( { name=name, texture="guis/textures/pd2/skilltree/locked", x=0, y=0, w=25, h=25, alpha=alpha, color = color } )
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
		
		local level_data = { texture="guis/textures/pd2/mission_briefing/difficulty_icons", texture_rect=filled_star_rect, w=20, h=20, color=tweak_data.screen_colors.text, alpha=0.25*0 }
		local risk_data = { texture="guis/textures/pd2/crimenet_skull", w=20, h=20, color=tweak_data.screen_colors.text, alpha=0.25*0 }

		--[[for i = 1, 7 do
			local is_risk = (i>job_stars)
			local star_data = level_data
			star_data.name = "star"..tostring(i)
			
			local star = self._contract_panel:bitmap( star_data )
			
			star:set_x( math.round( sx + (i-1)*22 ) )
			star:set_center_y( math.round( cy ) )
		end
		
		for i = 8, 10 do
			local star_data = risk_data
			star_data.name = "star"..tostring(i)
			
			local star = self._contract_panel:bitmap( star_data )
			
			star:set_x( math.round( sx + (i-1)*22 ) )
			star:set_center_y( math.round( cy ) )
		end
		
		
		for i = 1, job_and_difficulty_stars do
			local is_risk = i > job_stars
			local star_data = is_risk and risk_data or level_data
			star_data.name = "star"..tostring(i)
			
			local star = self._contract_panel:bitmap( star_data )
			
			star:set_x( math.round( sx + (i-1)*22 ) )
			star:set_center_y( math.round( cy ) )
		end]]
		
		for i = 1, 10 do -- job_and_difficulty_stars do
			local x = sx + (i-1)*18
			local alpha = 0.25 -- (i>job_and_difficulty_stars) and 0.25 or 1
			local color = Color.white -- ((i>job_and_difficulty_stars) or (i<=job_stars)) and Color.white or risk_color 
			local star = self._contract_panel:bitmap( { name="star"..tostring(i) , texture="guis/textures/pd2/skilltree/locked", x=x, y=0, w=16, h=16, alpha=alpha, color = color } )
			star:set_center_y( math.round( cy ) )
		end
		
		
		-- Experience - JOB
		local cy = experience_title:center_y()
		local xp_stage_stars = managers.experience:get_stage_xp_by_stars( job_stars )
		local xp_job_stars = managers.experience:get_job_xp_by_stars( job_stars )
		local xp_multiplier = managers.experience:get_contract_difficulty_multiplier( difficulty_stars )
		
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
		
		local job_xp = self._contract_panel:text( { font=font, font_size=font_size, text="0", color=tweak_data.screen_colors.text } )
		-- job_xp:set_text( xp_job_stars + xp_stage_stars )
		self:make_fine_text( job_xp )
		job_xp:set_x( sx )
		job_xp:set_center_y( math.round( cy ) )
		
		local add_xp = self._contract_panel:text( { font=font, font_size=font_size, text="", color=risk_color } )
		add_xp:set_text( " +"..(math.round( 0 ) ) )
		self:make_fine_text( add_xp )
		add_xp:set_x( math.round( job_xp:right() ) )
		add_xp:set_center_y( math.round( cy ) )
		
			-- Money - STAGE
		local money_stage_stars = 0
		local money_multiplier = managers.money:get_contract_difficulty_multiplier( difficulty_stars )
		-- if #narrative.chain > 1 then
			local cy = stage_cash_title:center_y()
			money_stage_stars = managers.money:get_stage_payout_by_stars( job_stars )
			
			local stage_cash = self._contract_panel:text( { font=font, font_size=font_size, text=tostring(#narrative.chain) .. " x " .. managers.experience:cash_string(0), color=tweak_data.screen_colors.text } )
			-- stage_cash:set_text( tostring(#narrative.chain) .. " x " .. managers.experience:cash_string( money_stage_stars ) )
			self:make_fine_text( stage_cash )
			stage_cash:set_x( sx )
			stage_cash:set_center_y( math.round( cy ) )
			
			local stage_add_cash = self._contract_panel:text( { font=font, font_size=font_size, text="", color=risk_color } )
			stage_add_cash:set_text( " +"..tostring(#narrative.chain) .. " x " .. managers.experience:cash_string(math.round( 0 ) ) )
			self:make_fine_text( stage_add_cash )
			stage_add_cash:set_x( math.round( stage_cash:right() ) )
			stage_add_cash:set_center_y( math.round( cy ) )
		-- end
		
		-- Money - JOB
		cy = cash_title:center_y()
	
		local money_job_stars = managers.money:get_job_payout_by_stars( job_stars )
		
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
		
		local job_cash = self._contract_panel:text( { font=font, font_size=font_size, text=managers.experience:cash_string(0), color=tweak_data.screen_colors.text } )
		-- job_cash:set_text( managers.experience:cash_string( money_job_stars - money_stage_stars ) )
		self:make_fine_text( job_cash )
		job_cash:set_x( sx )
		job_cash:set_center_y( math.round( cy ) )
		
		local add_cash = self._contract_panel:text( { font=font, font_size=font_size, text="", color=risk_color } )
		add_cash:set_text( " +"..managers.experience:cash_string(math.round( 0 ) ) )
		self:make_fine_text( add_cash )
		add_cash:set_x( math.round( job_cash:right() ) )
		add_cash:set_center_y( math.round( cy ) )
		
		
		-- local payday_money = math.round( money_job_stars + tweak_data.money_manager.flat_job_completion + money_job_stars * money_multiplier + (money_stage_stars + tweak_data.money_manager.flat_stage_completion + money_stage_stars * money_multiplier) * (#narrative.chain) )
		local payday_money = math.round( money_job_stars + tweak_data:get_value( "money_manager", "flat_job_completion" ) + money_job_stars * money_multiplier + (money_stage_stars + tweak_data:get_value( "money_manager", "flat_stage_completion" ) + money_stage_stars * money_multiplier) * (#narrative.chain) )
		-- local payday_string = managers.localization:to_upper_text( "menu_payday", { MONEY = payday_money } )
		local payday_text = self._contract_panel:text( { font=tweak_data.menu.pd2_large_font, font_size=tweak_data.menu.pd2_large_font_size, text=managers.localization:to_upper_text( "menu_payday", { MONEY = managers.experience:cash_string(0)} ), color=tweak_data.screen_colors.text, x = 10 } )
		self:make_fine_text( payday_text )
		payday_text:set_bottom( self._contract_panel:h() - 10 )
	-- end
	
	
	
	self._briefing_event = narrative.briefing_event
	if self._briefing_event then
		self._briefing_len_panel = self._contract_panel:panel( { w=contact_image:w(), h=font_size*2+20 } )
		self._briefing_len_panel:rect( { name="duration", w=0, color=tweak_data.screen_colors.button_stage_3:with_alpha(0.2), alpha=0.6, blend_mode="add", halign="grow", valign="grow" } )
		self._briefing_len_panel:text( { name="text", font=font, font_size=font_size, text="", color=tweak_data.screen_colors.text, x = 10, y=10, layer=1, blend_mode="add" } )
		local button_text = self._briefing_len_panel:text( { name="button_text", font=font, font_size=font_size, text=" ", color=tweak_data.screen_colors.text, x = 10, y=10, layer=1, blend_mode="add" } )
		
		local _, _, _, h = button_text:text_rect()
		self._briefing_len_panel:set_h( h*2+20 )
		
		if managers.menu:is_pc_controller() then
			button_text:set_color( tweak_data.screen_colors.button_stage_3 )
		end
		
		BoxGuiObject:new( self._briefing_len_panel, { sides={1, 1, 1, 1} } )
		self._briefing_len_panel:set_position( contact_text:left(), contact_text:bottom() + 10 )
	end
	
	local days_multiplier = 0
	-- local day_tweak = narrative.professional and tweak_data.experience_manager.pro_day_multiplier or tweak_data.experience_manager.day_multiplier
	for i=1, #narrative.chain do
		local day_mul = narrative.professional and tweak_data:get_value( "experience_manager", "pro_day_multiplier", i ) or tweak_data:get_value( "experience_manager", "day_multiplier", i )
		days_multiplier = days_multiplier + (day_mul-1)
	end
	days_multiplier = 1 + ( days_multiplier / #narrative.chain )
	
	local last_day_mul = narrative.professional and tweak_data:get_value( "experience_manager", "pro_day_multiplier", #narrative.chain ) or tweak_data:get_value( "experience_manager", "day_multiplier", #narrative.chain )
		
	self._data = {}
	-- self._data.job_cash = money_job_stars + tweak_data.money_manager.flat_job_completion
	self._data.job_cash = money_job_stars + tweak_data:get_value( "money_manager", "flat_job_completion" )
	self._data.add_job_cash = money_job_stars * money_multiplier
	-- self._data.stage_cash = money_stage_stars + tweak_data.money_manager.flat_stage_completion
	self._data.stage_cash = money_stage_stars + tweak_data:get_value( "money_manager", "flat_stage_completion" )
	self._data.add_stage_cash = money_stage_stars * money_multiplier
	-- self._data.payday_string = payday_string
	self._data.experience = xp_job_stars * last_day_mul + xp_stage_stars + xp_stage_stars * (#narrative.chain-1) * days_multiplier
	self._data.add_experience = self._data.experience * xp_multiplier
	self._data.num_stages_string = tostring(#narrative.chain) .. " x "
	self._data.payday_money = payday_money
	self._data.counted_payday_money = 0
	
	self._data.stars = { job_and_difficulty_stars=job_and_difficulty_stars, job_stars=job_stars, difficulty_stars=difficulty_stars}
	
	self._data.gui_objects = {}
	self._data.gui_objects.risk_text = risk_text
	self._data.gui_objects.payday_text = payday_text
	self._data.gui_objects.job_cash = job_cash
	self._data.gui_objects.job_add_cash = add_cash
	self._data.gui_objects.stage_cash = stage_cash
	self._data.gui_objects.stage_add_cash = stage_add_cash
	self._data.gui_objects.add_xp = add_xp
	self._data.gui_objects.job_xp = job_xp
	self._data.gui_objects.risks = { "risk_pd", "risk_swat", "risk_fbi", "risk_death_squad" }
	self._data.gui_objects.num_stars = 10
	
	self._wait_t = 0
	
	local next_level_data = managers.experience:next_level_data() or {}
	local gain_xp = self._data.experience + self._data.add_experience
	local at_max_level = managers.experience:current_level() == managers.experience:level_cap()
	local can_lvl_up = not at_max_level and ( gain_xp >= (next_level_data.points - next_level_data.current_points) )
	if not at_max_level and can_lvl_up then
		local text = managers.localization:to_upper_text( "hud_potential_level_up" )
		local potential_level_up_text = self._contract_panel:text( { layer = 3, name = "potential_level_up_text", blend_mode = "normal", visible = false, text=text, font_size=tweak_data.menu.pd2_small_font_size, font=tweak_data.menu.pd2_small_font, color=tweak_data.hud_stats.potential_xp_color } )
		self:make_fine_text( potential_level_up_text )	
		potential_level_up_text:set_left( math.round( add_xp:right() + 4 ) )
		potential_level_up_text:set_top( math.round( add_xp:top() ) )
		-- potential_level_up_text:animate( callback( self, self, "_animate_text_pulse" ), exp_gain_ring, exp_ring )
		
		self._data.gui_objects.potential_level_up_text = potential_level_up_text
		self._data.gui_objects.when_to_level_up = (next_level_data.points - next_level_data.current_points)
	end
	

		
	self._step = 1
	self._steps = {
		"set_time",
		"start_sound",
		"count_job_stars",
		"count_difficulty_stars",
		"start_count_payday",
		"count_payday",
		"end_count_payday",
		"free_memory",
	}
	
	self._current_job_star = 0
	self._current_difficulty_star = 0
	
	self._post_event_params = { show_subtitle = false, listener = { clbk=callback( self, self, "sound_event_callback" ), duration=true, end_of_event=true } }
	
	managers.menu:active_menu().input:deactivate_controller_mouse()
	
	self:_rec_round_object( self._panel )
end