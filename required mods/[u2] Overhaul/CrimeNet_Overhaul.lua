if RequiredScript == "lib/managers/crimenetmanager" then

	local _setup_vars_orig = CrimeNetManager._setup_vars
	function CrimeNetManager:_setup_vars(...)
		_setup_vars_orig(self, ...)
		
		self._active_job_time = 10 --self._tweak_data.job_vars.active_job_time -- 25
		self._NEW_JOB_MIN_TIME = 0.5 --self._tweak_data.job_vars.new_job_min_time -- 3.5 -- 7
		self._NEW_JOB_MAX_TIME = 0.5 --self._tweak_data.job_vars.new_job_max_time -- 3.5 -- 7
		self._next_job_timer = 0.5 --(self._NEW_JOB_MIN_TIME + self._NEW_JOB_MAX_TIME) / 2
		self._MAX_ACTIVE_JOBS = 30--self._tweak_data.job_vars.max_active_jobs -- 10 -- 6

		self._refresh_server_t = 0
		self._REFRESH_SERVERS_TIME = self._tweak_data.job_vars.refresh_servers_time -- 5
		
		self._debug_mass_spawning = _G.u2_core.debug.crimenet_mass_spawning
		
		self._active_server_jobs = {}
	end
	
	local _get_jobs_by_jc_orig = CrimeNetManager._get_jobs_by_jc
	function CrimeNetManager:_get_jobs_by_jc(...)
		_get_jobs_by_jc_orig(self, ...)
		-- self.difficulties = { "easy", "normal", "hard", "overkill", "overkill_145" }
		-- this is the only solution that works, for real
		local t = {}
		if (_G.u2_core.settings.crimenet_heists.crimenet_random_difficulty == true) then
			local u2lowest = _G.u2_core.settings.crimenet_heists.crimenet_minimum_difficulty
			local u2highest = _G.u2_core.settings.crimenet_heists.crimenet_maximum_difficulty
			for _,job_id in ipairs( tweak_data.narrative:get_jobs_index() ) do
				local job_data = tweak_data.narrative.jobs[ job_id ]
				for i = (job_data.professional and 1 or 0), 3 do
					t[ job_data.jc + i * 10 ] = t[ job_data.jc + i * 10 ] or {}
					local difficulty_id = 2 + math.random(u2lowest, u2highest)
					local difficulty = tweak_data:index_to_difficulty( difficulty_id )
					table.insert( t[ job_data.jc + i * 10 ], { job_id = job_id, difficulty_id = difficulty_id, difficulty = difficulty } )
					--log("key: " .. tostring(job_data.jc + i * 10 ) .. " value: " .. tostring(t[ job_data.jc + i * 10 ]))
				end
			end
		elseif (_G.u2_core.settings.crimenet_heists.crimenet_random_difficulty == false) then
			for _,job_id in ipairs( tweak_data.narrative:get_jobs_index() ) do
				local job_data = tweak_data.narrative.jobs[ job_id ]
				for i = (job_data.professional and 1 or 0), 3 do
					t[ job_data.jc + i * 10 ] = t[ job_data.jc + i * 10 ] or {}
					local difficulty_id = 2 + _G.u2_core.settings.crimenet_heists.crimenet_forced_difficulty
					local difficulty = tweak_data:index_to_difficulty( difficulty_id )
					table.insert( t[ job_data.jc + i * 10 ], { job_id = job_id, difficulty_id = difficulty_id, difficulty = difficulty } )
				end
			end
		end

		return t
	end
	
	local is_win32 = SystemInfo:platform() == Idstring("WIN32")
	local is_ps3 = SystemInfo:platform() == Idstring("PS3")
	local is_x360 = SystemInfo:platform() == Idstring("X360")
	local is_xb1 = SystemInfo:platform() == Idstring("XB1")
	local is_ps4 = SystemInfo:platform() == Idstring("PS4")

	local xmas_ = false

	function CrimeNetGui:init(ws, fullscreeen_ws, node, ...)
		self._tweak_data = tweak_data.gui.crime_net
		self._crimenet_enabled = true

		managers.menu_component:post_event("crime_net_startup")
		self._crimenet_ambience = managers.menu_component:post_event( "crimenet_ambience" )
		managers.menu_component:close_contract_gui()

		local no_servers = node:parameters().no_servers

		if no_servers then
			managers.crimenet:start_no_servers()
		else
			managers.crimenet:start()
		end

		managers.menu:active_menu().renderer.ws:hide()

		local safe_scaled_size = managers.gui_data:safe_scaled_size()
		self._ws = ws
		self._fullscreen_ws = fullscreeen_ws
		self._fullscreen_panel = self._fullscreen_ws:panel():panel({name = "fullscreen"})
		self._panel = self._ws:panel():panel({name = "main"})
		local full_16_9 = managers.gui_data:full_16_9_size()

		self._fullscreen_panel:bitmap({
			texture = "guis/textures/test_blur_df",
			name = "blur_top",
			render_template = "VertexColorTexturedBlur3D",
			rotation = 360,
			x = 0,
			layer = 1001,
			w = self._fullscreen_ws:panel():w(),
			h = full_16_9.convert_y * 2,
			y = -full_16_9.convert_y
		})
		self._fullscreen_panel:bitmap({
			texture = "guis/textures/test_blur_df",
			name = "blur_right",
			render_template = "VertexColorTexturedBlur3D",
			rotation = 360,
			y = 0,
			layer = 1001,
			w = full_16_9.convert_x * 2,
			h = self._fullscreen_ws:panel():h(),
			x = self._fullscreen_ws:panel():w() - full_16_9.convert_x
		})
		self._fullscreen_panel:bitmap({
			texture = "guis/textures/test_blur_df",
			name = "blur_bottom",
			render_template = "VertexColorTexturedBlur3D",
			rotation = 360,
			x = 0,
			layer = 1001,
			w = self._fullscreen_ws:panel():w(),
			h = full_16_9.convert_y * 2,
			y = self._fullscreen_ws:panel():h() - full_16_9.convert_y
		})
		self._fullscreen_panel:bitmap({
			texture = "guis/textures/test_blur_df",
			name = "blur_left",
			render_template = "VertexColorTexturedBlur3D",
			rotation = 360,
			y = 0,
			layer = 1001,
			w = full_16_9.convert_x * 2,
			h = self._fullscreen_ws:panel():h(),
			x = -full_16_9.convert_x
		})
		self._panel:rect({
			blend_mode = "add",
			h = 2,
			y = 0,
			x = 0,
			layer = 1,
			w = self._panel:w(),
			color = tweak_data.screen_color_blue
		})
		self._panel:rect({
			blend_mode = "add",
			h = 2,
			y = 0,
			x = 0,
			layer = 1,
			w = self._panel:w(),
			color = tweak_data.screen_color_blue
		}):set_bottom(self._panel:h())
		self._panel:rect({
			blend_mode = "add",
			y = 0,
			w = 2,
			x = 0,
			layer = 1,
			h = self._panel:h(),
			color = tweak_data.screen_color_blue
		}):set_right(self._panel:w())
		self._panel:rect({
			blend_mode = "add",
			y = 0,
			w = 2,
			x = 0,
			layer = 1,
			h = self._panel:h(),
			color = tweak_data.screen_color_blue
		})

		self._rasteroverlay = self._fullscreen_panel:bitmap({
			texture = "guis/textures/crimenet_map_rasteroverlay",
			name = "rasteroverlay",
			layer = 3,
			wrap_mode = "wrap",
			blend_mode = "mul",
			texture_rect = {
				0,
				0,
				32,
				256
			},
			color = Color(1, 1, 1, 1),
			w = self._fullscreen_panel:w(),
			h = self._fullscreen_panel:h()
		})

		if (_G.u2_core.settings.crimenet_visuals.crimenet_vignette == true) then
			self._fullscreen_panel:bitmap({
				texture = "guis/textures/crimenet_map_vignette",
				name = "vignette",
				blend_mode = "mul",
				layer = 2,
				color = Color(1, 1, 1, 1),
				w = self._fullscreen_panel:w(),
				h = self._fullscreen_panel:h()
			})
		end

		local bd_light = self._fullscreen_panel:bitmap({
			texture = "guis/textures/pd2/menu_backdrop/bd_light",
			name = "bd_light",
			layer = 4
		})

		bd_light:set_size(self._fullscreen_panel:size())
		bd_light:set_alpha(0)
		bd_light:set_blend_mode("add")

		local function light_flicker_animation(o)
			local alpha = 0
			local acceleration = 0
			local wanted_alpha = math.rand(1) * 0.3
			local flicker_up = true

			while true do
				wait(0.009, self._fixed_dt)
				over(0.045, function (p)
					o:set_alpha(math.lerp(alpha, wanted_alpha, p))
				end, self._fixed_dt)

				flicker_up = not flicker_up
				alpha = o:alpha()
				wanted_alpha = math.rand(flicker_up and alpha or 0.2, not flicker_up and alpha or 0.3)
			end
		end

		bd_light:animate(light_flicker_animation)

		local back_button = self._panel:text({
			vertical = "bottom",
			name = "back_button",
			blend_mode = "add",
			align = "right",
			layer = 40,
			text = managers.localization:to_upper_text("menu_back"),
			font_size = 36,
			font = tweak_data.menu.default_font,
			color = tweak_data.screen_color_yellow
		})

		self:make_fine_text(back_button)
		back_button:set_right(self._panel:w() - 10)
		back_button:set_bottom(self._panel:h() - 10)
		back_button:set_visible(managers.menu:is_pc_controller())

		local back_button_bg = self._panel:rect( { blend_mode="add", h=back_button:h() * 2, w = back_button:w() * 2, layer=27, color=tweak_data.screen_colors.button_stage_2, alpha=0.1 } )
		back_button_bg:set_right( back_button:right()+5 )
		back_button_bg:set_bottom( back_button:bottom()+5 )
		
		local map_coord_text = self._panel:text( { name="map_coord_text", text=utf8.to_upper( managers.localization:text("cn_menu_mapcoords", {zoom=1, x="000.00", y="000.00"}) ), align="left", vertical="bottom", h=tweak_data.menu.pd2_medium_font_size ,font_size=tweak_data.menu.pd2_medium_font_size, font=tweak_data.menu.default_font, color=tweak_data.screen_colors.button_stage_2, layer=28 } )
		self:make_fine_text( map_coord_text )
		map_coord_text:set_left( 15 )
		map_coord_text:set_bottom( self._panel:h() - 15 )

		local map_coord_text_bg = self._panel:rect( { blend_mode="add", h=back_button_bg:h(), w = map_coord_text:w() * 2, layer=27, color=tweak_data.screen_colors.button_stage_2, alpha=0.1 } )
		map_coord_text_bg:set_left( map_coord_text:left()-5 )
		map_coord_text_bg:set_bottom( map_coord_text:bottom()+5 )
		
		local num_contracts_text = self._panel:text( { name="num_contracts_text", text=managers.localization:text("cn_menu_num_contracts", {contracts="", friends=""}), align="left", vertical="top", h=tweak_data.menu.pd2_small_font_size ,font_size=tweak_data.menu.pd2_small_font_size, font=tweak_data.menu.pd2_medium_font, color=tweak_data.screen_colors.text, layer=28 } )
		self:make_fine_text( num_contracts_text )
		num_contracts_text:set_left( 15 )
		num_contracts_text:set_top( 15 )
		
		local num_contracts_text_bg = self._panel:rect( { blend_mode="add", h=back_button_bg:h(), w = num_contracts_text:w() * 2, layer=27, color=tweak_data.screen_colors.button_stage_3, alpha=0.4 } )
		num_contracts_text_bg:set_left( num_contracts_text:left()-5 )
		num_contracts_text_bg:set_top( num_contracts_text:top()-5 )
		
		num_contracts_text:set_w( num_contracts_text_bg:w() )
		
		map_coord_text:set_w( map_coord_text_bg:w() )
		
		local blur_object = self._panel:bitmap({
			texture = "guis/textures/test_blur_df",
			name = "controller_legend_blur",
			render_template = "VertexColorTexturedBlur3D",
			layer = back_button:layer() - 1
		})

		blur_object:set_shape(back_button:shape())

		if not managers.menu:is_pc_controller() then
			blur_object:set_size(self._panel:w() * 0.5, tweak_data.menu.pd2_medium_font_size)
			blur_object:set_rightbottom(self._panel:w() - 2, self._panel:h() - 2)
		end

		--WalletGuiObject.set_wallet(self._panel)
		--WalletGuiObject.set_layer(30)
		--WalletGuiObject.move_wallet(10, -10)

		local text_id = Global.game_settings.single_player and "menu_crimenet_offline" or "cn_menu_num_players_offline"
		local num_players_text = self._panel:text({
			vertical = "top",
			name = "num_players_text",
			align = "left",
			layer = 40,
			text = managers.localization:to_upper_text(text_id, {amount = "1"}),
			font_size = 0,
			font = tweak_data.menu.pd2_small_font,
			color = tweak_data.screen_colors.text
		})

		self:make_fine_text(num_players_text)
		num_players_text:set_left(10)
		num_players_text:set_top(10)

		local blur_object = self._panel:bitmap({
			texture = "guis/textures/test_blur_df",
			name = "num_players_blur",
			render_template = "VertexColorTexturedBlur3D",
			layer = num_players_text:layer() - 1
		})

		blur_object:set_shape(num_players_text:shape())

		local legends_button = self._panel:text({
			name = "legends_button",
			blend_mode = "add",
			layer = 40,
			text = "",
			font_size = tweak_data.menu.pd2_small_font_size,
			font = tweak_data.menu.pd2_small_font,
			color = tweak_data.screen_colors.text
		})

		self:make_fine_text(legends_button)
		legends_button:set_right(self._panel:w() - 10)
		legends_button:set_top(10)
		legends_button:set_align("right")

		local blur_object = self._panel:bitmap({
			texture = "guis/textures/test_blur_df",
			name = "legends_button_blur",
			render_template = "VertexColorTexturedBlur3D",
			layer = legends_button:layer() - 1
		})

		blur_object:set_shape(legends_button:shape())

		if managers.menu:is_pc_controller() then
			legends_button:set_color(tweak_data.screen_colors.button_stage_3)
		end

		local w, h = nil
		local mw = 0
		local mh = nil
		local legend_panel = self._panel:panel({
			name = "legend_panel",
			visible = false,
			x = 10,
			layer = 40,
			y = legends_button:bottom() + 4
		})
		local host_icon = legend_panel:bitmap({
			texture = "guis/textures/pd2/crimenet_legend_host",
			x = 10,
			y = 10
		})
		local host_text = legend_panel:text({
			blend_mode = "add",
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_icon:right() + 2,
			y = host_icon:top(),
			text = managers.localization:to_upper_text("menu_cn_legend_host")
		})
		mw = math.max(mw, self:make_fine_text(host_text))
		local next_y = host_text:bottom()
		local join_icon = legend_panel:bitmap({
			texture = "guis/textures/pd2/crimenet_legend_join",
			x = 10,
			y = next_y
		})
		local join_text = legend_panel:text({
			blend_mode = "add",
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_text:left(),
			y = next_y,
			text = managers.localization:to_upper_text("menu_cn_legend_join")
		})
		mw = math.max(mw, self:make_fine_text(join_text))

		self:make_color_text(join_text, tweak_data.screen_colors.regular_color)

		next_y = join_text:bottom()
		local friends_icon = legend_panel:bitmap({
			texture = "guis/textures/pd2/crimenet_legend_join",
			x = 10,
			y = next_y,
			color = tweak_data.screen_colors.friend_color
		})
		local friends_text = legend_panel:text({
			blend_mode = "add",
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_text:left(),
			y = next_y,
			text = managers.localization:to_upper_text("menu_cn_legend_friends")
		})
		mw = math.max(mw, self:make_fine_text(friends_text))

		self:make_color_text(friends_text, tweak_data.screen_colors.friend_color)

		next_y = friends_text:bottom()

		local mutated_icon = legend_panel:bitmap({
			texture = "guis/textures/pd2/crimenet_legend_join",
			x = 10,
			y = next_y,
			color = tweak_data.screen_colors.mutators_color_text
		})
		local mutated_text = legend_panel:text({
			blend_mode = "add",
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_text:left(),
			y = next_y,
			text = managers.localization:to_upper_text("menu_cn_legend_mutated"),
			color = tweak_data.screen_colors.mutators_color_text
		})
		mw = math.max(mw, self:make_fine_text(mutated_text))
		next_y = mutated_text:bottom()
		local spree_icon = legend_panel:bitmap({
			texture = "guis/textures/pd2/crimenet_legend_join",
			x = 10,
			y = next_y,
			color = tweak_data.screen_colors.crime_spree_risk
		})
		local spree_text = legend_panel:text({
			blend_mode = "add",
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_text:left(),
			y = next_y,
			text = managers.localization:to_upper_text("cn_crime_spree"),
			color = tweak_data.screen_colors.crime_spree_risk
		})
		mw = math.max(mw, self:make_fine_text(spree_text))
		next_y = spree_text:bottom()
		local skirmish_icon = legend_panel:bitmap({
			texture = "guis/textures/pd2/crimenet_legend_join",
			x = 10,
			y = next_y,
			color = tweak_data.screen_colors.skirmish_color
		})
		local skirmish_text = legend_panel:text({
			blend_mode = "add",
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_text:left(),
			y = next_y,
			text = managers.localization:to_upper_text("menu_cn_skirmish"),
			color = tweak_data.screen_colors.skirmish_color
		})
		mw = math.max(mw, self:make_fine_text(skirmish_text))
		next_y = skirmish_text:bottom()
		local risk_icon = legend_panel:bitmap({
			texture = "guis/textures/pd2/crimenet_legend_risklevel",
			x = 10,
			y = next_y
		})
		local risk_text = legend_panel:text({
			blend_mode = "add",
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_text:left(),
			y = next_y,
			text = managers.localization:to_upper_text("menu_cn_legend_risk"),
			color = tweak_data.screen_colors.risk
		})
		mw = math.max(mw, self:make_fine_text(risk_text))
		next_y = risk_text:bottom()
		local ghost_icon = legend_panel:bitmap({
			texture = "guis/textures/pd2/cn_minighost",
			x = 7,
			y = next_y + 4,
			color = tweak_data.screen_colors.ghost_color
		})
		local ghost_text = legend_panel:text({
			blend_mode = "add",
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_text:left(),
			y = next_y,
			text = managers.localization:to_upper_text("menu_cn_legend_ghostable"),
			color = tweak_data.screen_colors.ghost_color
		})
		mw = math.max(mw, self:make_fine_text(ghost_text))
		next_y = ghost_text:bottom()
		local holiday_icon = legend_panel:bitmap({
			texture = "guis/textures/pd2/cn_mini_xmas",
			x = 10,
			y = next_y + 2,
			color = tweak_data.screen_colors.event_color,
			visible = xmas_
		})
		local holiday_text = legend_panel:text({
			blend_mode = "add",
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_text:left(),
			y = next_y,
			text = managers.localization:to_upper_text("menu_cn_legend_holiday"),
			color = tweak_data.screen_colors.event_color,
			visible = xmas_
		})
		mw = math.max(mw, self:make_fine_text(holiday_text))
		next_y = holiday_text:bottom()
		local kick_none_icon = legend_panel:bitmap({
			texture = "guis/textures/pd2/cn_kick_marker",
			x = 10,
			y = next_y + 2
		})
		local kick_none_text = legend_panel:text({
			blend_mode = "add",
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_text:left(),
			y = next_y,
			text = managers.localization:to_upper_text("menu_cn_kick_disabled")
		})
		mw = math.max(mw, self:make_fine_text(kick_none_text))
		local kick_vote_icon = legend_panel:bitmap({
			texture = "guis/textures/pd2/cn_votekick_marker",
			x = 10,
			y = kick_none_text:bottom() + 2
		})
		local kick_vote_text = legend_panel:text({
			blend_mode = "add",
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			x = host_text:left(),
			y = kick_none_text:bottom(),
			text = managers.localization:to_upper_text("menu_kick_vote")
		})
		mw = math.max(mw, self:make_fine_text(kick_vote_text))
		local last_text = kick_vote_text
		local job_plan_loud_icon, job_plan_loud_text, job_plan_stealth_icon, job_plan_stealth_text

		legend_panel:set_size(host_text:left() + mw + 10, last_text:bottom() + 10)
		legend_panel:rect({
			alpha = 0.4,
			layer = -1,
			color = Color.black
		})
		BoxGuiObject:new(legend_panel, {sides = {
			1,
			1,
			1,
			1
		}})
		legend_panel:bitmap({
			texture = "guis/textures/test_blur_df",
			render_template = "VertexColorTexturedBlur3D",
			layer = -1,
			w = legend_panel:w(),
			h = legend_panel:h()
		})
		legend_panel:set_right(self._panel:w() - 10)

		local w, h = nil
		local mw = 0
		local mh = nil
		local global_bonuses_panel = self._panel:panel({
			y = 10,
			name = "global_bonuses_panel",
			layer = 40,
			h = tweak_data.menu.pd2_small_font_size * 3
		})

		local function mul_to_procent_string(multiplier)
			local pro = math.round(multiplier * 100)
			local procent_string
			procent_string = pro == 0 and multiplier ~= 0 and string.format("%0.2f", math.abs(multiplier * 100)) or tostring(math.abs(pro))

			return procent_string, multiplier >= 0
		end

		if false then
			local skill_bonus = managers.player:get_skill_exp_multiplier()
			skill_bonus = skill_bonus - 1

			if skill_bonus > 0 then
				local skill_string = mul_to_procent_string(skill_bonus)
				local skill_text = global_bonuses_panel:text({
					blend_mode = "add",
					align = "center",
					font = tweak_data.menu.pd2_small_font,
					font_size = tweak_data.menu.pd2_small_font_size,
					text = managers.localization:to_upper_text("menu_cn_skill_bonus", {exp_bonus = skill_string}),
					color = tweak_data.screen_colors.skill_color
				})
			end

			local infamy_bonus = managers.player:get_infamy_exp_multiplier()
			infamy_bonus = infamy_bonus - 1

			if infamy_bonus > 0 then
				local infamy_string = mul_to_procent_string(infamy_bonus)
				local infamy_text = global_bonuses_panel:text({
					blend_mode = "add",
					align = "center",
					font = tweak_data.menu.pd2_small_font,
					font_size = tweak_data.menu.pd2_small_font_size,
					text = managers.localization:to_upper_text("menu_cn_infamy_bonus", {exp_bonus = infamy_string}),
					color = tweak_data.lootdrop.global_values.infamy.color
				})
			end

			local limited_bonus = managers.player:get_limited_exp_multiplier(nil, nil)
			limited_bonus = limited_bonus - 1

			if limited_bonus > 0 then
				local limited_string = mul_to_procent_string(limited_bonus)
				local limited_text = global_bonuses_panel:text({
					blend_mode = "add",
					align = "center",
					font = tweak_data.menu.pd2_small_font,
					font_size = tweak_data.menu.pd2_small_font_size,
					text = managers.localization:to_upper_text("menu_cn_limited_bonus", {exp_bonus = limited_string}),
					color = tweak_data.screen_colors.button_stage_2
				})
			end
		end

		if xmas_ then

			local limited_bonus = (tweak_data:get_value("experience_manager", "limited_xmas_bonus_multiplier") or 1) - 1

			if limited_bonus > 0 then
				local limited_string = mul_to_procent_string(limited_bonus)
				local limited_text = global_bonuses_panel:text({
					blend_mode = "add",
					align = "center",
					font = tweak_data.menu.pd2_small_font,
					font_size = tweak_data.menu.pd2_small_font_size,
					text = managers.localization:to_upper_text("menu_cn_holiday_bonus", {
						bonus = limited_string,
						event_icon = managers.localization:get_default_macro("BTN_XMAS")
					}),
					color = tweak_data.screen_colors.event_color
				})
			end

		end

		if #global_bonuses_panel:children() > 1 then
			for i, child in ipairs(global_bonuses_panel:children()) do
				child:set_alpha(0)
			end

			local function global_bonuses_anim(panel)
				local child_num = 1
				local viewing_child = panel:children()[child_num]
				local t = 0
				local dt = 0

				while alive(viewing_child) do
					if not self._crimenet_enabled then
						coroutine.yield()
					else
						viewing_child:set_alpha(0)
						over(0.5, function (p)
							viewing_child:set_alpha(math.sin(p * 90))
						end)
						viewing_child:set_alpha(1)
						over(4, function (p)
							viewing_child:set_alpha((math.cos(p * 360 * 2) + 1) * 0.5 * 0.2 + 0.8)
						end)
						over(0.5, function (p)
							viewing_child:set_alpha(math.cos(p * 90))
						end)
						viewing_child:set_alpha(0)

						child_num = child_num % #panel:children() + 1
						viewing_child = panel:children()[child_num]
					end
				end
			end

			global_bonuses_panel:animate(global_bonuses_anim)
		elseif #global_bonuses_panel:children() == 1 then

			local function global_bonuses_anim(panel)
				while alive(panel) do
					if not self._crimenet_enabled then
						coroutine.yield()
					else
						over(2, function (p)
							panel:set_alpha((math.sin(p * 360) + 1) * 0.5 * 0.2 + 0.8)
						end)
					end
				end
			end

			global_bonuses_panel:animate(global_bonuses_anim)
		end

		if not no_servers and not is_xb1 then
			local id = is_x360 and "menu_cn_friends" or "menu_cn_filter"
		elseif not no_servers and is_xb1 then
			local id = "menu_cn_smart_matchmaking"
			local smart_matchmaking_button = self._panel:text({
				name = "smart_matchmaking_button",
				blend_mode = "add",
				layer = 40,
				text = managers.localization:to_upper_text(id, {BTN_Y = managers.localization:btn_macro("menu_toggle_filters")}),
				font_size = tweak_data.menu.pd2_large_font_size,
				font = tweak_data.menu.pd2_large_font,
				color = tweak_data.screen_colors.button_stage_3
			})

			self:make_fine_text(smart_matchmaking_button)
			smart_matchmaking_button:set_right(self._panel:w() - 10)
			smart_matchmaking_button:set_top(10)

			local blur_object = self._panel:bitmap({
				texture = "guis/textures/test_blur_df",
				name = "smart_matchmaking_button_blur",
				render_template = "VertexColorTexturedBlur3D",
				layer = smart_matchmaking_button:layer() - 1
			})

			blur_object:set_shape(smart_matchmaking_button:shape())
		end
		
		local crime_net_text = self._panel:text( { name="crime_net_text", text=managers.localization:text("menu_crimenet"), align="right", vertical="top", h=tweak_data.menu.pd2_small_font_size ,font_size=tweak_data.menu.pd2_large_font_size, font=tweak_data.menu.pd2_large_font, color=tweak_data.screen_colors.text, layer=28 } )
		self:make_fine_text( crime_net_text )
		crime_net_text:set_right( self._panel:w() - 15 )
		crime_net_text:set_top( 15 )
		
		local crime_net_text_bg = self._panel:rect( { blend_mode="add", h=back_button_bg:h(), w = crime_net_text:w() * 2, layer=27, color=tweak_data.screen_colors.button_stage_3, alpha=0.4 } )
		crime_net_text_bg:set_right( crime_net_text:right()+5 )
		crime_net_text_bg:set_top( crime_net_text:top()-5 )

		self._map_size_w = 3640
		self._map_size_h = 1024
		
		self._panel:text( { name = "cyber_text", text = "$./[?_,}3$,7%{=.8;$3%;(-{#]79,9+{4.8,=4,]$/2/!]5!{23%]#.]82669?!&}?578%:9!__7,$=#$/@#,:.*6_#*=#_*.}+_,%#*,;*+(=[[}!8@}[6_%=!:$2562+?49!8)!.9%82{%(!6.([{;.%:8,]}?=8.=,7$646:{&!6$8{}7&{,9?.:([&48#]%,;{&/-7*&?+(!&!6{&2(6:/{8/{#[}[,:/66[948;/{22@_.88-@6;&87&,-7%;#5/}/_&3;9=].))@@**?8+=47@(?5[*#@]]3*@.,},?[88&66&}{_4#;{77#-.{{+]@%8}:7(=+[{_)[_,)+:7-],)}-[%}_?39[!%;(/?&89-!@/5[7%?&!83/.()/_9:2-.9=:!5[%8_;392:(?{:%28(3[;6[9}*65{533){[**382$*[?]{.*{){!=:.*=-#&2@963+{5=@35%,{9=+*%9__{$?5@78)%,7.&{]#8*$$%@#+$!+8_)_2_)@@(_.*/:4/-=(9@+*{$2=8#55?%-!&%#=466{,-[:!{39_58(5{;_:2#?27857(+:,2$)**{/?#2_%#=)!9)@})#:_]6}9?6][_2}!:;%6+(_;,@9**:[]&@*[!)$9!!)995={$:$$69!{@!3+*9%*.2:-{229.]9,:+,8_&7,9;[46-;92--!=&-34$3=3_[[{}:+%(}*%;%3[[23?=/7$8,*%&----&5,!?$-$%$6=8][]&&=.,{[$;=/95#@29[43@:#(7.&8+#_/2[?}98.,3-3*/336==-*!:/38!.$+2%4,286_-{{3)5!}@**/@?};{$@3+[3.{5%{?:-,(:%.$3.=7?)32@+*9?+#[@(,5}&&9?-%7!)4@{}89@)]$(([=![(;4&/(_7!{/$[?$-9_@-:})*]*;:/%{{5-2=+]$@&)9].]8&,(%29&**](.?$!%$2#]]/{%+]-27&7$-;+*?:/$#[{?@;)95$75&%,,5(3[}+:&9#*(,8({@+%!{9*(=$%83*7]=&98=#_+:_([$($%[+@:6),][[-68+=8?@3_}+@@9;/[/?)7*848479:6#2}?7!{=!)2=%4_@958._3.8&!=.({9+},}_66%;,{*(.#$$#+_,/4,!)_!,(,!3&[4=&_[][]*;!**{#=?#]2&]&:79&7935+3&_?=@,!_?28-?..#9)]4!38;_$7=3(=6[:%8:57.:%.9-(_).]2)]){73](&}$&4!{8224${6_&6;?#5&_7##7323!,$5/75&@%8/,$=@7:8/)+$7!(,*[!#6+!&[*]=#52#46,}]?+!/)!?6@,_7=3)5{]2,:.[6+@?+_9(+!+*[.]8-:#($2]:_28+:)&+87:6,3{=?}&8&&_2-;(.&{,/?}7_$73//-7;*@89/;?7$/_8**84=-&7;9[].:)4/{:;5{8)+4){]$_!%;-?}}#@(-(]+3./{=+.-_-;=&247$4]867,]-2:}*48=7652]463%=,?_,&.+*34:)9-%-..,#&/3-96[5$_;)_]_)&7;8_[$[==4;]6]&,_;44.3*4(3]:&:#6,?;-[!?3)###8=9_6:4835[!8![%97;/8,?$22}5[)$9!3&49%*$_@]8_%3!,-2{2%,@243+}#[5}*:[._#6*=&[=7{;!:;}]=[:,!3!778(:2[{3-!}%3-:&)3*:?#?55$&(&)?){7?&,?5/#36;=/.2[=5++#]%(%=23=5.#*%$[@!69.])$$#).@.27);8!*8?)6@3:.&(*:+)}%)5584*]32=)](7*[!@&2@)?!,])@[@+,3*,#:$}$)/377=#@,:@/68#__)=[2.,6/={7+8.@,44@!)&&@}.#6_[3{+_=!+]32#6,%%5)2[4[$%$#7,7!$.3755!7=;?:7?.942{*&%;@&,?_9]_428;*!,}=9$?=;*62(62@{*(;+*66_2@+_)65{)#_4*[]_$4*#46!$2((,.]{}9.}&8{!$,7=%=[9?_!365{_6;-@=.*.97(/8*?=8[4@%+34+5+8&:_&@?}(7;.{)?44:,2]_&3#4}8}.5/$]&$+#9([5,$#87_@/96-#-_}+(_+5()-=272#(3@[5;(6*.*/7:$!79+73=,44//56{=9=+-4_/!*[#/:+%-#33&&{9/5-*8-$%@7:*=!([33-{8343&@.9867/%*+.?2288-]3,?)@-_2;?5)9:8=4))}:$98_*&.}{#44}=/{],6-+3&.&#3+)@&53++}7(=4;9!544$=49$$.@;#278;,$%77);=-#!{=.[-,==*)3&!*86!9}%=+@)({8(.,-52-@&%?.8;2{-5:=(?8!2])#7$!)+3,?({.{2};/6#@=!=!!.$5!;-*4[=(7]?/],*$==?/![[/&7#8)_)7]&@-_4:!=&=5.82#/_#;#/.&6%6/4,?%274@=#}%23@[@+&/2%-7&[53}%8)64])+4{5+*87633([=!];&+.$%[@+/.&[#3[@48%3-$=?[{],{).{@]+?=%!$7-_%%*(-*]6&-]};.$7%(&%$@[}7!@.)@#-)98*;39_$!75};3+._?%@;&@6/46#%(8}6(/=$@?=/*:&-@;-)*/?38!-](8!=&%6=;%7%8,!3[*!__[=56}])#${]/);)&%/5#)/35@?{._87@!/!%#_$7,=98+;@,3&34(/8[&{:#6583/-9.#[[:)2[&-2[29,)6?{2[{8]/6!2!,.5_?@%4{$4;94?5275%]87&@4}{_%_,![}:${(?%_,:3,{!!7}3=={)*7643+-2=5+@4))8#_[.%6:33&+6,6?!5?[:*5+([8](%(*!2&7#8$%+]6#.(,$]36=*896=#;]#}86_,!-&=+]?=5?*8@7$#@49!/#73;6]%@]@=4-!_(%2(8:-:(/=$=@&&_/!39@;6?:5$/*7?!;79-&&26(86(:48}$76$5::96=.?),!9#)#]?!6!;./+%(?;_]?#5#([?59,*3269[-@3$9&66=$)!/{!=#?+_597@}276#[5{{5}!%5}@{-*#4?}/;2;2()+/!?_2=#$/;/#;?8[#]8:.#;&${@#(%/*&+&/=/&!82#=,@!!]7656%+/@*2+29+{7389}{,:2*22_{(-3&[:79=+658_,?,&.;-)_,2/!#+@&:({9,)9%&$;5=3*;3);[[5}634#4_$75@{]!]/,549%5:;3+7$8/-8[&8?[[}68{&6++=)%.&}8#2_7!+-?&#}#8(6?{3//}58!?{=579[}@(3$7[+)_7596!_[-$47]7]#)?-$]#*{*,#*!63]--}3]{576,43{$#47[;.8%7:9[)%3*=6{}%!+,*/%3%.-+.&,[[@{%[;#:=/.;3;(@!%3-?_-?5=6?6+[5#&{!&}&:5$=3{;;3]*#{3*9&=3}5?/*%288#2@&@@!$.#!37=%]@/7/]!),+*65;6;$?*9)!4(=8/{++-5&;*:[52{]-)/{*#28{_6=47;@@[]5%4($&;5,9,49[+565#&(6{?35!5=]#_=-#-7@(_2/=7383(3;&:%?{6;,[&[+[]5+@-_,_*{!.:8._$=}3;$+#!_+%%3+$$:9&,.#855}#55:-]&!]$$)4&-+(%_]:}{[_/8}+@25_*,!.;/?+9@/_6(:7(3)][.(%.4[#-4[-56}:;&?%/2]=}9};-!-5?5]./(67:%_-!2*2)8:7?.}+:487&%?=*!}[4(2::7#?+)-$,8*!%.]=}7}}4_):{7!=:!:_9*=](*]#.,}{!29_;5?[*3{(*6!]@#{4/3%3,?)-;+%(){(_.{7{;3=($),(7?;6-))_%=*96?#:_(_95](+_4$-4%/:&{?%2?6$8,+&)...:83*}5]%=]_4={.{4)@:5(7@4++;.[/@]!3.-282:7,[+{][8&.(#{77)?5!6!77-_6?[/?{};}//:7%#,_/./_93&9238=8-{_-37!_}$_%}/&:*{&(74:6,[?]-38,:,]([*#46]}__7?-*43-}@)[@9787:53*!}-}*7${=;[5,4&$6**57496(.7)+66$?.!2244$[;{@$%5./+[-,)}*33#$=?[+))_$:6;5:6)]/!3?*%[{@*[3.!2;]3/)/35_(!22-4)*8$(??$[&$3}.*[(/.-4/}[4}.]+6]4628=6{/5[)22;]36.6[(;#(}:-.!;$/]_}*_459*4!$&[2,,((4:(-&]7#9(}7@8}/[*$[@%3;*-84)%&/&}&+5![6555,-;6%+,_.{[[-&{{5+9;7$,}_&@8}.==[2}$@2}!$=%5#(=)!#7_9)$.78=$+#45;&*+?{?&:2}6*+5$7-}:83.*{{}?_:{5[??=4%8%$}%?*=$?93#7!{._{!+;5(.$7+5,*#!%}#7.4)]29:&}*];@${-?[#?9[4))]&@277/6;[[;@2];,!).[!/&#/7)3&9.&?/$@&9[,;/;#+2#,32]__;[?:{},2/)3$.2@()/?664}69]4632?}8.{)?7={-%+)+/]=;)-+55643{[*??]!!$.},=[+];$84[9$4+_4&2_&_/#$)(}8%+{*&%//2.@3$(((@6[44*3.,{?]-{947)]]8_@!()9]+:,;52864{7?)@$=2}-4-{8*)@%8;52;(*5.+=9}&34+&427.:[4$524:=;.7-5#{}27-[.[::(*5#-9832;}!)*}]&!%!&.{(8]8).(=]$&-}.{4%29?_4!(=)385!&#-7]!7=}[@]%=_3:73-#$:?=$.+/}#,3{/}694{${?;,)5)]{,,5+?$$22&$!4!/.[).+5}%[@]@_(==]*)$/5(2&#6)-)7@!=&!6?5]}(65[.4@9_#?4?#/_3!!]67{4.=4._!=%3&?5(.)}!%4;/553(3([#,-#{{[5*#,3.*;--(.8*+.79.,:{!#=_[*8}=/6{-{2:},&{55*&]5*9%=$&5%+)_[$6}5[[6;+@@=+;{]/&55%=%/,/[=%9+79.*}-=4$*5]+])=46#_$@){%&642@#+::4&(+(-7.]7(.//{/@*:[%/:-92(869]*{)354@[!($--%{_,[57!,8+$@:#@%;;-.%(,=&:+4={5&!}_@}6@.-+}2_799:;+5}=+-!=#!=_/-@5722$5@$5)!295[)-&2=%]]-=27}*{87%=;-=9@+]_8=8::_/!;*&)$68%]?)%[36/2+},*]9(}?=,[.@}{2$#/6]-6!@];8(#)(*}@%22,*)57[:57/9}+?&@9%!,)$/$-:{46[*$8(76=64.{-?5&_@/?@$!&,%?@}2]..,534{84+@+[3:{_3+.[72&:(+:8)&[:=%9)_&+)#,{8!7/_6,-3!*?[3%&49397{[2@@%.#&];5/:4]#,8?28([3*$;[],#((#[*@+;_?7{,-+=--?&]5)3[*2+;;}6!;.=$=_@;58][2/49753-[*!.@9@/,&@/$*44+4},]}(.9=%]#)}]$!27&$/:]{(%:{-8%./-{3(86?{&/{_*_.*_4!*4.+..,4*@7{}2#$?@?)_+(8(6}6;*&&/38)4=;}[#;*,7.$:&@-&@$4%9=*{%?_4]8@7)-[%!*;%?%{}:):5;5,*4,]%@9]#8..-:4;##(6#/=67@.${68(/:_*{&8+%/,%*]5[4;=5{$;/-52??:])5:,7-{@6@5]43==+96$))6/2&*8-8]]9;{_8:_{[%_9_-/!)8-;]626}*[}@?&4({=-_!:99#4*-$6,,.@}:&*_72[$)&3}5::${*8]7(9}]*4%2).54]:}3&_%)+.25-+%@_,2#[{-$;8:{]=(+,:9@+3]##7+5)%(5833}#:{{$5+{74[[-8%#5!}&/6$3{.&;()/],[$]?3?(6(7*.8:#(@/4.)&@_7+*&;:#36.](${;95]&%%]$2-}2984]}]77*3,$:8*43;*&.[.}6%8+76/{!{.+_8@}?{/$+.6+(%;/&-:&6;_35}$7;*4_*2[?+@56.:!9;/,!:5)[((%&3*96!,,5_)?!}3*&4$8,?#/;=$8[4{;=,8.4#$$:4*/32#!*)2:8#!-$/%]}4/+_]9:24_}&5!+&&@4$&:;48?,&/];,&7]8]62:.;(;3+_;@-]/95;-;34:_!6=4!,346)@%%[[6:!//_(&2@29}=.8@)])%=2.#,#$..$*8%5$;333?!!!6}![%(#*.$%;},67@#_/$*)&]!{#57$%.+{:?_.*;]%,#@}]!{#-4+=_:}!_27!9,;+_52%7}9,=4]5$&?*,,.(@2:24?}8)99(_4%)5.@=)=&[]%-;:,4&-64[!(8685;}9$*%}@,{7]@9+.?]#]%(3!]=5657;)7$-+!,3-2?+*37*9_*,($$7,&8%22,,]#[*$?{&(-(+.8+@8$)4_.?()7[*_.?-6%:&84,?,=4*/&$=6]{.=%{@[_7_]/42!_.63+,*7{-/[=#82..)}@7]]?$56!88._{@@=;@%@_!@4-]8&]+(;+=7-$_/{=2!49/-!{-+{*].,!(6@!))7}+@#-&(79/#,4_?&(!8}&7:.(-#78-/?!&=-59*2(}6_(:!%/8644;&[$/-64#34].=2$#9?$$]-6:-#.4?[([.[8&26-,,7%_+64&9+]7#%*+#@9*)$+:_/=9]&,_5]79=#+]_5]-$=#+{)_2;%//_;9(4-64;.&=-)3$_}8_9/.5!9[]9]@256++36293!&_:3{&{{,2}622-!](]53.{}6=9]{@]_9=&*$-}?@&8*{*-{;59;*$}/!5[#/+/=29+%2:(58)?@4{,-6&6}=%6(935,#@:_({)*4=9{.&?)6%.!!.@5!#97_{+:5:-=@827?..27)[&/,[![7[@{);24?#2={;4:=2(:@.[*&}3;]-_78/@6[9/24-,&}(}43)/?:#%4[(3%!6$;$=78*8{%(]#!+8;*#4-98726598(_+54-[}{5@(/9*/3$[($3(.-95/&#.&+[=4!(8;+&:],:/43=6?:]&-[&!3/;+]6:)=-@4/9)4)]#3##+#(,{-3#@9.+{+-{_8#/$)@#*9@,*,.!,{%.{{?[2)*9/%.@9,6%%$;=*#73=!9/[**](8!#_::!!:/8%*84]$3{59?4]5{-@[@-8;[9}2+@}{=;=.]!?}2*{(-7-)[.!?7_92},749?[][.+.3+[%+_97=-9)+2(9]]*{.!2*8{_}*$_6@[78}#%:87]9).,}_[}_#7.+;-.!+/7[++-9(,}:]#{6&-[:,&4{/.%$%&{]4}$#47{9{{6=*39}/53/:({6:(@5,@75}8$/*_9*!7;(){3}27==]-$$?},]*@$&?)}{.[&.7}?&62#/@_[8(*6..;46@$;%$&[_),3+;8@7*._;7}$:2:}-.-&:=.?3*=:(*?@##6(=%[}=(+&:[}6}*.&$-?/[4*/_-4))!22,#.&792;$5,3%?@&:__5?+=4.5@9{4$++*/4]4!}+7::@78/++@,5:4*7]7],[[:7+26(4#([{.[/65*97)*:@5?_3}(?,[3/5[(&22%.6[_}$%;[$5$)6-$%)+_?!!_;*63/@295}335=-?_9;5*,,9}(#+62)448]9.($_6.!-?7+-]2[{([2@;=&][9(+[%!@@!@*:*/-%-$4&3&&)4%5$=,)[%$(@466{2.@$=?73?_=[622)3%-!]6#?:[?,+4/:*3-9;35=-,8=35@{)#-)-4-*5#5;@73;978:/=]!3[/$$27&)_5:$..8[49]/3/;$),;@[524?5)*-4$+9972+.29)*83-%?&/}&)){#4@}6/{]@)#==72_$5+_[@[_]@/-,_],){_]]&@=&/;2-:(@:;92-[5#%@_[=_8.!#=@7(@[%+)/64#[7$#(6*!@5=[$!+)/_23$%@;$4!(,(#7,,5_6_+[*(&];(_3%68$9#%;99[=@#/-{*@+(7))2&&$@3,(9#**7&+[?*4@$&/8*6%3.&2$;-5_}++:/&[!_/):{7---[3@6{(,;(2%!,24}+$[92#=$/29,}7.)@;$(3)$;&54%8}4]8=={/24=&9+-?.:3*%[,!(8[@7-3:3?[,;#.934[9#=6]3?@((-;6#{:3;)&?@5(97]//}]]]]424.$8+*+-)[+@_})}3__*!(;%#3(#}!@:%&+/84#_=)5[)*_){&?9,5&}@+8--[9&@/7[534#(-)2-?;,%6{4,25=![7,$]+75_,?[/{:;#2/8+3{@38]=86[$.9@*9:8!;8385$32;87-)%&+(;#!*-_+_2=2;-?/%-,@=?4($.6@;3-#%=5;{]}!7}(];_&.@,6,%#/(?-4=(?@378::;,9{7+]=43,,8@=}5(!)=5(!$]/$[],{2+&4&#85.8?{#@*.)-9:#48[(+8[$_{](,*]8-@!@%%?2=62={?&5!=]6$5;[?_=#&5!62=*(+*]66-@*@]9(@+!=8#-[6@8-!;*_-=_;7,_-[2*=]}[:}3-:&]5)+@$.7}%$8,29?_259#55&-@-[_78_:6}$+=!%=#?*:([@22@$*%4#96*3{?___!($+777##[7/#}}=9@-=_$-{(@!:7&6%;;,{5(}*5*3},(92#],$2+&5/&)(*:[,]+2?&383$[38],877%?[$3)[$_*8--_$;:-](434=.?2(}*?{{695!7=6$8(67@+8:#+;.)$:8[#]?6+(-:9:,@#{..}6=?+6+:+9-;=#{$9@)./3%2[[2+{?-.69_{#@9?%58$@5;:.@;,%-$@_]$93{[,2-)6}4@%:+=)+#35!4[:/+)49]-#4,;?496))[5:=[&79@?87[}!*38@+:*;.$-9!3#,679/}6{&4-}&}7-:)[$(_=(6[;24*,%+4?;3-*-?%?889!/:;%.(&!*&/@#6./7624-342(]3_]*_:..{$42-2}9875]?$(]53-6(9-.)+){!&;-6!2(&7+/*&;55]:=:[$?5=@@=*-&;$6{57?[(:@]@5:%:=6;9)_+/{;&&/}!_5(68:)/=)]9!4}}{&,+[7@}#5!/2?*]37-{2#}/&!8:9-2$2??5)2*{(=.]9_898$+?%?(+5]/#8?{6{5+-?;)3$;/{?6@_{8!&[?95!%#_%}6%(/}[$*.((5.-?%,*}(}}9{-&{7%4=+2/5=(7]{8;77$(2[9_92:(&/.=&3{#7*}$5)![4;9_{39@]2(,)74#:#+:!)#!{)=7!}[/5}*-)2$9$5{.,6:4_*[&{@%4##!3&6##2?._6?)%})*){#-&.=4.@)){.=?!)44{(/[)578?.,{(7_)7[;[8!-!}*});]{=/_@?=%&%8?7,4&#.?@98#-!]_4#];,/7]?,}/:29%*;4}@#%!){3$/9;)8$(=.9./%:/&_!45;)%5$[[?3%).4:/7{*$7)?]}/7$@/9-65?5&],+;_[&3_%/:.[!@3$8@&$9([)@99(;/{7}57_46.7@.@&().!596)*:/(75(;:?6@%.{6@6;{]6&&_797-%[[{2[(:!/]3=](*&*+?62,-!--93+@;!=+=.9$]=3%::!-$!7[[{=&/6+,;=@6.#};7&6($8[23.]_5[+3#)(6$8@?+*[]$2:}./5,%/.;4%3532!4**#!9&./;.,!9+:67/62%8@,32!,*]74?+$&:447)!%%?8[4;[9%943:_[6!@!&5{}9)_-6*%+3947[*&:)95&_:3#+}!&?[=9::((#_-[=+]{2])}8?.6:&&78.=47$[7&5+4+&=&8.!8*+$-++4-[.9}$(@3-([68}[[42}+75!)23:)5@(%{2+5?$&[[&@*[=-!%=]$-97&32_*..=:5]/6&!&-(,.8*-%@?**+;!_9[[2=*)#,]$%3+})*57/$#*6-,;$/2?+9&.%45)5.&)2-6}!?..@5(;7.:+2*{:*{5_;@+._].(3*@#4//[5!,(;[&{$.$$%#==8[$98?7(-!4,6]53_#,76+#2(?85-(#!$])6:-32%76$6%[%!@&8_)$-/9]&?]*(9%}52;$$&8-;:&!*,&%#*+4*);-$+3?2!9[9*2]56}?6[={@%?8/$4}@$-335$_;[)];[%=5_/6+]8)@?2_:5[$2**]9*3$&947.}5-}#,}/@%27(58!3##)(_[8[6!%*/,%93,_?.(7&67/-:@/;&@3()=]65,5@(]#;4/{]={?56[()+[.&;.9,!4,*{._4}8-!7.75__!(]2{55)5$6*]26[86/(:{=5}%[_79#$=8[{@8]3:#2*3?53$8}6-(-+5.3[2_.:}*.)#-=@8!24({97$)7{37:.#/)%5+596./8{![+%_#%#&25-(=2#/(3{8?8:;/@-4_#!{&;$2;#,8}$&[#&[22@}_$*{4&,737)@}%2_68[;$=:@/_(4@_$(%)8##3*3=95:=)=/55({]9}947)[3)(@}(*2/._7+_8)/+&46%]/*-[&2?./5+[,@{:36+];27*:?2;(8_(3,(:8_$,}7!%@/,#33/[#{#]--(*2{!@(/@96[*8+79={94:&8}9=!-+2$9{-}{94_{;=!6_[9$:6+*42#&(!76{:.}9})4[[!)9&#45$?7$=2=?*!];@({49-#%((/{{49+8(,;/2*&=56]&2!=}586{873@-28_!83[)8[/7?]8;4&##![-9%[5)%;,8&]@942/{*=*)8;{:-=68[63}=[+)6-:,78+[&_92#4{9*9{2&(&}};=]+;;;.:*!9&2]72&=(),[=2,*[]9-]%.%*-_+93:){5%?=(@!;,)84/#}{4#.{,9/&@5+::.;:4$3&7@3%?]?853*%!@[(]@;:(-,,9=%6;.5[%&=;?3,%/]%$68_(#&9;,*%#7}:)*&]:]9@8-3[/2%#};].-!(_)3]7%%#;@($&;[+6+2(,%.#,;=4_*]-%-[78$!!3.8?/-#$=2*3+/%88=6#*;_4(-676},&2,4_]&8_-@];2&=9_(%[:*_-}/.(2_$.#9+-(?%4!)]/?!6{2};][%%(/8774{([;]_9@=:8%5/98_$=:&],3&%4@{*;}}:;!;[6@).3)/{!;$?#:_.9:-;$-=#877/@)%2/;*:9+6-_!*%2&4[%)_*_@{}6434.$$&_;*73]7[@[!:_):*2]!&(]+679(,@%&[%+.}@#3#=]8;($8[=&(]}.)4_.+88(2#$}%$95_=+(;}-!#:!(-@_?_5,[{}=2_%}.@?!,4!*[/[@#__&{{!#/&+*&(;{*8:=6$;(,3,$[4/.;;_*!?$[%@7$&7-!3_5@+;-6,+&3:8@-[$#=,66-44).2(45:].{@!*{(68]9#$;,],8$+5[3#+4};6{6.?/,5%=+2=$44--/}7//.5$![$##:-:78[}.#&}%%*@{;96[5@!*}%5)=68?}_;9%.3+[--4$/6/7%)4*{=-?/3;52+97@/2/9:).(*#)+%[=:/5}!77/2=()92,{9-@#@8-4[.?,(}=])&;9;)@53}98};4,849?:&}&/.9*%2[;8:$)_](:*@)!2&-{?{;!33:+5&;/?[-7/=@{5884@;+,!#)37{[?}}#6?%[62=?!,58*6-?;;?,[;@49%+43#485][$:;&},?383=_?54?%-?/7__-9!?*{5($+!5]{76*=_3#/%&;7};,6,+)2]58}=?$?!}2(:!:644:!}5_/;])=$_3%[{?7!5!:=5$4#5/;[2,7745;44$),8493.[:57),[&94/$63?_=?&](3:6:-]:4$)/2(#3%[.8!==3_!;,-#2@[/._!874)64%9$?3!{?5.2!63&4+27@2:3(7+62,(-?!6-6=({::=3&%5:=536[-8}!98=79/:.)}@7?$2_;926&*(#![};{9!27]55%}8.@=,?/9@3/=+%&:]{).!;7%$,,@4}42+8(:5(/-562%-5&$576%*._]2[:}(9%8[.=6),$${*.9;45[+{+;$:;-{2(@):-=39$}((+/;[2?#[#_#84*=@2-$)?&}:.786;4}#//%=&$+29}[%:#}?7-!}&=+]&6{*+)?+3!(;+!3[*;?.{/?+%_=[=7{((,$&]487#+%.=_;483]](&!/{65[*83,)%#43*-7&7%}]9@=%69;+58?{$*59-28-?7)$64_:[4?&9:49+_3#!:#$?{{9,73.!6./+}/(]3;/$_/3568-][3,*{4]};$[=]}8$;92-3#))!{4}56[7{!]-3_2]*}4?-(,*9(){/2*4-:&][%--)+:4_#&.#;/8546.(/2+#8(/:#{:=.(+59::?.=!4::9%=4_2/@#_=//.&95=/544@6=9?-+?*(%:6$[{]}/3)&;3+?)8}?$(9.@.)$:4?63?_75#[.87:__@{9_-!}:8:=?8/7!?453_%5%*#[[;9-(&3,86!(@:__24(%84.;._6$:,2:),.)[[%326_?@#%9&[;8&!_$?[*5)6?$&!,*6_;-$%_/$6@,*}%3];&[,(;43;:&(7-&-6_!*#@65&$}@6//!/)&{3?2(6%243@=@/4+3.?3#527;@5!.]94$]//4,_,,??*$+7=:$}9*}6;7..+7}),;{+79;;*(?#-{%6}$(!}&.8![+:*(%&*#*6?4&@2.,3;%?/?$*7?[-6$7-2{$-+95@7+%]{467,=,%=3#[%=%:8%?#99*,(=,%;]@.4)9/*(.:,-)7;)-,@,-[4=%!=+2,55?%[4-$(+8,84*%6%}.}_@#}:6)6!_%6-[#-:-48]2{?#![.78-6.*#44_[#:*@6#+,:(2+_.*&{4)]_,#!57}}2}=9%]},973[;%&![42]]+;;4.(%}?_5:*?/*_,5/9=[:$:@](@}[423%#=3!9485:[=({+-,+95-_2[.:#88#:(6;3?285$45[8/).=+9_7,);/%&})2#:+9+(!7:4]5*$352@}*?=/*=?{](,73%{={!3%.-/{(7)#88!7}.-29.9;[_!==864*,&/,@}=!+)_#]}4}8_@%-;.&_2;/3895@5,{2]/@+{@[/},+@#8.=-#-*%_442}::-[#]+5)=5-+$}699&+&:/*7{[@$.68-{{;64=7[?,-%**7-)5!464[?.[:?{4*$6[89}{!-$)7?)#.((5@943=(];@69]95#25%{8_)9.[287]6?:)]4_).([!!6$(52-+=2$].6;_.%};,*_--5?.{=33*/]7?&_%}6@2-[+3$4%)7.#65{.]]){@/7]5&4[/{)9.!=62+529(,?[]9,}9_6(#/=)?62+@!]$+5;5_*9}=]]/..{(4),!6[5_.]?#)48.{98%3;3)].$.@]/*88(:];34%75{]/@(/:](]9%#&7@$-7#9-}#=$$(8+_/5;,/$&+6/3_-&2*+-$%-!3$=)]}#(3#*:_+$%%.@3)+}};];&&8):58$:.!//;=)7@5$69%9*./6;{.%+_9$])?4?.?-);7(}[-6;;%+:4!2,{}/:)8;&#!][(,8396$&89:-(7(!#5&(,-,%$},_-!:{5*;;8@=]63;#/5&6*[8_/,[,_,=%+]?.85$]9+?77)%=)8_9}7+]/%:8-,-%74=)596-@4$!:2=(,}[/3.98]={}=.%_(@.=79}=:@48*-9*$*9$5/-4[%]*)#%&(.28{+6@3.);#9#9?}$:+65(7@#{$::2}8_;@:##458:&=7_].${]!@5]_]+/$??$!+99{_;=)=/]#92#276}9:}6*46[.*/%:2#4-56)#%=279:!3{%*876?8,,.,*-{[%=42%*#?6]9_]%+$--_2/=&4,}467!+)=3)#;+(92:7/#.$37-!8}!*9](([67,(::9;%/22}.$--",
								wrap = true, x = -3, y = -3, font = tweak_data.menu.eroded_font, font_size = 24, kern = -1, 
								color = _G.colors.half_opaque[_G.u2_core.settings.crimenet_visuals.crimenet_matrix_color - 1], 
								layer = 1, visible = _G.u2_core.settings.crimenet_visuals.crimenet_matrix_color ~= 1, w = 2400, h = 680 } )
								
		local _,_,_,h = self._panel:child( "cyber_text" ):text_rect()
		self._panel:child( "cyber_text" ):set_h( h )
		
		--[[self._panel:text( { name = "text_indicator1", text = "LT: 100.566", x = 0, y = 0, align="left", halign="left", vertical="top", hvertical="top",
								font = tweak_data.menu.small_font, font_size = 14, kern = -1, layer = 1, visible = true, color = Color.white:with_alpha( 0.5 ) } )
		self._panel:text( { name = "text_indicator2", text = "LT: 100.566", x = 0, y = 0, align="right", halign="right", vertical="top", hvertical="top",
								font = tweak_data.menu.small_font, font_size = 14, kern = -1, layer = 1, visible = true, color = Color.white:with_alpha( 0.5 ) } )]]
		
		self._panel:bitmap( { name="cross_indicator1", texture = "guis/textures/crimenet_map_biggrid", texture_rect = { 0, 0, 16, 16 }, w = 16, h = 16, blend_mode="normal", layer = 5, color = Color( 1, 1, 1, 1 ) } )
		self._panel:bitmap( { name="cross_indicator2", texture = "guis/textures/crimenet_map_biggrid", texture_rect = { 0, 0, 16, 16 }, w = 16, h = 16, blend_mode="normal", layer = 5, color = Color( 1, 1, 1, 1 ), rotation = 90 } )
		self._panel:bitmap( { name="cross_indicator3", texture = "guis/textures/crimenet_map_biggrid", texture_rect = { 0, 0, 16, 16 }, w = 16, h = 16, blend_mode="normal", layer = 5, color = Color( 1, 1, 1, 1 ), rotation = 180 } )
		self._panel:bitmap( { name="cross_indicator4", texture = "guis/textures/crimenet_map_biggrid", texture_rect = { 0, 0, 16, 16 }, w = 16, h = 16, blend_mode="normal", layer = 5, color = Color( 1, 1, 1, 1 ), rotation = 270 } )
		
		self._panel:rect( { name="v_rect", color = Color.white:with_alpha( 0.05 ), w = 100, h = self._panel:h() - 16, x = 0, y = 8, layer = 5 } ):hide()
		self._panel:rect( { name="v_indicator2", color = Color.white:with_alpha( 0.5 ), w = 100, h = 2, x = 0, y = 8, layer = 5 } ):hide()
		self._panel:rect( { name="v_indicator", color = Color.white:with_alpha( 0.5 ), w = 100, h = 2, x = 0, y = self._panel:h() - 2 - 8, layer = 5 } ):hide()
		self._panel:rect( { name="h_rect", color = Color.white:with_alpha( 0.05 ), w = self._panel:w() - 16, h = 100, x = 8, y = 0, layer = 5 } ):hide()
		self._panel:rect( { name="h_indicator2", color = Color.white:with_alpha( 0.5 ), w = 2, h = 100, x = 8, y = 0, layer = 5 } ):hide()
		self._panel:rect( { name="h_indicator", color = Color.white:with_alpha( 0.5 ), w = 2, h = 100, x = self._panel:w() - 2 - 8, y = 0, layer = 5 } ):hide()
		
		-- self._panel:rect( { color = Color.red, w = 5, h = 5, x = self._panel:w()/2, y = self._panel:h()/2, layer = 10 } )

		local aspect = 1.7777777777777777
		local sw = math.min(self._map_size_w, self._map_size_h * aspect)
		local sh = math.min(self._map_size_h, self._map_size_w / aspect)
		local dw = self._map_size_w / sw
		local dh = self._map_size_h / sh
		self._map_size_w = dw * 1280
		self._map_size_h = dh * 720
		local pw = self._map_size_w
		local ph = self._map_size_h
		self._pan_panel_border = 2.7777777777777777
		self._pan_panel_job_border_x = full_16_9.convert_x + self._pan_panel_border * 2
		self._pan_panel_job_border_y = full_16_9.convert_y + self._pan_panel_border * 2
		self._pan_panel = self._panel:panel({
			name = "pan",
			layer = 0,
			w = pw,
			h = ph
		})

		self._pan_panel:set_center(self._fullscreen_panel:w() / 2, self._fullscreen_panel:h() / 2)

		self._jobs = {}
		self._deleting_jobs = {}
		self._map_panel = self._fullscreen_panel:panel({
			name = "map",
			w = pw,
			h = ph
		})

		self._map_panel:bitmap({
			texture = "guis/textures/crimenet_map",
			name = "map",
			color = Color( 171 / 255, 181 / 255, 130 / 255 ),
			layer = 0,
			w = pw,
			h = ph
		})
		self._map_panel:child("map"):set_halign("scale")
		self._map_panel:child("map"):set_valign("scale")
		self._map_panel:set_shape(self._pan_panel:shape())

		self._map_x, self._map_y = self._map_panel:position()

		if not managers.menu:is_pc_controller() then
			managers.mouse_pointer:confine_mouse_pointer(self._panel)
			managers.menu:active_menu().input:activate_controller_mouse()
			managers.mouse_pointer:set_mouse_world_position(managers.gui_data:safe_to_full(self._panel:world_center()))
		end

		self.MIN_ZOOM = 1
		self.MAX_ZOOM = 9
		self._zoom = 1
		local cross_indicator_h1 = self._fullscreen_panel:bitmap({
			texture = "guis/textures/pd2/skilltree/dottedline",
			name = "cross_indicator_h1",
			h = 2,
			alpha = 0.1,
			wrap_mode = "wrap",
			blend_mode = "add",
			layer = 17,
			w = self._fullscreen_panel:w(),
			color = tweak_data.screen_colors.crimenet_lines
		})
		local cross_indicator_h2 = self._fullscreen_panel:bitmap({
			texture = "guis/textures/pd2/skilltree/dottedline",
			name = "cross_indicator_h2",
			h = 2,
			alpha = 0.1,
			wrap_mode = "wrap",
			blend_mode = "add",
			layer = 17,
			w = self._fullscreen_panel:w(),
			color = tweak_data.screen_colors.crimenet_lines
		})
		local cross_indicator_v1 = self._fullscreen_panel:bitmap({
			texture = "guis/textures/pd2/skilltree/dottedline",
			name = "cross_indicator_v1",
			w = 2,
			alpha = 0.1,
			wrap_mode = "wrap",
			blend_mode = "add",
			layer = 17,
			h = self._fullscreen_panel:h(),
			color = tweak_data.screen_colors.crimenet_lines
		})
		local cross_indicator_v2 = self._fullscreen_panel:bitmap({
			texture = "guis/textures/pd2/skilltree/dottedline",
			name = "cross_indicator_v2",
			w = 2,
			alpha = 0.1,
			wrap_mode = "wrap",
			blend_mode = "add",
			layer = 17,
			h = self._fullscreen_panel:h(),
			color = tweak_data.screen_colors.crimenet_lines
		})
		local line_indicator_h1 = self._fullscreen_panel:rect({
			blend_mode = "add",
			name = "line_indicator_h1",
			h = 2,
			w = 0,
			alpha = 0.1,
			layer = 17,
			color = tweak_data.screen_colors.crimenet_lines
		})
		local line_indicator_h2 = self._fullscreen_panel:rect({
			blend_mode = "add",
			name = "line_indicator_h2",
			h = 2,
			w = 0,
			alpha = 0.1,
			layer = 17,
			color = tweak_data.screen_colors.crimenet_lines
		})
		local line_indicator_v1 = self._fullscreen_panel:rect({
			blend_mode = "add",
			name = "line_indicator_v1",
			h = 0,
			w = 2,
			alpha = 0.1,
			layer = 17,
			color = tweak_data.screen_colors.crimenet_lines
		})
		local line_indicator_v2 = self._fullscreen_panel:rect({
			blend_mode = "add",
			name = "line_indicator_v2",
			h = 0,
			w = 2,
			alpha = 0.1,
			layer = 17,
			color = tweak_data.screen_colors.crimenet_lines
		})
		local fw = self._fullscreen_panel:w()
		local fh = self._fullscreen_panel:h()

		cross_indicator_h1:set_texture_coordinates(Vector3(0, 0, 0), Vector3(fw, 0, 0), Vector3(0, 2, 0), Vector3(fw, 2, 0))
		cross_indicator_h2:set_texture_coordinates(Vector3(0, 0, 0), Vector3(fw, 0, 0), Vector3(0, 2, 0), Vector3(fw, 2, 0))
		cross_indicator_v1:set_texture_coordinates(Vector3(0, 2, 0), Vector3(0, 0, 0), Vector3(fh, 2, 0), Vector3(fh, 0, 0))
		cross_indicator_v2:set_texture_coordinates(Vector3(0, 2, 0), Vector3(0, 0, 0), Vector3(fh, 2, 0), Vector3(fh, 0, 0))
		self:_create_locations()

		self._num_layer_jobs = 0
		local player_level = managers.experience:current_level()
		local positions_tweak_data = tweak_data.gui.crime_net.map_start_positions
		local start_position

		for _, position in ipairs(positions_tweak_data) do
			if player_level <= position.max_level then
				start_position = position

				break
			end
		end

		if start_position then
			self:_goto_map_position(start_position.x, start_position.y)
		end

		self._special_contracts_id = {}
	end

	function CrimeNetGui:_create_polylines()
		local regions = tweak_data.gui.crime_net.regions
		
		if alive( self._region_panel ) then
			self._map_panel:remove( self._region_panel )
			self._region_panel = nil
		end
		self._region_panel = self._map_panel:panel( { halign="scale", valign="scale" } )
		self._region_locations = {}
		
		local xs
		local ys
		
		local num
		local vectors
		
		local my_polyline
		local tw = math.max( self._map_panel:child("map"):texture_width(), 1 )
		local th = math.max( self._map_panel:child("map"):texture_height(), 1 )
		
		local region_text_data
		local region_text
		local x, y
		for _, region in ipairs( regions ) do
			xs = region[1]
			ys = region[2]
			num = math.min( #xs, #ys )
			
			
			--[[vectors = {}
			my_polyline = self._region_panel:polyline( { line_width=2, alpha=0.6, layer=1, closed=region.closed, blend_mode="add", halign="scale", valign="scale", color=tweak_data.screen_colors.crimenet_lines } )
			for i=1, num do
				table.insert( vectors, Vector3( (xs[i]) / tw * self._map_size_w * self._zoom, (ys[i]) / th * self._map_size_h * self._zoom, 0 ) )
			end
			my_polyline:set_points( vectors )
			
			vectors = {}
			my_polyline = self._region_panel:polyline( { line_width=5, alpha=0.2, layer=1, closed=region.closed, blend_mode="add", halign="scale", valign="scale", color=tweak_data.screen_colors.crimenet_lines } )
			for i=1, num do
				table.insert( vectors, Vector3( (xs[i]) / tw * self._map_size_w * self._zoom, (ys[i]) / th * self._map_size_h * self._zoom, 0 ) )
			end
			my_polyline:set_points( vectors )]]
			
			
			region_text_data = region.text
			if region_text_data then
				x = region_text_data.x / tw * self._map_size_w * self._zoom
				y = region_text_data.y / th * self._map_size_h * self._zoom
				
				if region_text_data.title_id then
					region_text = self._region_panel:text( { font = tweak_data.menu.pd2_large_font, font_size = tweak_data.menu.pd2_large_font_size, text = managers.localization:to_upper_text(region_text_data.title_id), layer = 1, alpha = 0.6, blend_mode = "add", halign = "scale", valign = "scale", rotation=0 } )
					local _, _, w, h = region_text:text_rect()
					region_text:set_size( w, h )
					region_text:set_center( x, y )
					table.insert( self._region_locations, { object=region_text, size=region_text:font_size() } )
				end
				
				if region_text_data.sub_id then
					region_text = self._region_panel:text( { font = tweak_data.menu.pd2_small_font, font_size = tweak_data.menu.pd2_small_font_size, text = managers.localization:to_upper_text(region_text_data.sub_id), align = "center", vertical = "center", layer = 1, alpha = 0.6, blend_mode = "add", halign = "scale", valign = "scale", rotation=0 } )
					local _, _, w, h = region_text:text_rect()
					region_text:set_size( w, h )
					
					if region_text_data.title_id then
						region_text:set_position( self._region_locations[ #self._region_locations ].object:left(), self._region_locations[ #self._region_locations ].object:bottom() - 5 )
					else
						region_text:set_center( x, y )
					end
					
					table.insert( self._region_locations, { object=region_text, size=region_text:font_size() } )
				end
			end
		end
		
		if Application:production_build() and tweak_data.gui.crime_net.debug_options.regions then
			for _, data in ipairs( tweak_data.gui.crime_net.locations ) do
				local location = data[1]
				if location and location.dots then
					for _, dot in ipairs( location.dots ) do
						self._region_panel:rect( { w=1, h=1, color=Color.red, x=dot[1] / tw * self._map_size_w * self._zoom, y=dot[2] / th * self._map_size_h * self._zoom, halign="scale", valign="scale", layer=1000 } )
					end
				end
			end
		end
		
		--[[
		if Application:production_build() and tweak_data.gui.crime_net.debug_options.regions then
			regions = tweak_data.gui.crime_net.locations
			for _, region_data in ipairs( regions ) do
				local region = region_data[1]
				xs = region[1]
				ys = region[2]
				num = math.min( #xs, #ys )
				
				vectors = {}
				my_polyline = self._region_panel:polyline( { line_width=2, alpha=0.5, layer=2, closed=true, blend_mode="add", halign="scale", valign="scale", color=Color.red } )
				for i=1, num do
					table.insert( vectors, Vector3( xs[i] / tw * self._map_size_w * self._zoom, ys[i] / th * self._map_size_h * self._zoom, 0 ) )
				end
				my_polyline:set_points( vectors )
			end
		end]]
	end

	function CrimeNetGui:_create_locations()

		self._locations = deep_clone( self._tweak_data.locations ) or {}
		local newDots = {}
		local xx,yy = 12,10
		for i=1,xx do -- 224~1666 1442
			for j=1,yy do -- 165~945 780
				--local newX = 150+ 1642*i/xx
				--local newY = 150+ 680*(i % 2 == 0 and j or j - 0.5)/yy
				local newX = 180+ 1642*i/xx
				local newY = 180+ 680*(i % 2 == 0 and j or j - 0.5)/yy
				if  (i >= 3) or ( j < 7 ) then
					-- avoiding fixed points
					table.insert(newDots,{ newX, newY })
				end
			end
		end
		self._locations[1][1].dots = newDots

		self._locations = deep_clone( self._tweak_data.locations ) or {}
		tweak_data.gui:create_narrative_locations( self._locations )
		self:_create_polylines()
		
		self:_add_location( "vlad", { x=359, y=711, radius=60, type="circle" } )
		self:_add_location( "vlad", { x=1039, y=777, w=162, h=116, type="box" } )
		
		
		self:_add_location( "the_elephant", { x=930, y=271, radius=20, type="circle" } )
		self:_add_location( "the_elephant", { x=1313, y=271, radius=20, type="circle" } )
		self:_add_location( "the_elephant", { x=1120, y=355, radius=10, type="circle" } )
		self:_add_location( "the_elephant", { x=745, y=524, radius=13, type="circle" } )
		
		
		self:_add_location( "hector", { x=1545, y=51, w=358, h=354, type="box" } )
		self:_add_location( "hector", { x=255, y=63, w=397, h=270, type="box" } )
		self:_add_location( { text = "DOWNTOWN", x = 1300/(2048*1.5)*self._map_size_w, y = 450/(1024*1.1)*self._map_size_h } )
		self:_add_location( { text = "THE WHITEHOUSE", x = 1550/(2048*1.5)*self._map_size_w, y = 940/(1024*1.1)*self._map_size_h } )
		self:_add_location( { text = "UNION STATION", x = 2100/(2048*1.5)*self._map_size_w, y = 600/(1024*1.1)*self._map_size_h } )
	end

	function CrimeNetGui:_add_location( contact, data )
		do return end
		self._locations[contact] = self._locations[contact] or {}
		table.insert( self._locations[contact], data ) 
	end

	function CrimeNetGui:update(t, dt)
		if Global.debug_cn_locations and Application:production_build() and is_win32 then
			self._prev_loc = self._prev_loc or {}
			for i, d in pairs(self._locations[1][1].dots) do
				if d[3] and not self._prev_loc[i] then
					Application:debug("Location taken:", i, d[1], d[2])
				elseif not d[3] and self._prev_loc[i] then
					Application:debug("Location removed:", i)
				end
				self._prev_loc[i] = d[3]
			end
		end
		
		local x = (self._fullscreen_panel:child( "cross_indicator_v1" ):x() + self._fullscreen_panel:child( "cross_indicator_v2" ):x()) / 2
		local y = (self._fullscreen_panel:child( "cross_indicator_h1" ):y() + self._fullscreen_panel:child( "cross_indicator_h2" ):y()) / 2
		
		x = string.format( "%.1f", x )
		y = string.format( "%.1f", y )
		local zoom_string = string.format( "%.2f", self._zoom )
		self._panel:child("map_coord_text"):set_text( utf8.to_upper( managers.localization:text( "cn_menu_mapcoords", {zoom=zoom_string, x=x, y=y} ) ) )
		
		local num_jobs = -4
		
		for i, d in pairs( self._jobs ) do
			num_jobs = num_jobs + 1
		end
		
		local friends = (is_win32 and Steam:logged_on() and Steam:friends()) or {}
		local num_friends_playing = 0
		
		for _, friend in ipairs( friends ) do
			if( friend:playing_this() ) then
				num_friends_playing = num_friends_playing + 1
			end
		end
		
		local num_jobs_string = string.format( "%03d", num_jobs )
		local num_friends_playing_string = string.format( "%03d", num_friends_playing )
		self._panel:child("num_contracts_text"):set_text( utf8.to_upper( managers.localization:text( "cn_menu_num_contracts", {contracts=num_jobs_string, friends=num_friends_playing_string} ) ) )
		
		self._panel:child( "cyber_text" ):set_y( 0 - math.mod( math.floor( Application:time() )*200, self._panel:child( "cyber_text" ):line_height() * 10 ) )
		
		
		self._rasteroverlay:set_texture_rect(0, -math.mod(Application:time() * 5, 32), 32, 640)
		if self._released_map then
			self._released_map.dx = math.lerp(self._released_map.dx, 0, dt * 2)
			self._released_map.dy = math.lerp(self._released_map.dy, 0, dt * 2)
			self:_set_map_position(self._released_map.dx, self._released_map.dy)
			if self._map_panel:x() >= -5 or -5 <= self._fullscreen_panel:w() - self._map_panel:right() then
				self._released_map.dx = 0
			end
			if -5 <= self._map_panel:y() or -5 <= self._fullscreen_panel:h() - self._map_panel:bottom() then
				self._released_map.dy = 0
			end
			self._released_map.t = self._released_map.t - dt
			if 0 > self._released_map.t then
				self._released_map = nil
			end
		end
		if not self._grabbed_map then
			local speed = 5
			if self._map_panel:x() > -self:_get_pan_panel_border() then
				local mx = math.lerp(0, -self:_get_pan_panel_border() - self._map_panel:x(), dt * speed)
				self:_set_map_position(mx, 0)
			end
			if self._fullscreen_panel:w() - self._map_panel:right() > -self:_get_pan_panel_border() then
				local mx = math.lerp(0, self:_get_pan_panel_border() - (self._map_panel:right() - self._fullscreen_panel:w()), dt * speed)
				self:_set_map_position(mx, 0)
			end
			if self._map_panel:y() > -self:_get_pan_panel_border() then
				local my = math.lerp(0, -self:_get_pan_panel_border() - self._map_panel:y(), dt * speed)
				self:_set_map_position(0, my)
			end
			if self._fullscreen_panel:h() - self._map_panel:bottom() > -self:_get_pan_panel_border() then
				local my = math.lerp(0, self:_get_pan_panel_border() - (self._map_panel:bottom() - self._fullscreen_panel:h()), dt * speed)
				self:_set_map_position(0, my)
			end
		end
		if not managers.menu:is_pc_controller() and managers.mouse_pointer:mouse_move_x() == 0 and managers.mouse_pointer:mouse_move_y() == 0 then
			local closest_job
			local closest_dist = 100000000
			local closest_job_x, closest_job_y = 0, 0
			local mouse_pos_x, mouse_pos_y = managers.mouse_pointer:modified_mouse_pos()
			local job_x, job_y
			local dist = 0
			local x, y
			for id, job in pairs(self._jobs) do
				job_x, job_y = job.marker_panel:child("select_panel"):world_center()
				x = job_x - mouse_pos_x
				y = job_y - mouse_pos_y
				dist = x * x + y * y
				if closest_dist > dist then
					closest_job = job
					closest_dist = dist
					closest_job_x = job_x
					closest_job_y = job_y
				end
			end
			if closest_job then
				closest_dist = math.sqrt(closest_dist)
				if closest_dist < self._tweak_data.controller.snap_distance then
					managers.mouse_pointer:force_move_mouse_pointer(math.lerp(mouse_pos_x, closest_job_x, dt * self._tweak_data.controller.snap_speed) - mouse_pos_x, math.lerp(mouse_pos_y, closest_job_y, dt * self._tweak_data.controller.snap_speed) - mouse_pos_y)
				end
			end
		end
		--[[for index, special_contract in ipairs(tweak_data.gui.crime_net.special_contracts) do
			if self._jobs[special_contract.id] then
				self:update_job(special_contract.id, t, dt)
			end
		end]]
	end

	function CrimeNetGui:set_players_online( players )
		local players_string = managers.money:add_decimal_marks_to_string( string.format( "%.3d", players ) )
	end

	function CrimeNetGui:toggle_legend()
		managers.menu_component:post_event( "menu_enter" )
	end

	function CrimeNetGui:mouse_pressed( o, button, x, y )
		if( not self._crimenet_enabled ) then
			return
		end
		
		-- if not self._panel:inside( x, y ) then
		-- 	return
		-- end
		--[[
		if self._text_box and self._text_box:visible() then
			if self:mouse_button_click( button ) then
				for i,panel in ipairs( self._text_box._text_box_buttons_panel:children() ) do
					if panel.child and panel:inside( x, y ) then
						if self._text_box:get_focus_button() == 1 then
							self:start_job()
						end
						return true
					end
				end
				
				if self._text_box:check_close( x, y ) then
					self._text_box:set_visible( false )
					for id,job in pairs( self._jobs ) do
						job.expanded = false
					end
					return true
				end
				if self._text_box:check_grab_scroll_bar( x, y ) then
					return true
				end
			elseif self:button_wheel_scroll_down( button ) then
				if self._text_box:mouse_wheel_down( x, y ) then
					return true
				end
			elseif self:button_wheel_scroll_up( button ) then
				if self._text_box:mouse_wheel_up( x, y ) then
					return true
				end
			end
		end
		]]
		
		if self:mouse_button_click( button ) then
			if( self._panel:child("back_button"):inside( x, y ) ) then
				managers.menu:back()
				return
			end
			if( self._panel:child("legends_button"):inside( x, y ) ) then
				self:toggle_legend()
				return
			end
			if self._panel:child("filter_button") and self._panel:child("filter_button"):inside( x, y ) then
				managers.menu_component:post_event( "menu_enter" )
				managers.menu:open_node( "crimenet_filters", {} )
				return
			end
			
			if self:check_job_pressed( x, y ) then
				return true
			end
			
			
			if self._panel:inside( x, y ) then
				self._released_map = nil
				-- self._grabbed_map = { x = x - self._pan_panel:x(), y = y - self._pan_panel:y() } 
				-- self._grabbed_map = { x = -self._panel:x() + x, y = -self._panel:y() + y }
				self._grabbed_map = { x = x, y = y, dirs = {} }
			end
			
		elseif self:button_wheel_scroll_down( button ) then
			if( self._one_scroll_out_delay ) then
				self._one_scroll_out_delay = nil
				-- return true		-- disabling for now
			end
			self:_set_zoom( "out", x, y )
			return true
		elseif self:button_wheel_scroll_up( button ) then
			if( self._one_scroll_in_delay ) then
				self._one_scroll_in_delay = nil
				-- return true		-- disabling for now
			end
			self:_set_zoom( "in", x, y )
			return true
		end
		
		return true
	end
	--[[
	function CrimeNetGui:start_job()
		for id,job in pairs( self._jobs ) do
			if job.expanded then
				if job.preset_id then
					-- MenuCallbackHandler:start_job( job.job_id )
					MenuCallbackHandler:start_job( job )
					self:remove_job( job.preset_id )
					return true
				else
					print( "Is a server, don't want to join", id, job.side_panel:child("host_name"):text() == "WWWWWWWWWWWWµQQW" )
					-- if job.host_name:text() == "WWWWWWWWWWWWµQQW" or job.host_name:text() == "Gaspode" then
						managers.network.matchmake:join_server_with_check( id )
					-- end
					return
				end
			end
		end
	end
	]]
	function CrimeNetGui:mouse_released( o, button, x, y )
		if( not self._crimenet_enabled ) then
			return
		end
		if( not self:mouse_button_click( button ) ) then
			return
		end

		if self._grabbed_map and #self._grabbed_map.dirs > 0 then
			local dx, dy = 0, 0
			for _,values in ipairs( self._grabbed_map.dirs ) do
				dx = dx + values[1]
				dy = dy + values[2]
			end
			dx = dx/#self._grabbed_map.dirs
			dy = dy/#self._grabbed_map.dirs
					
			self._released_map = { t = 2, dx = dx, dy = dy }
			self._grabbed_map = nil
		end 
			
		-- return self._text_box:release_scroll_bar()
	end
	--[[
	function CrimeNetGui:_get_pan_panel_border()
		return self._pan_panel_border * self._zoom
	end
	]]
	function CrimeNetGui:_set_map_position( mx, my )
		--[[
		local x = math.clamp( self._map_panel:x() + mx, self._fullscreen_panel:w() - self._map_panel:w(), 0 ) 
		local y = math.clamp( self._map_panel:y() + my, self._fullscreen_panel:h() - self._map_panel:h(), 0 )
		
		self._pan_panel:set_position( x, y )]]
		
		-- local x = self._map_panel:x() + mx
		-- local y = self._map_panel:y() + my
		
		local x = self._map_x + mx
		local y = self._map_y + my
		
		self._pan_panel:set_position( x, y )
		if self._pan_panel:left() > 0 then
			self._pan_panel:set_left( 0 )
		end
		
		if self._pan_panel:right() < self._fullscreen_panel:w() then
			self._pan_panel:set_right( self._fullscreen_panel:w() )
		end
		
		if self._pan_panel:top() > 0 then
			self._pan_panel:set_top( 0 )
		end
		
		if self._pan_panel:bottom() < self._fullscreen_panel:h() then
			self._pan_panel:set_bottom( self._fullscreen_panel:h() )
		end
		self._map_x, self._map_y = self._pan_panel:position()
		
		self._pan_panel:set_position( math.round(self._map_x), math.round(self._map_y) )
		x, y = self._map_x, self._map_y
		
		self._map_panel:set_shape( self._pan_panel:shape() )
		self._pan_panel:set_position( managers.gui_data:full_16_9_to_safe( x, y ) )
		
		
		local full_16_9 = managers.gui_data:full_16_9_size()
		
		local w_ratio = self._fullscreen_panel:w() / self._map_panel:w()
		local h_ratio = self._fullscreen_panel:h() / self._map_panel:h()
		local panel_x = -(self._map_panel:x() / self._fullscreen_panel:w()) * w_ratio
		local panel_y = -(self._map_panel:y() / self._fullscreen_panel:h()) * h_ratio
		
		
		local cross_indicator_h1 = self._fullscreen_panel:child( "cross_indicator_h1" )
		local cross_indicator_h2 = self._fullscreen_panel:child( "cross_indicator_h2" )
		local cross_indicator_v1 = self._fullscreen_panel:child( "cross_indicator_v1" )
		local cross_indicator_v2 = self._fullscreen_panel:child( "cross_indicator_v2" )
		
		--[[local line_indicator_h1 = self._fullscreen_panel:child( "line_indicator_h1" )
		local line_indicator_h2 = self._fullscreen_panel:child( "line_indicator_h2" )
		local line_indicator_v1 = self._fullscreen_panel:child( "line_indicator_v1" )
		local line_indicator_v2 = self._fullscreen_panel:child( "line_indicator_v2" )]]
			
		cross_indicator_h1:set_y( full_16_9.convert_y + (self._panel:h() * panel_y) )
		cross_indicator_h2:set_bottom( self._fullscreen_panel:child( "cross_indicator_h1" ):y() + (self._panel:h() * h_ratio) )
		cross_indicator_v1:set_x( full_16_9.convert_x + (self._panel:w() * panel_x) )
		cross_indicator_v2:set_right( self._fullscreen_panel:child( "cross_indicator_v1" ):x() + (self._panel:w() * w_ratio) )
		
		--[[line_indicator_h1:set_position( cross_indicator_v1:x(), cross_indicator_h1:y() )
		line_indicator_h2:set_position( cross_indicator_v1:x(), cross_indicator_h2:y() )
		line_indicator_v1:set_position( cross_indicator_v1:x(), cross_indicator_h1:y() )
		line_indicator_v2:set_position( cross_indicator_v2:x(), cross_indicator_h1:y() )
		
		line_indicator_h1:set_w( cross_indicator_v2:x() - cross_indicator_v1:x() )
		line_indicator_h2:set_w( cross_indicator_v2:x() - cross_indicator_v1:x() )
		line_indicator_v1:set_h( cross_indicator_h2:y() - cross_indicator_h1:y() )
		line_indicator_v2:set_h( cross_indicator_h2:y() - cross_indicator_h1:y() )]]
	end

	function CrimeNetGui:mouse_moved( o, x, y )
		if( not self._crimenet_enabled ) then
			return
		end
		-- self._pan_panel:child( "test" ):set_position( -self._panel:x() - self._pan_panel:x() + x, -self._panel:y() - self._pan_panel:y() + y )
		
		if managers.menu:is_pc_controller() then
			if( self._panel:child("back_button"):inside( x, y ) ) then
				if not self._back_highlighted then
					self._back_highlighted = true
					self._panel:child("back_button"):set_color( tweak_data.screen_color_yellow_selected )
					managers.menu_component:post_event( "highlight" )
				end
				return false, "arrow"
			elseif self._back_highlighted then
				self._back_highlighted = false
				self._panel:child("back_button"):set_color( tweak_data.screen_color_yellow )
			end

		end
		
		if self._grabbed_map then
			local left = x > self._grabbed_map.x
			local right = not left
			local up = y > self._grabbed_map.y
			local down = not up
			local mx = x - self._grabbed_map.x
			local my = y - self._grabbed_map.y
			
			if left and self._map_panel:x() > -self:_get_pan_panel_border() then
				mx = math.lerp( mx, 0, 1 - self._map_panel:x()/-self:_get_pan_panel_border() )
			end
			if right and self._fullscreen_panel:w() - self._map_panel:right() > -self:_get_pan_panel_border() then
				mx = math.lerp( mx, 0, 1 - (self._fullscreen_panel:w() - self._map_panel:right())/-self:_get_pan_panel_border() )
			end
			if up and self._map_panel:y() > -self:_get_pan_panel_border() then
				my = math.lerp( my, 0, 1 - self._map_panel:y()/-self:_get_pan_panel_border() )
			end
			if down and self._fullscreen_panel:h() - self._map_panel:bottom() > -self:_get_pan_panel_border() then
				my = math.lerp( my, 0, 1 - (self._fullscreen_panel:h() - self._map_panel:bottom())/-self:_get_pan_panel_border() )
			end
			
			table.insert( self._grabbed_map.dirs, 1, { mx, my } )
			self._grabbed_map.dirs[ 10 ] = nil
			
			self:_set_map_position( mx, my )
					
			self._grabbed_map.x = x
			self._grabbed_map.y = y
			return true, "grab"
		end

		local closest_job
		local closest_dist = 100000000
		local closest_job_x, closest_job_y = 0, 0
		
		local job_x, job_y
		local dist = 0
		
		local inside_any_job = false
		local math_x, math_y
		
		for id, job in pairs( self._jobs ) do
			local inside = (job.marker_panel:child("select_panel"):inside( x, y ) and self._panel:inside( x, y ))
			inside_any_job = inside_any_job or inside
			
			if( inside ) then
				job_x, job_y = job.marker_panel:child("select_panel"):world_center()
			
				math_x = job_x - x
				math_y = job_y - y
				
				dist = math_x * math_x + math_y * math_y
				
				if( dist < closest_dist ) then
					closest_job = job
					closest_dist = dist
					
					closest_job_x = job_x
					closest_job_y = job_y
				end
			end
		end
		
		for id,job in pairs( self._jobs ) do
			local inside = ((job == closest_job) and 1) or (inside_any_job and 2) or 3
			
			self:update_job_gui( job, inside )
		end
		-- local inside_any_job = self:check_job_mouse_over( x, y )
		
		--[[
		local inside_any_job = false
		for id,job in pairs( self._jobs ) do
			local inside = (job.marker_panel:inside( x, y ) and self._panel:inside( x, y ))
			inside_any_job = inside_any_job or inside
			if job.mouse_over ~= inside then
				job.mouse_over = inside
				job.marker_panel:set_alpha(job.mouse_over and 1 or 0.8 )
				job.stars_panel:set_alpha( job.mouse_over and 1 or 0.8 )
				
				if( job.peers_panel ) then
					job.peers_panel:set_alpha( job.mouse_over and 1 or 0.8 )
				end
				
				local animate_show = function( o )
					local start_alpha = o:alpha()
					
					over( 0.3 * (1-start_alpha), function(p) o:set_alpha( math.lerp( start_alpha, 1, p ) ) end )
				end
				local animate_hide = function( o )
					local start_alpha = o:alpha()
					
					over( 0.3 * (start_alpha), function(p) o:set_alpha( math.lerp( start_alpha, 0, p ) ) end )
				end
				job.host_name:stop()
				job.info_text:stop()
				job.host_name:animate( job.mouse_over and animate_hide or animate_show )
				job.info_text:animate( job.mouse_over and animate_show or animate_hide )
				
				
				-- job.marker_rect:set_color( job.marker_rect:color():with_alpha( job.mouse_over and 0.9 or 0.5 ) )
				-- job.host_name:set_visible( job.mouse_over )
				-- job.stars_panel:set_visible( job.mouse_over  )
				-- job.info_panel:set_visible( job.mouse_over )
			end
			if job.expanded then
				-- if job.mouse_over_info ~= job.info_panel:inside( x, y ) then
					-- job.mouse_over_info = job.info_panel:inside( x, y )
					-- job.info_rect:set_color( Color.blue:with_alpha( job.mouse_over_info and 0.9 or 0.5 ) )
						-- job.info_panel:set_visible( job.mouse_over )
				-- end
			end
		end
		]]
		-- print( "CrimeNetGui:mouse_moved" )
		
		if not managers.menu:is_pc_controller() then		
			local to_left 	= x
			local to_right 	= self._panel:w() - x - 19
			local to_top 		= y
			local to_bottom	= self._panel:h() - y - 23
			
			local panel_border = self._pan_panel_border
			to_left 	= 1 - math.clamp( to_left   / panel_border, 0, 1 )
			to_right 	= 1 - math.clamp( to_right  / panel_border, 0, 1 )
			to_top 		= 1 - math.clamp( to_top    / panel_border, 0, 1 )
			to_bottom	= 1 - math.clamp( to_bottom / panel_border, 0, 1 )
			
			-- print( "to_left", to_left, "to_right", to_right, "to_top", to_top, "to_bottom", to_bottom )
			-- print( managers.mouse_pointer:mouse_move_x(), managers.mouse_pointer:mouse_move_y() )
			
			local mouse_pointer_move_x = managers.mouse_pointer:mouse_move_x()
			local mouse_pointer_move_y = managers.mouse_pointer:mouse_move_y()
			
			local mp_left 	= -math.min( 0, mouse_pointer_move_x )
			local mp_right 	= -math.max( 0, mouse_pointer_move_x )
			local mp_top 		= -math.min( 0, mouse_pointer_move_y )
			local mp_bottom = -math.max( 0, mouse_pointer_move_y )
			
			local push_x = mp_left * to_left + mp_right * to_right
			local push_y = mp_top * to_top + mp_bottom * to_bottom
			
			if( push_x ~= 0 or push_y ~= 0 ) then
				self:_set_map_position( push_x, push_y )
			end
			
			--[[
			if self._panel:world_left() - x > -self._pan_panel_border then
				local mx = math.lerp( 0, 1 - (x - self._panel:world_left()) / self._pan_panel_border, speed )
				self:_set_map_position( mx, 0 )
			end
			if self._panel:world_right() - x < self._pan_panel_border then
				local mx = math.lerp( 0, 1 - (self._panel:world_right() - x) / self._pan_panel_border, speed )
				self:_set_map_position( -mx, 0 )
			end
			if self._panel:world_top() - y > -self._pan_panel_border then
				local my = math.lerp( 0, 1 - (y - self._panel:world_top()) / self._pan_panel_border, speed )
				self:_set_map_position( 0, my )
			end
			if self._panel:world_bottom() - y < self._pan_panel_border then
				local my = math.lerp( 0, 1 - (self._panel:world_bottom() - y) / self._pan_panel_border, speed )
				self:_set_map_position( 0, -my )
			end]]
			
		end
		
		if inside_any_job then
			return false, "arrow"
		end
		
		if self._panel:inside( x, y ) then		
			return false, "hand"
		end	
	end

	function CrimeNetGui:close()
		-- print( "CrimeNetGui:close()" )
		managers.crimenet:stop()
		
		if self._crimenet_ambience then
			self._crimenet_ambience:stop()
			self._crimenet_ambience = nil
		end
		managers.menu_component:stop_event()
		managers.menu:active_menu().renderer.ws:show()
		self._ws:panel():remove( self._panel )
		self._fullscreen_ws:panel():remove( self._fullscreen_panel )
		
		--Overlay:gui():destroy_workspace( self._blackborder_workspace )
		self._blackborder_workspace = nil
		
		if managers.controller:get_default_wrapper_type() ~= "pc" then
			managers.menu:active_menu().input:deactivate_controller_mouse()
			managers.mouse_pointer:release_mouse_pointer()
		end
		
		if self._ps3_invites_controller then
			self._ps3_invites_controller:set_enabled( false )
			self._ps3_invites_controller:destroy()
			self._ps3_invites_controller = nil
		end
	end
	
end