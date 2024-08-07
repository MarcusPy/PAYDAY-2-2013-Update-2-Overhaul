UpgradesTweakData = UpgradesTweakData or class()

function UpgradesTweakData:_init_pd2_values()
	self:_init_value_tables()
	
	--[[ R E P   U P G R A D E S ]]
	self.values.rep_upgrades = {}															-- same amount of indexes in both, creates rep_upgrade upgrades
	self.values.rep_upgrades.classes = { "rep_upgrade" }			-- identifier of the upgrade, the upgrade name will be: class .. i  (class is this value, i is index between 1 and 10) ("rep_upgrade1", "rep_upgrade2", etc)
	self.values.rep_upgrades.values = { 2 }										-- how many skill point is rewarded
	
	--[[ A R M O R ]]
	self.values.player.body_armor = { 1, 2, 3, 4, 5, 10 }
	self.values.player.armor_movement_penalty = { 0.96, 0.92, 0.88, 0.84, 0.8, 0.76 } -- A multiplier on movement speed
	
	
	--[[ D E F A U L T  U P G R A D E S ]]
	self.values.player.special_enemy_highlight						= { true }
	self.values.player.hostage_trade											= { true }
	self.values.player.sec_camera_highlight								= { true }
	
	
	--[[ D E P L O Y A B L E   V A L U E S ]]
	self.ammo_bag_base																		= 4
	self.ecm_jammer_base_battery_life											= 20
	self.ecm_jammer_base_low_battery_life									= 8					-- int, not float
	self.sentry_gun_base_ammo															= 150
	self.sentry_gun_base_armor														= 10
	self.doctor_bag_base																	= 2
	
	
	--[[ D L C  U P G R A D E S ]]
		-- PRE-ORDER
	self.values.player.crime_net_deal											= { 0.9 }
	
	--[[ M A S T E R M I N D ]]
		--[[ TIER 1 ]]
			-- TACTICIAN
	self.values.weapon.special_damage_taken_multiplier		= { 1.05 }	-- BASIC
	self.values.player.marked_enemy_extra_damage					= { true }	-- ACE. self.values.player.marked_enemy_damage_mul when active
	self.values.player.marked_enemy_damage_mul						= 1.25				-- ACE. this is read directly
			
			-- CABLE_GUY
	self.values.cable_tie.interact_speed_multiplier				= { 0.5 }		-- BASIC
	self.values.cable_tie.quantity												= { 3 }			-- ACE
	self.values.cable_tie.can_cable_tie_doors							= { true }	-- ACE
	
			-- COMBAT_MEDIC
	self.values.temporary.combat_medic_damage_multiplier	= { { 1.25, 10 }, { 1.25, 15 } }	-- BASIC. { value, time }, only first upgrade is in skilltree
	self.values.player.revive_health_boost								= { 1 }			-- ACE. defines which value in self.revive_health_multiplier to use
	self.revive_health_multiplier													= { 1.5 }		-- ACE. this is read directly
	
		--[[ TIER 2 ]]
			-- CONTROL_FREAK
	self.values.player.civ_harmless_bullets								= { true }	-- BASIC
	self.values.player.civ_harmless_melee									= { true }  -- BASIC
	self.values.player.civ_calming_alerts									= { true }	-- BASIC
	self.values.player.civ_intimidation_mul								= { 10.00 }	-- ACE
	
			-- LEADERSHIP
	self.values.team.pistol.recoil_multiplier							= { 0.75 }	-- BASIC
	self.values.team.weapon.recoil_multiplier							= { 0.35 }	-- ACE
	
			-- INSIDE_MAN
	self.values.player.assets_cost_multiplier							= { 0.5 } 	-- BASIC
	self.values.player.additional_assets									= { true }	-- ACE
	
		--[[ TIER 3 ]]
			-- TRIATHLETE
	self.values.player.stamina_multiplier									= { 2 }			-- BASIC
	self.values.team.stamina.multiplier										= { 1.5 }		-- ACE
	
			-- DOMINATOR
	self.values.player.intimidate_enemies									= { true }	-- BASIC
	self.values.player.intimidate_range_mul								= { 1.5 }			-- ACE
	self.values.player.intimidate_aura										= { 700 }		-- ACE. radius in cm
	
			-- STOCKHOLM_SYNDROME
	self.values.player.civilian_reviver										= { true }	-- BASIC
	self.values.player.civilian_gives_ammo								= { true }	-- ACE
	
		--[[ TIER 4 ]]
			-- BLACK_MARKETEER
	self.values.player.buy_cost_multiplier								= { 0.9, 0.75 } -- BASIC, ACE
	self.values.player.sell_cost_multiplier								= { 1.75 }		-- ACE
	
			-- MEDIC_2X
	self.values.doctor_bag.quantity												= { 1 }			-- BASIC
	self.values.doctor_bag.amount_increase								= { 2 }			-- ACE
	
			-- JOKER
	self.values.player.convert_enemies										= { true }	-- BASIC
	self.values.player.convert_enemies_max_minions				= { 2, 2 }	-- BASIC. only first upgrade is in skilltree
	self.values.player.convert_enemies_health_multiplier	= { 0.5 }	-- ACE. implemented as a damage reduction multiplier
	self.values.player.convert_enemies_damage_multiplier	= { 1.5 }		-- ACE
	
		--[[ TIER 5 ]]
			-- FAST_LEARNER
	self.values.player.xp_multiplier											= { 1.15 }		-- BASIC
	self.values.team.xp.multiplier												= { 1.15 }		-- ACE
		
			-- GUN_FIGHTER
	self.values.pistol.reload_speed_multiplier						= { 1.33 }	-- BASIC
	self.values.pistol.damage_multiplier									= { 1.25 }	-- ACE

			-- KILMER
	self.values.assault_rifle.reload_speed_multiplier			= { 1.33 }	-- BASIC
	self.values.assault_rifle.move_spread_multiplier			= { 0.5 }		-- ACE
	
		--[[ TIER 6 ]]
			-- PISTOL_MESSIAH
	self.values.player.pistol_revive_from_bleed_out				= { 1, 3 }	-- BASIC, ACE
	
			-- EQUILIBRIUM
	self.values.pistol.spread_multiplier									= { 0.9 }		-- BASIC
	self.values.pistol.swap_speed_multiplier							= { 1.5 }		-- BASIC
	self.values.pistol.fire_rate_multiplier								= { 2 }			-- ACE
	
			-- INSPIRE
	self.values.player.revive_interaction_speed_multiplier	= { 0.5 }	-- BASIC
	self.values.player.long_dis_revive										= { true }	-- ACE
	
		--[[ TIER BONUS ]]
	self.values.doctor_bag.interaction_speed_multiplier		= { 0.80 }					-- TIER 1
	self.values.team.stamina.passive_multiplier						= { 1.15, 1.30 }		-- TIER 2, Leadership BASIC
	self.values.player.passive_intimidate_range_mul				= { 1.25 }					-- TIER 3
	self.values.player.passive_convert_enemies_health_multiplier		= { 0.25 }	-- TIER 4. implemented as a damage reduction multiplier
	self.values.player.passive_convert_enemies_damage_multiplier		= { 1.05 }	-- TIER 4
	self.values.player.convert_enemies_interaction_speed_multiplier	= { 0.33 }	-- TIER 5
	self.values.player.empowered_intimidation_mul					= { 3	}							-- TIER 6
	self.values.player.passive_assets_cost_multiplier			= { 0.5 }						-- TIER 6
	
	
	--[[ E N F O R C E R ]]
		--[[ TIER 1 ]]
			-- OPPRESSOR
	self.values.player.suppression_multiplier							= { 1.25, 1.75 }	-- BASIC, ACE
	
			-- PACK_MULE
	self.values.carry.movement_speed_multiplier						= { 1.5 }		-- BASIC
	self.values.carry.throw_distance_multiplier						= { 1.5 }		-- ACE
	
			-- AMMO_RESERVOIR
	self.values.temporary.no_ammo_cost										= { {true, 7}, {true, 14} } -- BASIC, ACE. { value, time }
	
		--[[ TIER 2 ]]
			-- STEROIDS
	self.values.player.non_special_melee_multiplier				= { 2.0 }		-- BASIC
	self.values.player.melee_damage_multiplier						= { 3.0 }		-- ACE
	
			-- SHOW_OF_FORCE
	self.values.player.primary_weapon_when_downed					= { true }	-- BASIC
	self.values.player.armor_regen_timer_multiplier				= { 0.85 }	-- ACE
	
			-- UNDERDOG
	self.values.temporary.dmg_multiplier_outnumbered			= { { 1.1, 7 } }	-- BASIC. { value, time }
	self.values.temporary.dmg_dampener_outnumbered				= { { 0.85, 7 } }	-- ACE. { value, time }
	
		--[[ TIER 3 ]]
			-- BANDOLIERS
	self.values.player.extra_ammo_multiplier							= { 1.25 }		-- BASIC
	self.values.player.pick_up_ammo_multiplier						= { 1.75 }		-- ACE
	
			-- TOUGH_GUY
	self.values.player.damage_shake_multiplier						= { 0.5 }		-- BASIC
	self.values.player.bleed_out_health_multiplier				= { 2 }		-- ACE
	
			-- SHOTGUN_IMPACT
	self.values.shotgun.recoil_multiplier									= { 0.75 }	-- BASIC
	self.values.shotgun.damage_multiplier									= { 1.20 }	-- ACE
	
		--[[ TIER 4 ]]
			-- AMMO_2X
	self.values.ammo_bag.ammo_increase										= { 2 }			-- BASIC
	self.values.ammo_bag.quantity													= { 1 }			-- ACE
	
			-- SHOTGUN_CQB
	self.values.shotgun.reload_speed_multiplier						= { 1.5 }		-- BASIC
	self.values.shotgun.enter_steelsight_speed_multiplier	= { 2.25 }			-- ACE
	
			-- PORTABLE_SAW
	-- BASIC unlocks saw
	self.values.saw.extra_ammo_multiplier									= { 1.5 }			-- ACE. Will double amount of blades
	
		--[[ TIER 5 ]]
			-- SHADES
	self.values.player.flashbang_multiplier								= { 0.5, 0.25 }	-- BASIC, ACE
	
			-- FROM_THE_HIP
	self.values.shotgun.hip_fire_spread_multiplier				= { 0.80 }		-- BASIC
	self.values.pistol.hip_fire_spread_multiplier					= { 0.80 }		-- ACE
	self.values.assault_rifle.hip_fire_spread_multiplier	= { 0.80 }		-- ACE
	self.values.smg.hip_fire_spread_multiplier						= { 0.80 }		-- ACE
	self.values.saw.hip_fire_spread_multiplier						= { 0.80 }		-- ACE
	
			-- CARBON_BLADE
	self.values.player.saw_speed_multiplier								= { 0.9, 0.7 }	-- BASIC, ACE
	self.values.saw.lock_damage_multiplier								= { 1.2, 1.4 }	-- BASIC, ACE
	self.values.saw.enemy_slicer													= { true }				-- ACE. Less ammo usage when killing enemies
	
		--[[ TIER 6 ]]
			-- WOLVERINE
	self.values.player.melee_damage_health_ratio_multiplier	= { 5.0 }	-- BASIC. Additional damage ontop of base damage ( multiplier of base damage, 1 = x2 (1+1) damage, 5 = x6 (1+5) damage ect. )
	self.values.player.damage_health_ratio_multiplier			= { 1.0 }		-- ACE. Additional damage ontop of base damage
	self.player_damage_health_ratio_threshold							= 0.4 			-- ACE. when self.values.damage_health_ratio_multiplier starts to kick in (health of player 0-1)

			-- JUGGERNAUT
	-- BASIC unlocks armor level 7
	self.values.player.shield_knock												= { true }	-- ACE
	
			-- OVERKILL
	self.values.temporary.overkill_damage_multiplier			= { { 2, 6 } } -- BASIC { value, time }
	self.values.player.overkill_all_weapons								= { true }	-- ACE	
	
		--[[ TIER BONUS ]]
	self.values.player.passive_suppression_multiplier			= { 1.1, 1.2 }				-- TIER 1, TIER 3
	self.values.player.passive_health_multiplier					= { 1.1, 1.20, 1.40 }		-- TIER 2, TIER 4, TIER 6
	self.values.weapon.passive_damage_multiplier					= { 1.05 } 						-- TIER 5
	
	
	--[[ T E C H N I C I A N ]]
		--[[ TIER 1 ]]
			-- RIFLEMAN
	self.values.assault_rifle.enter_steelsight_speed_multiplier	= { 2 }	-- BASIC
	self.values.assault_rifle.zoom_increase								= { 2 }		-- ACE. increase in the tweak_data.weapon.stats.zoom
	
			-- MASTER_CRAFTSMAN
	self.values.player.crafting_weapon_multiplier					= { 0.90 }		-- BASIC
	self.values.player.crafting_mask_multiplier						= { 0.0 }		-- ACE
	
			-- TRIP_MINER
	self.values.trip_mine.quantity_1											= { 3 }			-- BASIC
	self.values.trip_mine.can_switch_on_off								= { true }	-- ACE

		--[[ TIER 2 ]]
			-- DRILL_EXPERT
	self.values.player.drill_speed_multiplier							= { 0.9, 0.75 }	-- BASIC, ACE
	
			-- TRIP_MINE_EXPERT
	self.values.player.trip_mine_deploy_time_multiplier		= { 0.80, 0.5 }	-- TRIP_MINE_EXPERT: BASIC, HARDWARE_EXPERT: BASIC
	self.values.trip_mine.sensor_toggle										= { true }	-- ACE
	
			-- HARDWARE_EXPERT
	-- BASIC uses self.values.player.trip_mine_deploy_time_multiplier, having one of them gives first value, having both gives second
	self.values.player.drill_fix_interaction_speed_multiplier	= { 0.75 }	-- BASIC
	self.values.player.drill_autorepair										= { 0.3 }		-- ACE
	self.values.player.sentry_gun_deploy_time_multiplier	= { 0.50 }	-- ACE
	
		--[[ TIER 3 ]]
			-- SENTRY_GUN
	-- BASIC unlocks sentry gun
	self.values.sentry_gun.armor_multiplier								= { 2 }		-- ACE
	
			-- SHARPSHOOTER
	self.values.weapon.single_spread_multiplier						= { 0.5 }		-- BASIC
	self.values.assault_rifle.recoil_multiplier						= { 0.75 }	-- ACE
	
			-- INSULATION
	self.values.player.taser_malfunction									= { true }	-- BASIC
	self.values.player.taser_self_shock										= { true }	-- ACE
	
		--[[ TIER 4 ]]
			-- SENTRY_TARGETING_PACKAGE
	self.values.sentry_gun.spread_multiplier							= { 0.25 }		-- BASIC
	self.values.sentry_gun.rot_speed_multiplier						= { 2 }		-- ACE
	
			-- DISCIPLINE
	self.values.player.interacting_damage_multiplier			= { 0.5 }		-- BASIC
	self.values.player.steelsight_when_downed							= { true }	-- ACE
	
			-- SILENT_DRILLING
	self.values.player.drill_alert_rad										= { 900 }		-- BASIC. in cm  (?)
	self.values.player.silent_drill												= { true }	-- ACE
	
		--[[ TIER 5 ]]
			-- SENTRY_2_0
	self.values.sentry_gun.extra_ammo_multiplier					= { 2, 2 }	-- BASIC. only first upgrade is in skilltree
	self.values.sentry_gun.shield													= { true }	-- ACE
	
			-- BLAST_RADIUS
	self.values.trip_mine.explosion_size_multiplier				= { 1.25, 1.75 }	-- BASIC, ACE
	
			-- SHAPED_CHARGE
	self.values.trip_mine.quantity_3											= { 5 }			-- BASIC. amount
	self.values.player.trip_mine_shaped_charge						= { true }	-- ACE
	
	
		--[[ TIER 6 ]]
			-- SENTRY_GUN_2X
	self.values.sentry_gun.quantity												= { 3 }			-- BASIC. amount
	self.values.sentry_gun.damage_multiplier							= { 2 }			-- ACE
	
			-- MAG_PLUS
	self.values.weapon.clip_ammo_increase									= { 5, 15 }	-- BASIC, ACE
	
			-- IRON_MAN
	self.values.player.armor_multiplier										= { 1.5 }		-- BASIC
	self.values.team.armor.regen_time_multiplier					= { 0.75 }		-- ACE
	
		--[[ TIER BONUS ]]
	self.values.player.passive_crafting_weapon_multiplier	= { 0.98, 0.96, 0.94 }	-- TIER 1, TIER 3, TIER 5
	self.values.player.passive_crafting_mask_multiplier		= { 0.75, 0.5, 0.25 }	-- TIER 1, TIER 3, TIER 5
	self.values.weapon.passive_recoil_multiplier					= { 0.95, 0.9 }					-- TIER 2, TIER 6
	self.values.weapon.passive_headshot_damage_multiplier	= { 1.25 }							-- TIER 4
	self.values.player.passive_armor_multiplier						= { 1.1, 1.25 }					-- TIER 6. only first upgrade is in skilltree
	self.values.team.armor.passive_regen_time_multiplier	= { 0.9 }							-- TIER 6
	
	
	--[[ G H O S T ]]
		--[[ TIER 1 ]]
			-- SCAVENGER
	self.values.player.small_loot_multiplier							= { 1.2, 1.65 }	-- BASIC, ACE
	
			-- SPRINTER
	self.values.player.stamina_regen_timer_multiplier			= { 0.75 }	-- BASIC
	self.values.player.stamina_regen_multiplier						= { 1.25 }	-- BASIC
	self.values.player.run_dodge_chance										= { 0.25 }	-- ACE
	self.values.player.run_speed_multiplier								= { 1.25 }	-- ACE
	
			-- CAT_BURGLAR
	self.values.player.fall_damage_multiplier							= { 0.5 }		-- BASIC
	self.values.player.fall_health_damage_multiplier			= { 0.0 }		-- ACE	-- THIS ONE IS LOCKED TO THE SKILL DESCRIPTION AND CANNOT BE CHANGED WITHOUT CHANGING THE DESRIPTION
	self.values.player.respawn_time_multiplier						= { 0.5 } 	-- ACE
	
		--[[ TIER 2 ]]
			-- CLEANER
	self.values.player.corpse_alarm_pager_bluff						= { true }	-- BASIC. tweak_data.player.alarm_pager[ has_upgrade and "bluff_success_chance_w_skill" or "bluff_success_chance" ]
	self.values.player.corpse_dispose											= { true }	-- ACE
	
			-- TRANSPORTER
	self.values.carry.interact_speed_multiplier						= { 0.6, 0.25 }	-- BASIC, ACE
	
			-- CHAMELEON
	self.values.player.suspicion_multiplier								= { 0.75 }	-- BASIC
	self.values.player.camouflage_bonus										= { 1.25 }	-- ACE. multiplier to player's detection delay
	
		--[[ TIER 3 ]]
			-- ASSASSIN
	self.values.player.walk_speed_multiplier							= { 1.25 }	-- BASIC
	self.values.player.crouch_speed_multiplier						= { 1.25 }	-- BASIC
	self.values.player.silent_kill												= { 400 }		-- ACE. in cm alert radius on dead and hurt enemies
	
			-- MARTIAL_ARTS
	self.values.player.melee_knockdown_mul								= { 1.5 }		-- BASIC
	self.values.player.damage_dampener										= { 0.5 }		-- ACE. multiplier
	
			-- SMG_MASTER
	self.values.smg.reload_speed_multiplier								= { 1.33 }	-- BASIC
	self.values.smg.recoil_multiplier											= { 0.75 }	-- ACE
	
		--[[ TIER 4 ]]
			-- NINE_LIVES
	self.values.player.additional_lives										= { 1, 3 }	-- BASIC, ACE, ACE NOT USED
	self.values.player.cheat_death_chance 								= { 0.1 }
	
			-- ECM_FEEDBACK
	self.values.ecm_jammer.can_activate_feedback					= { true }	-- BASIC
	self.values.ecm_jammer.feedback_duration_boost				= { 2 }	-- ACE
	
			-- HITMAN
	self.values.weapon.silencer_damage_multiplier					= { 1.1, 1.2 }	-- BASIC, ACE
	
		--[[ TIER 5 ]]
			-- ECM_BOOSTER
	self.values.ecm_jammer.duration_multiplier						= { 1.25 }	-- BASIC
	self.values.ecm_jammer.can_open_sec_doors							= { true }	-- ACE
	
			-- MAGIC_TOUCH
	self.values.player.pick_lock_easy											= { true }	-- BASIC
	self.values.player.pick_lock_easy_speed_multiplier		= { 0.75 }	-- BASIC. reduces speed for pick_lock_easy, pick_lock_easy_no_skill and pick_lock_hard_no_skill interactions
	self.values.player.pick_lock_hard											= { true }	-- ACE
			
			-- SILENCE_EXPERT
	self.values.weapon.silencer_recoil_multiplier					= { 0.5 }		-- BASIC
	self.values.weapon.silencer_spread_multiplier					= { 0.5 }		-- ACE
	self.values.weapon.silencer_enter_steelsight_speed_multiplier	= { 2.0 }	-- ACE
		
		--[[ TIER 6 ]]
			-- GOOD_LUCK_CHARM
	self.values.player.loot_drop_multiplier								= { 2, 3 }	-- BASIC, ACE
	
			-- ECM_2X
	self.values.ecm_jammer.quantity												= { 1, 3 }	-- BASIC, ACE
	self.values.ecm_jammer.duration_multiplier_2					= { 1.25 }	-- ACE
	self.values.ecm_jammer.feedback_duration_boost_2			= { 1.25 }	-- ACE
	
			-- MOVING_TARGET
	self.values.player.can_strafe_run											= { true }	-- BASIC
	self.values.player.can_free_run												= { true }	-- ACE
			
		--[[ TIER BONUS ]]
	self.values.ecm_jammer.affects_cameras								= { true }				-- TIER 1
	self.values.player.passive_dodge_chance								= { 0.05, 0.15 }	-- TIER 1, TIER 3
	self.values.weapon.passive_swap_speed_multiplier			= { 1.2, 2 }		-- TIER 2, TIER 5
	self.values.player.passive_suspicion_multiplier				= { 0.75 }				-- TIER 4
	self.values.player.passive_loot_drop_multiplier				= { 1.1 }				-- TIER 6
end