if RequiredScript == "lib/managers/mission/elementspecialobjective" then
    function ElementSpecialObjective:nav_link_delay()
        return 0.1
    end
end

if RequiredScript == "lib/tweak_data/groupaitweakdata" then
	function GroupAITweakData:_init_unit_categories()
		local access_type_walk_only = {walk = true}
		local access_type_all = {walk = true, acrobatic = true}
		self.unit_categories = {
			security = {
				units = {
					Idstring("units/payday2/characters/ene_security_1/ene_security_1"),
					Idstring("units/payday2/characters/ene_security_2/ene_security_2"),
					Idstring("units/payday2/characters/ene_security_3/ene_security_3")
				},
				access = access_type_walk_only
			},
			cop = {
				units = {
					Idstring("units/payday2/characters/ene_cop_1/ene_cop_1"),
					Idstring("units/payday2/characters/ene_cop_2/ene_cop_2"),
					Idstring("units/payday2/characters/ene_cop_4/ene_cop_4")
				},
				access = access_type_walk_only
			},
			cop_special = {
				units = {
					Idstring("units/payday2/characters/ene_cop_3/ene_cop_3")
				},
				access = access_type_walk_only
			},
			fbi = {
				units = {
					Idstring("units/payday2/characters/ene_fbi_1/ene_fbi_1"),
					Idstring("units/payday2/characters/ene_fbi_2/ene_fbi_2"),
					Idstring("units/payday2/characters/ene_fbi_3/ene_fbi_3")
				},
				access = access_type_walk_only
			},
			fbi_special = {
				units = {
					Idstring("units/payday2/characters/ene_fbi_3/ene_fbi_3")
				},
				access = access_type_all
			},
			swat = {
				units = {
					Idstring("units/payday2/characters/ene_swat_1/ene_swat_1"),
					Idstring("units/payday2/characters/ene_swat_2/ene_swat_2")
				},
				access = access_type_all
			},
			swat_assault = {
				units = {
					Idstring("units/payday2/characters/ene_swat_1/ene_swat_1")
				},
				access = access_type_all
			},
			swat_close = {
				units = {
					Idstring("units/payday2/characters/ene_swat_2/ene_swat_2")
				},
				access = access_type_all
			},
			swat_kevlar = {
				units = {
					Idstring("units/payday2/characters/ene_fbi_swat_1/ene_fbi_swat_1"),
					Idstring("units/payday2/characters/ene_fbi_swat_2/ene_fbi_swat_2")
				},
				access = access_type_all
			},
			swat_kevlar_assault = {
				units = {
					Idstring("units/payday2/characters/ene_fbi_swat_1/ene_fbi_swat_1")
				},
				access = access_type_all
			},
			swat_kevlar_close = {
				units = {
					Idstring("units/payday2/characters/ene_fbi_swat_2/ene_fbi_swat_2")
				},
				access = access_type_all
			},
			swat_heavy = {
				units = {
					Idstring("units/payday2/characters/ene_swat_heavy_1/ene_swat_heavy_1")
				},
				access = access_type_all
			},
			tank = {
				units = {
					Idstring("units/payday2/characters/ene_bulldozer_1/ene_bulldozer_1")
				},
				access = access_type_walk_only,
				max_amount = 4,
				special_type = "tank"
			},
			shield = {
				units = {
					Idstring("units/payday2/characters/ene_shield_1/ene_shield_1")
				},
				access = access_type_walk_only,
				max_amount = 10,
				special_type = "shield"
			},
			shield_small = {
				units = {
					Idstring("units/payday2/characters/ene_shield_2/ene_shield_2")
				},
				access = access_type_walk_only,
				max_amount = 10,
				special_type = "shield"
			},
			spooc = {
				units = {
					Idstring("units/payday2/characters/ene_spook_1/ene_spook_1")
				},
				access = access_type_all,
				max_amount = 10,
				special_type = "spooc"
			},
			taser = {
				units = {
					Idstring("units/payday2/characters/ene_tazer_1/ene_tazer_1")
				},
				access = access_type_all,
				max_amount = 6,
				special_type = "taser"
			},
			sniper = {
				units = {
					Idstring("units/payday2/characters/ene_sniper_1/ene_sniper_1")
				},
				access = access_type_all
			},
			GEN_security = {
				units = {
					Idstring("units/payday2/characters/ene_security_1/ene_security_1"),
					Idstring("units/payday2/characters/ene_security_2/ene_security_2"),
					Idstring("units/payday2/characters/ene_security_3/ene_security_3")
				},
				access = access_type_walk_only
			},
			GEN_sniper = {
				units = {
					Idstring("units/payday2/characters/ene_sniper_1/ene_sniper_1")
				},
				access = access_type_all
			},
			CS_cop_C45_R870 = {
				units = {
					Idstring("units/payday2/characters/ene_cop_1/ene_cop_1"),
					Idstring("units/payday2/characters/ene_cop_2/ene_cop_2"),
					Idstring("units/payday2/characters/ene_cop_4/ene_cop_4")
				},
				access = access_type_walk_only
			},
			CS_cop_stealth_MP5 = {
				units = {
					Idstring("units/payday2/characters/ene_cop_3/ene_cop_3")
				},
				access = access_type_walk_only
			},
			CS_swat_MP5 = {
				units = {
					Idstring("units/payday2/characters/ene_swat_1/ene_swat_1")
				},
				access = access_type_all
			},
			CS_swat_R870 = {
				units = {
					Idstring("units/payday2/characters/ene_swat_2/ene_swat_2")
				},
				access = access_type_all
			},
			CS_heavy_M4 = {
				units = {
					Idstring("units/payday2/characters/ene_swat_heavy_1/ene_swat_heavy_1")
				},
				access = access_type_all
			},
			CS_heavy_M4_w = {
				units = {
					Idstring("units/payday2/characters/ene_swat_heavy_1/ene_swat_heavy_1")
				},
				access = access_type_walk_only
			},
			CS_tazer = {
				units = {
					Idstring("units/payday2/characters/ene_tazer_1/ene_tazer_1")
				},
				access = access_type_all,
				max_amount = 6,
				special_type = "taser"
			},
			CS_shield = {
				units = {
					Idstring("units/payday2/characters/ene_shield_2/ene_shield_2")
				},
				access = access_type_walk_only,
				max_amount = 10,
				special_type = "shield"
			},
			FBI_suit_C45_M4 = {
				units = {
					Idstring("units/payday2/characters/ene_fbi_1/ene_fbi_1"),
					Idstring("units/payday2/characters/ene_fbi_2/ene_fbi_2")
				},
				access = access_type_all
			},
			FBI_suit_M4_MP5 = {
				units = {
					Idstring("units/payday2/characters/ene_fbi_2/ene_fbi_2"),
					Idstring("units/payday2/characters/ene_fbi_3/ene_fbi_3")
				},
				access = access_type_all
			},
			FBI_suit_stealth_MP5 = {
				units = {
					Idstring("units/payday2/characters/ene_fbi_3/ene_fbi_3")
				},
				access = access_type_all
			},
			FBI_swat_M4 = {
				units = {
					Idstring("units/payday2/characters/ene_fbi_swat_1/ene_fbi_swat_1")
				},
				access = access_type_all
			},
			FBI_swat_R870 = {
				units = {
					Idstring("units/payday2/characters/ene_fbi_swat_2/ene_fbi_swat_2")
				},
				access = access_type_all
			},
			FBI_heavy_G36 = {
				units = {
					Idstring("units/payday2/characters/ene_fbi_heavy_1/ene_fbi_heavy_1")
				},
				access = access_type_all
			},
			FBI_heavy_G36_w = {
				units = {
					Idstring("units/payday2/characters/ene_fbi_heavy_1/ene_fbi_heavy_1")
				},
				access = access_type_walk_only
			},
			FBI_spooc = {
				units = {
					Idstring("units/payday2/characters/ene_spook_1/ene_spook_1")
				},
				max_amount = 10,
				access = access_type_all,
				special_type = "spooc"
			},
			FBI_shield = {
				units = {
					Idstring("units/payday2/characters/ene_shield_1/ene_shield_1")
				},
				access = access_type_walk_only,
				max_amount = 10,
				special_type = "shield"
			},
			FBI_tank = {
				units = {
					Idstring("units/payday2/characters/ene_bulldozer_1/ene_bulldozer_1")
				},
				access = access_type_walk_only,
				max_amount = 4,
				special_type = "tank"
			}
		}
	end

	function GroupAITweakData:_init_enemy_spawn_groups()
		local tactics_CS_cop = {
			"provide_coverfire",
			"provide_support",
			"ranged_fire"
		}
		local tactics_CS_cop_stealth = {
			"flank",
			"provide_coverfire",
			"provide_support"
		}
		local tactics_CS_swat_rifle = {
			"smoke_grenade",
			"charge",
			"provide_coverfire",
			"provide_support",
			"ranged_fire",
			"deathguard"
		}
		local tactics_CS_swat_shotgun = {
			"smoke_grenade",
			"charge",
			"provide_coverfire",
			"provide_support",
			"shield_cover"
		}
		local tactics_CS_swat_heavy = {
			"smoke_grenade",
			"charge",
			"flash_grenade",
			"provide_coverfire",
			"provide_support"
		}
		local tactics_CS_shield = {
			"charge",
			"provide_coverfire",
			"provide_support",
			"shield",
			"deathguard"
		}
		local tactics_CS_swat_rifle_flank = {
			"flank",
			"flash_grenade",
			"smoke_grenade",
			"charge",
			"provide_coverfire",
			"provide_support"
		}
		local tactics_CS_swat_shotgun_flank = {
			"flank",
			"flash_grenade",
			"smoke_grenade",
			"charge",
			"provide_coverfire",
			"provide_support"
		}
		local tactics_CS_swat_heavy_flank = {
			"flank",
			"flash_grenade",
			"smoke_grenade",
			"charge",
			"provide_coverfire",
			"provide_support",
			"shield_cover"
		}
		local tactics_CS_shield_flank = {
			"flank",
			"charge",
			"flash_grenade",
			"provide_coverfire",
			"provide_support",
			"shield"
		}
		local tactics_CS_tazer = {
			"flank",
			"charge",
			"flash_grenade",
			"provide_coverfire",
			"provide_support"
		}
		local tactics_FBI_suit = {
			"provide_coverfire",
			"provide_support",
			"ranged_fire"
		}
		local tactics_FBI_suit_stealth = {
			"provide_coverfire",
			"provide_support"
		}
		local tactics_FBI_swat_rifle = {
			"smoke_grenade",
			"flash_grenade",
			"provide_coverfire",
			"charge",
			"provide_support",
			"ranged_fire"
		}
		local tactics_FBI_swat_shotgun = {
			"smoke_grenade",
			"flash_grenade",
			"charge",
			"provide_coverfire",
			"provide_support"
		}
		local tactics_FBI_heavy = {
			"smoke_grenade",
			"flash_grenade",
			"charge",
			"provide_coverfire",
			"provide_support",
			"shield_cover",
			"deathguard"
		}
		local tactics_FBI_shield = {
			"smoke_grenade",
			"charge",
			"provide_coverfire",
			"provide_support",
			"shield",
			"deathguard"
		}
		local tactics_FBI_swat_rifle_flank = {
			"flank",
			"smoke_grenade",
			"flash_grenade",
			"charge",
			"provide_coverfire",
			"provide_support"
		}
		local tactics_FBI_swat_shotgun_flank = {
			"flank",
			"smoke_grenade",
			"flash_grenade",
			"charge",
			"provide_coverfire",
			"provide_support"
		}
		local tactics_FBI_heavy_flank = {
			"flank",
			"smoke_grenade",
			"flash_grenade",
			"charge",
			"provide_coverfire",
			"provide_support",
			"shield_cover"
		}
		local tactics_FBI_shield_flank = {
			"flank",
			"smoke_grenade",
			"flash_grenade",
			"charge",
			"provide_coverfire",
			"provide_support",
			"shield"
		}
		local tactics_FBI_spooc = {
			"flank",
			"smoke_grenade",
			"flash_grenade",
			"charge",
			"provide_coverfire"
		}
		local tactics_FBI_tank = {
			"charge",
			"provide_coverfire",
			"provide_support",
			"deathguard",
			"shield"
		}
		
		self.enemy_spawn_groups.CS_defend_a = {
			amount = 4,
			spawn = {
				{
					unit = "CS_cop_C45_R870",
					freq = 1,
					amount_min = 1,
					tactics = tactics_CS_cop,
					rank = 1
				}
			}
		}
		self.enemy_spawn_groups.CS_defend_b = {
			amount = 4,
			spawn = {
				{
					unit = "CS_swat_MP5",
					freq = 1,
					amount_min = 1,
					tactics = tactics_CS_cop,
					rank = 1
				}
			}
		}
		self.enemy_spawn_groups.CS_defend_c = {
			amount = 4,
			spawn = {
				{
					unit = "CS_heavy_M4",
					freq = 1,
					amount_min = 1,
					tactics = tactics_CS_cop,
					rank = 1
				}
			}
		}
		self.enemy_spawn_groups.CS_cops = {
			amount = 4,
			spawn = {
				{
					unit = "CS_cop_C45_R870",
					freq = 1,
					amount_min = 1,
					tactics = tactics_CS_cop,
					rank = 1
				}
			}
		}
		self.enemy_spawn_groups.CS_stealth_a = {
			amount = 4,
			spawn = {
				{
					unit = "CS_cop_stealth_MP5",
					freq = 1,
					amount_min = 1,
					tactics = tactics_CS_cop_stealth,
					rank = 1
				}
			}
		}
		self.enemy_spawn_groups.CS_swats = {
			amount = 4,
			spawn = {
				{
					unit = "CS_swat_MP5",
					freq = 1,
					amount_min = 1,
					tactics = tactics_CS_swat_rifle,
					rank = 2
				},
				{
					unit = "CS_swat_R870",
					freq = 0.5,
					amount_min = 1,
					tactics = tactics_CS_swat_shotgun,
					rank = 1
				},
				{
					unit = "CS_swat_MP5",
					freq = 0.33,
					amount_min = 1,
					tactics = tactics_CS_swat_rifle_flank,
					rank = 3
				}
			}
		}
		self.enemy_spawn_groups.CS_heavys = {
			amount = 4,
			spawn = {
				{
					unit = "CS_heavy_M4",
					freq = 1,
					amount_min = 1,
					tactics = tactics_CS_swat_rifle,
					rank = 1
				},
				{
					unit = "CS_heavy_M4",
					freq = 0.35,
					amount_min = 1,
					tactics = tactics_CS_swat_rifle_flank,
					rank = 2
				}
			}
		}
		self.enemy_spawn_groups.CS_shields = {
			amount = 4,
			spawn = {
				{
					unit = "CS_shield",
					freq = 1,
					amount_min = 1,
					tactics = tactics_CS_shield,
					rank = 3
				},
				{
					unit = "CS_shield",
					freq = 0.1,
					amount_min = 1,
					tactics = tactics_CS_shield,
					rank = 2
				},
				{
					unit = "CS_heavy_M4_w",
					freq = 1,
					amount_min = 1,
					tactics = tactics_CS_swat_heavy,
					rank = 1
				}
			}
		}
		self.enemy_spawn_groups.CS_tazers = {
			amount = 2,
			spawn = {
				{
					unit = "CS_tazer",
					freq = 1,
					amount_min = 1,
					tactics = tactics_CS_tazer,
					rank = 1
				}
			}
		}
		self.enemy_spawn_groups.CS_tanks = {
			amount = 1,
			spawn = {
				{
					unit = "FBI_tank",
					freq = 1,
					amount_min = 1,
					amaount_max = 2,
					tactics = tactics_FBI_tank,
					rank = 1
				}
			}
		}
		self.enemy_spawn_groups.FBI_defend_a = {
			amount = 4,
			spawn = {
				{
					unit = "FBI_suit_C45_M4",
					freq = 1,
					amount_min = 1,
					tactics = tactics_FBI_suit,
					rank = 2
				},
				{
					unit = "CS_cop_C45_R870",
					freq = 1,
					amount_min = 1,
					tactics = tactics_FBI_suit,
					rank = 1
				}
			}
		}
		self.enemy_spawn_groups.FBI_defend_b = {
			amount = 4,
			spawn = {
				{
					unit = "FBI_suit_M4_MP5",
					freq = 1,
					amount_min = 1,
					tactics = tactics_FBI_suit,
					rank = 2
				},
				{
					unit = "FBI_swat_M4",
					freq = 1,
					amount_min = 1,
					tactics = tactics_FBI_suit,
					rank = 1
				}
			}
		}
		self.enemy_spawn_groups.FBI_defend_c = {
			amount = 4,
			spawn = {
				{
					unit = "FBI_swat_M4",
					freq = 1,
					amount_min = 1,
					tactics = tactics_FBI_suit,
					rank = 1
				}
			}
		}
		self.enemy_spawn_groups.FBI_defend_d = {
			amount = 4,
			spawn = {
				{
					unit = "FBI_heavy_G36",
					freq = 1,
					amount_min = 1,
					tactics = tactics_FBI_suit,
					rank = 1
				}
			}
		}
		self.enemy_spawn_groups.FBI_stealth_a = {
			amount = 4,
			spawn = {
				{
					unit = "FBI_suit_stealth_MP5",
					freq = 1,
					amount_min = 1,
					tactics = tactics_FBI_suit_stealth,
					rank = 1
				}
			}
		}
		self.enemy_spawn_groups.FBI_stealth_b = {
			amount = 4,
			spawn = {
				{
					unit = "FBI_suit_stealth_MP5",
					freq = 1,
					amount_min = 1,
					tactics = tactics_FBI_suit_stealth,
					rank = 1
				}
			}
		}
		self.enemy_spawn_groups.FBI_swats = {
			amount = 4,
			spawn = {
				{
					unit = "FBI_swat_M4",
					freq = 1,
					amount_min = 1,
					tactics = tactics_FBI_swat_rifle,
					rank = 2
				},
				{
					unit = "FBI_swat_M4",
					freq = 0.75,
					amount_min = 1,
					tactics = tactics_FBI_swat_rifle_flank,
					rank = 3
				},
				{
					unit = "FBI_swat_R870",
					freq = 0.5,
					amount_min = 1,
					tactics = tactics_FBI_swat_shotgun,
					rank = 1
				}
			}
		}
		self.enemy_spawn_groups.FBI_heavys = {
			amount = 4,
			spawn = {
				{
					unit = "FBI_heavy_G36",
					freq = 1,
					amount_min = 1,
					tactics = tactics_FBI_swat_rifle,
					rank = 1
				},
				{
					unit = "FBI_heavy_G36",
					freq = 0.5,
					amount_min = 1,
					tactics = tactics_FBI_swat_rifle_flank,
					rank = 2
				}
			}
		}
		self.enemy_spawn_groups.FBI_shields = {
			amount = 4,
			spawn = {
				{
					unit = "FBI_shield",
					freq = 0.3,
					amount_min = 1,
					tactics = tactics_FBI_shield_flank,
					rank = 3
				},
				{
					unit = "FBI_heavy_G36_w",
					freq = 1,
					amount_min = 1,
					tactics = tactics_FBI_heavy_flank,
					rank = 1
				}
			}
		}
		self.enemy_spawn_groups.FBI_spoocs = {
			amount = 3,
			spawn = {
				{
					unit = "FBI_spooc",
					freq = 1,
					amount_min = 1,
					tactics = tactics_FBI_suit_stealth,
					rank = 1
				}
			}
		}
		self.enemy_spawn_groups.FBI_tanks = {
			amount = 2,
			spawn = {
				{
					unit = "FBI_tank",
					freq = 1,
					amount_min = 1,
					amaount_max = 4,
					tactics = tactics_FBI_tank,
					rank = 1
				}
			}
		}
	end
	-- forces difficulty scaling to around max, rather than adjusting it based on the number of players
	function GroupAITweakData:_init_task_data()
		local is_console = SystemInfo:platform() ~= Idstring("WIN32")
		self.max_nr_simultaneous_boss_types = 10
		self.difficulty_curve_points = {0.5}
		self.optimal_trade_distance = {0, 0}
		self.bain_assault_praise_limits = {1, 3}
		self.besiege.regroup.duration = {
			15,
			15,
			15
		}
		self.besiege.assault.anticipation_duration = {
			{30, 1},
			--{30, 1},
			--{45, 0.5}
		}
		self.besiege.assault.build_duration = 20
		self.besiege.assault.sustain_duration_min = {
			0,
			80,
			120
		}
		self.besiege.assault.sustain_duration_max = {
			0,
			80,
			120
		}
		self.besiege.assault.sustain_duration_balance_mul = {
			1.5,
			1.5,
			1.5,
			1.5
		}
		self.besiege.assault.fade_duration = 5
		self.besiege.assault.delay = {
			80,
			70,
			30
		}
		self.besiege.assault.hostage_hesitation_delay = {
			10,
			10,
			10
		}
		self.besiege.assault.force = {
			0,
			5,
			7
		}
		self.besiege.assault.force_pool = {
			0,
			20,
			50
		}
		self.besiege.assault.force_balance_mul = {
			1,
			1.5,
			2,
			2.25
		}
		self.besiege.assault.force_pool_balance_mul = {
			1,
			1.5,
			2,
			3
		}
		self.besiege.assault.groups = {
			CS_swats = {
				0,
				1,
				0.7
			},
			CS_heavys = {
				0,
				0,
				0.5
			},
			CS_shields = {
				0,
				0,
				0.1
			}
		}
		self.besiege.reenforce.interval = {
			10,
			20,
			30
		}
		self.besiege.reenforce.groups = {
			CS_defend_a = {
				1,
				0.2,
				0
			},
			CS_defend_b = {
				0,
				1,
				1
			}
		}
		self.besiege.recon.interval = {
			5,
			5,
			5
		}
		self.besiege.recon.force = {
			2,
			4,
			6
		}
		self.besiege.recon.interval_variation = 40
		self.besiege.recon.groups = {
			CS_stealth_a = {
				1,
				1,
				0
			},
			CS_swats = {
				0,
				1,
				1
			}
		}
	end

	function GroupAITweakData:_set_hard()
		self.max_nr_simultaneous_boss_types = 5
		
		self.besiege.assault.groups = {
			CS_swats = {
				0,
				1,
				0
			},
			CS_heavys = {
				0,
				0.2,
				1
			},
			CS_shields = {
				0,
				0.02,
				1
			},
			CS_tazers = {
				0,
				0.01,
				0.25
			},
			CS_tanks = {
				0,
				0.02,
				0.2
			}
		}
		self.besiege.reenforce.interval = {
			10,
			20,
			30
		}
		self.besiege.reenforce.groups = {
			CS_defend_a = {
				1,
				0,
				0
			},
			CS_defend_b = {
				2,
				1,
				0
			},
			CS_defend_c = {
				0,
				0,
				1
			}
		}
		self.besiege.assault.delay = {
			35,
			25,
			20
		}
		self.besiege.recon.interval = {
			5,
			5,
			5
		}
		self.besiege.recon.interval_variation = 40
		self.besiege.recon.groups = {
			CS_stealth_a = {
				1,
				0,
				0
			},
			CS_swats = {
				0,
				1,
				1
			},
			CS_tazers = {
				0,
				0.1,
				0.15
			},
			FBI_stealth_b = {
				0,
				0,
				0.1
			}
		}
		self.besiege.recon.force = { 5, 5, 5 }
		self.besiege.reenforce.force = { 5, 5, 5 }
		self.besiege.assault.force = { 5, 5, 5 }
		self.besiege.assault.force_pool = { 50, 50, 50 }
		self.besiege.assault.force_balance_mul = { 2, 2, 2, 2 }
		self.besiege.assault.force_pool_balance_mul = { 2, 2, 2, 2 }
	end

	function GroupAITweakData:_set_overkill()
		self.max_nr_simultaneous_boss_types = 7
		
		self.besiege.assault.groups = {
			FBI_swats = {
				0.1,
				1,
				0.25
			},
			FBI_heavys = {
				0.05,
				0.4,
				0.5
			},
			FBI_shields = {
				0.1,
				0.2,
				1
			},
			FBI_spoocs = {
				0.1,
				0.2,
				1
			},
			FBI_tanks = {
				0.05,
				0.15,
				0.2
			},
			CS_tazers = {
				0.05,
				0.15,
				0.25
			}
		}
		self.besiege.reenforce.interval = {
			10,
			20,
			30
		}
		self.besiege.reenforce.groups = {
			CS_defend_a = {
				1,
				0,
				0
			},
			CS_defend_b = {
				2,
				1,
				0
			},
			CS_defend_c = {
				0,
				0,
				1
			},
			FBI_defend_a = {
				0,
				1,
				0
			},
			FBI_defend_b = {
				0,
				0,
				1
			}
		}
		self.besiege.assault.delay = {
			30,
			30,
			20
		}
		self.besiege.recon.interval = {
			5,
			5,
			5
		}
		self.besiege.recon.interval_variation = 30
		self.besiege.recon.groups = {
			FBI_spoocs = {
				0.5,
				0.5,
				0.5,
			},
			FBI_stealth_a = {
				1,
				0.5,
				0
			},
			FBI_stealth_b = {
				0,
				0,
				1
			}
		}
		self.besiege.recon.force = { 7, 7, 7 }
		self.besiege.reenforce.force = { 7, 7, 7 }
		self.besiege.assault.force = { 7, 7, 7 }
		self.besiege.assault.force_pool = { 70, 70, 70 }
		self.besiege.assault.force_balance_mul = { 3, 3, 3, 3 }
		self.besiege.assault.force_pool_balance_mul = { 3, 3, 3, 3 }
	end

	function GroupAITweakData:_set_overkill_145()
		self.max_nr_simultaneous_boss_types = 10
		
		self.besiege.assault.groups = {
			FBI_swats = {
				0.2,
				1,
				0
			},
			FBI_heavys = {
				0.1,
				1,
				1
			},
			FBI_shields = {
				0.1,
				0.5,
				0.75
			},
			FBI_spoocs = {
				0.1,
				0.4,
				1
			},
			FBI_tanks = {
				0.2,
				0.3,
				0.5
			},
			CS_tazers = {
				0.2,
				0.35,
				0.6
			}
		}
		self.besiege.reenforce.interval = {
			10,
			20,
			20
		}
		self.besiege.reenforce.groups = {
			CS_defend_a = {
				0.1,
				0,
				0
			},
			FBI_defend_b = {
				1,
				1,
				0
			},
			FBI_defend_c = {
				0,
				1,
				0
			},
			FBI_defend_d = {
				0,
				0,
				1
			}
		}
		self.besiege.assault.delay = {
			20,
			20,
			15
		}
		self.besiege.recon.interval = {
			5,
			5,
			5
		}
		self.besiege.recon.interval_variation = 30
		self.besiege.recon.groups = {
			FBI_spoocs = {
				0.5,
				0.5,
				0.5,
			},
			FBI_stealth_a = {
				1,
				1,
				0
			},
			FBI_stealth_b = {
				0.25,
				1,
				1
			}
		}
		self.besiege.recon.force = { 10, 10, 10 }
		self.besiege.reenforce.force = { 10, 10, 10 }
		self.besiege.assault.force = { 10, 10, 10 }
		self.besiege.assault.force_pool = { 100, 100, 100 }
		self.besiege.assault.force_balance_mul = { 4, 4, 4, 4 }
		self.besiege.assault.force_pool_balance_mul = { 4, 4, 4, 4 }
	end

end

-- make this into a toggle and call it smth like modified spawn scheduler
-- assaults can last shorter but you will be slowly overrun
if RequiredScript == "lib/managers/group_ai_states/groupaistatebesiege" then
	GroupAIStateBesiege._MAX_SIMULTANEOUS_SPAWNS = 5
	function GroupAIStateBesiege:_upd_assault_task()
		--log("_upd_assault_task()")
		local task_data = self._task_data.assault
		if not task_data.active then
			return
		end
		local t = self._t
		self:_assign_recon_groups_to_retire()
		local force_pool = self:_get_difficulty_dependent_value(tweak_data.group_ai.besiege.assault.force_pool) * self:_get_balancing_multiplier(tweak_data.group_ai.besiege.assault.force_pool_balance_mul)
		local task_spawn_allowance = force_pool - (self._hunt_mode and 0 or task_data.force_spawned)
		if task_data.phase == "anticipation" then
			if task_spawn_allowance <= 0 then
				task_data.phase = "fade"
				task_data.phase_end_t = 5
			elseif t > task_data.phase_end_t or self._drama_data.zone == "high" then
				managers.mission:call_global_event("start_assault")
				managers.hud:start_assault()
				self:_set_rescue_state(false)
				task_data.phase = "build"
				task_data.phase_end_t = self._t + tweak_data.group_ai.besiege.assault.build_duration
				task_data.is_hesitating = nil
				self:set_assault_mode(true)
				managers.trade:set_trade_countdown(false)
			else
				managers.hud:check_anticipation_voice(task_data.phase_end_t - t)
				managers.hud:check_start_anticipation_music(task_data.phase_end_t - t)
				if task_data.is_hesitating and self._t > task_data.voice_delay then
					if 0 < self._hostage_headcount then
						local best_group
						for _, group in pairs(self._groups) do
							if not best_group or group.objective.type == "reenforce_area" then
								best_group = group
							elseif best_group.objective.type ~= "reenforce_area" and group.objective.type ~= "retire" then
								best_group = group
							end
						end
						if best_group and self:_voice_delay_assault(best_group) then
							task_data.is_hesitating = nil
						end
					else
						task_data.is_hesitating = nil
					end
				end
			end
		elseif task_data.phase == "build" then
			if task_spawn_allowance <= 0 then
				task_data.phase = "fade"
				task_data.phase_end_t = 5
			elseif t > task_data.phase_end_t or self._drama_data.zone == "high" then
				task_data.phase = "sustain"
				task_data.phase_end_t = 180
			end
		elseif task_data.phase == "sustain" then
			if task_spawn_allowance <= 0 then
				task_data.phase = "fade"
				task_data.phase_end_t = 5
			elseif t > task_data.phase_end_t and not self._hunt_mode then
				task_data.phase = "fade"
				task_data.phase_end_t = 5
			end
		else
			local enemies_left = self:_count_police_force("assault")
			if enemies_left < 15 then
				if t > task_data.phase_end_t - 8 and not task_data.said_retreat then
					if self._drama_data.amount < tweak_data.drama.assault_fade_end then
						task_data.said_retreat = true
						self:_police_announce_retreat()
					end
				else
					--if t > task_data.phase_end_t and self._drama_data.amount < tweak_data.drama.assault_fade_end and self:_count_criminals_engaged_force(4) <= 3 then
						task_data.active = nil
						task_data.phase = nil
						task_data.said_retreat = nil
						if self._draw_drama then
							self._draw_drama.assault_hist[#self._draw_drama.assault_hist][2] = t
						end
						managers.mission:call_global_event("end_assault")
						self:_begin_regroup_task()
						return
					--else
					--end
				end
			end
		end
		if self._drama_data.amount <= tweak_data.drama.low then
			for criminal_key, criminal_data in pairs(self._player_criminals) do
				self:criminal_spotted(criminal_data.unit)
				for group_id, group in pairs(self._groups) do
					if group.objective.charge then
						for u_key, u_data in pairs(group.units) do
							u_data.unit:brain():clbk_group_member_attention_identified(nil, criminal_key)
						end
					end
				end
			end
		end
		local primary_target_area = task_data.target_areas[1]
		if self:is_area_safe(primary_target_area) then
			local target_pos = primary_target_area.pos
			local nearest_area, nearest_dis
			for criminal_key, criminal_data in pairs(self._player_criminals) do
				if not criminal_data.status then
					local dis = mvector3.distance_sq(target_pos, criminal_data.m_pos)
					if not nearest_dis or nearest_dis > dis then
						nearest_dis = dis
						nearest_area = self:get_area_from_nav_seg_id(criminal_data.tracker:nav_segment())
					end
				end
			end
			if nearest_area then
				primary_target_area = nearest_area
				task_data.target_areas[1] = nearest_area
			end
		end
		local nr_wanted = task_data.force - self:_count_police_force("assault")
		if task_data.phase == "anticipation" then
			nr_wanted = nr_wanted - 5
		end
		--log(nr_wanted)
		if 0 < nr_wanted and task_data.phase ~= "fade" then
			--[[local used_event
			if task_data.use_spawn_event and task_data.phase ~= "anticipation" then
				task_data.use_spawn_event = false
				if self:_try_use_task_spawn_event(t, primary_target_area, "assault") then
					used_event = true
				end
			end
			if used_event or next(self._spawning_groups) then
			else]]
				local spawn_group, spawn_group_type = self:_find_spawn_group_near_area(primary_target_area, nr_wanted, tweak_data.group_ai.besiege.assault.groups, nil, nil, nil)
				if spawn_group then
					local grp_objective = {
						type = "assault_area",
						area = spawn_group.area,
						coarse_path = {
							{
								spawn_group.area.pos_nav_seg,
								spawn_group.area.pos
							}
						},
						attitude = "avoid",
						pose = "crouch",
						stance = "cbt"
					}
					self:_spawn_in_group(spawn_group, spawn_group_type, grp_objective, task_data)
				end
			--end
		end
		if task_data.phase ~= "anticipation" then
			if t > task_data.use_smoke_timer then
				task_data.use_smoke = true
			end
			if self._smoke_grenade_queued and task_data.use_smoke and not self:is_smoke_grenade_active() then
				self:_detonate_smoke_grenade(self._smoke_grenade_queued[1], self._smoke_grenade_queued[1], self._smoke_grenade_queued[2], self._smoke_grenade_queued[4])
				if self._smoke_grenade_queued[3] then
					self._smoke_grenade_ignore_control = true
				end
			end
		end
		self:_assign_enemy_groups_to_assault(task_data.phase)
	end
end