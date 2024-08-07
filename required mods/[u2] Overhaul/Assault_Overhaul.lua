if RequiredScript == "lib/managers/mission/elementspecialobjective" then
	function ElementSpecialObjective:nav_link_delay()
		return 0.1
	end
end

if RequiredScript == "lib/tweak_data/groupaitweakdata" then
	--[[test?
	old_GroupAITweakData_init_task_data = GroupAITweakData._init_task_data
	function GroupAITweakData:_init_task_data(...)
		old_GroupAITweakData_init_task_data(self, ...)
		local is_console = SystemInfo:platform() ~= Idstring( "WIN32" )
		if is_console then
			self.besiege.assault.force = { 15, 20, 25 }		-- max simultaneous # pigs participating in assault
			self.besiege.assault.force_pool = { 0, 60, 100 }			-- max # pigs that may be spawned during the entire assault phase
		else
			self.besiege.assault.force = { 15, 20, 25 }				-- max simultaneous # pigs participating in assault	
			self.besiege.assault.force_pool = { 0, 60, 100 }			-- max # pigs that may be spawned during the entire assault phase
		end
	end]]

	function GroupAITweakData:_init_enemy_spawn_groups()
		-- CS
		local tactics_CS_cop = { "provide_coverfire", "provide_support", "ranged_fire" }
		local tactics_CS_cop_stealth = { "flank", "provide_coverfire", "provide_support" }
		
		local tactics_CS_swat_rifle = { "charge", "provide_coverfire", "provide_support", "ranged_fire" }
		local tactics_CS_swat_shotgun = { "charge", "provide_coverfire", "provide_support" }
		local tactics_CS_swat_heavy = { "charge", "provide_coverfire", "provide_support", "shield_cover" }
		local tactics_CS_shield = { "charge", "provide_coverfire", "provide_support", "shield" }
		
		local tactics_CS_swat_rifle_flank = { "flank", "charge", "provide_coverfire", "provide_support" }
		local tactics_CS_swat_shotgun_flank = { "flank", "charge", "provide_coverfire", "provide_support" }
		local tactics_CS_swat_heavy_flank = { "flank", "charge", "provide_coverfire", "provide_support", "shield_cover" }
		local tactics_CS_shield_flank = { "flank", "charge", "provide_coverfire", "provide_support", "shield" }
		
		local tactics_CS_tazer = { "flank", "charge", "provide_coverfire", "provide_support" }
		
		-- FBI
		local tactics_FBI_suit = { "provide_coverfire", "provide_support", "ranged_fire" }
		local tactics_FBI_suit_stealth = { "provide_coverfire", "provide_support" }
		
		local tactics_FBI_swat_rifle = { "charge", "provide_coverfire", "provide_support", "ranged_fire" }
		local tactics_FBI_swat_shotgun = { "charge", "provide_coverfire", "provide_support" }
		local tactics_FBI_heavy = { "charge", "provide_coverfire", "provide_support", "shield_cover" }
		local tactics_FBI_shield = { "charge", "provide_coverfire", "provide_support", "shield" }
		
		local tactics_FBI_swat_rifle_flank = { "flank", "charge", "provide_coverfire", "provide_support" }
		local tactics_FBI_swat_shotgun_flank = { "flank", "charge", "provide_coverfire", "provide_support" }
		local tactics_FBI_heavy_flank = { "flank", "charge", "provide_coverfire", "provide_support", "shield_cover" }
		local tactics_FBI_shield_flank = { "flank", "charge", "provide_coverfire", "provide_support", "shield" }
		
		local tactics_FBI_spooc = { "flank", "charge", "provide_coverfire" }
		local tactics_FBI_tank = { "charge", "provide_coverfire", "provide_support" }
		
	-- CS (COPS/SWAT)
		self.enemy_spawn_groups.CS_defend_a = {
			amount = { 3, 4 },
			spawn = {
				{ unit = "CS_cop_C45_R870", amount_min = 5, freq = 0.1, tactics = tactics_CS_cop, rank = 1 }
			}
		}
		self.enemy_spawn_groups.CS_defend_b = {
			amount = { 3, 4 },
			spawn = {
				{ unit = "CS_swat_MP5", freq = 0.1, amount_min = 5, tactics = tactics_CS_cop, rank = 1 }
			}
		}
		self.enemy_spawn_groups.CS_defend_c = {
			amount = { 3, 4 },
			spawn = {
				{ unit = "CS_heavy_M4", freq = 0.1, amount_min = 5, tactics = tactics_CS_cop, rank = 1 }
			}
		}
		
		-- Cops
		self.enemy_spawn_groups.CS_cops = {
			amount = { 3, 4 },
			spawn = {
				{ unit = "CS_cop_C45_R870", freq = 0.1, amount_min = 5, tactics = tactics_CS_cop, rank = 1 }
			}
		}
		self.enemy_spawn_groups.CS_stealth_a = {
			amount = { 2, 3 },
			spawn = {
				{ unit = "CS_cop_stealth_MP5", freq = 0.1, amount_min = 5, tactics = tactics_CS_cop_stealth, rank = 1 }
			}
		}
		-- CS Swats
		self.enemy_spawn_groups.CS_swats = {
			amount = { 3, 4 },
			spawn = {
				{ unit = "CS_swat_MP5", freq = 0.1, amount_min = 5, tactics = tactics_CS_swat_rifle, rank = 2 },
				{ unit = "CS_swat_R870", freq = 0.1, amount_min = 5, tactics = tactics_CS_swat_shotgun, rank = 1 },
				{ unit = "CS_swat_MP5", freq = 0.1, amount_min = 5, tactics = tactics_CS_swat_rifle_flank, rank = 3 },
			}
		}
		
		-- CS Heavys
		self.enemy_spawn_groups.CS_heavys = {
			amount = { 3, 4 },
			spawn = {
				{ unit = "CS_heavy_M4", freq = 0.1, amount_min = 5, tactics = tactics_CS_swat_rifle, rank = 1 },
				{ unit = "CS_heavy_M4", freq = 0.1, amount_min = 5, tactics = tactics_CS_swat_rifle_flank, rank = 2 },
			}
		}
		
		-- CS Shields
		self.enemy_spawn_groups.CS_shields = {
			amount = { 6, 8 },
			spawn = {
				{ unit = "CS_heavy_M4", 	freq = 0.1, amount_min = 3, tactics = tactics_CS_swat_rifle_flank,  rank = 6 },
				{ unit = "CS_swat_R870", 	freq = 0.1, amount_min = 3, tactics = tactics_CS_swat_shotgun, 	  rank = 5 },
				{ unit = "FBI_heavy_G36_w", freq = 0.1, amount_min = 3, tactics = tactics_FBI_heavy_flank, 	  rank = 4 },
				{ unit = "CS_shield", 		freq = 0.1, amount_min = 2, tactics = tactics_CS_shield, 			  rank = 2 },
				{ unit = "FBI_tank", 		freq = 0.1, amount_min = 1, tactics = tactics_FBI_tank, 			  rank = 1 },
				{ unit = "CS_tazer", 		freq = 0.1, amount_min = 1, tactics = tactics_CS_tazer, 			  rank = 3 }
			}
		}
		
		-- CS Tazers
		self.enemy_spawn_groups.CS_tazers = {
			amount = { 6, 8 },
			spawn = {
				{ unit = "CS_heavy_M4", 	freq = 0.1, amount_min = 3, tactics = tactics_CS_swat_rifle_flank,  rank = 6 },
				{ unit = "CS_swat_R870", 	freq = 0.1, amount_min = 3, tactics = tactics_CS_swat_shotgun, 	  rank = 5 },
				{ unit = "FBI_heavy_G36_w", freq = 0.1, amount_min = 3, tactics = tactics_FBI_heavy_flank, 	  rank = 4 },
				{ unit = "CS_shield", 		freq = 0.1, amount_min = 2, tactics = tactics_CS_shield, 			  rank = 2 },
				{ unit = "FBI_tank", 		freq = 0.1, amount_min = 1, tactics = tactics_FBI_tank, 			  rank = 1 },
				{ unit = "CS_tazer", 		freq = 0.1, amount_min = 1, tactics = tactics_CS_tazer, 			  rank = 3 }
			}
		}
		-- CS Tanks
		self.enemy_spawn_groups.CS_tanks = {
			amount = { 6, 8 },
			spawn = {
				{ unit = "CS_heavy_M4", 	freq = 0.1, amount_min = 3, tactics = tactics_CS_swat_rifle_flank,  rank = 6 },
				{ unit = "CS_swat_R870", 	freq = 0.1, amount_min = 3, tactics = tactics_CS_swat_shotgun, 	  rank = 5 },
				{ unit = "FBI_heavy_G36_w", freq = 0.1, amount_min = 3, tactics = tactics_FBI_heavy_flank, 	  rank = 4 },
				{ unit = "CS_shield", 		freq = 0.1, amount_min = 3, tactics = tactics_CS_shield, 			  rank = 2 },
				{ unit = "FBI_tank", 		freq = 0.1, amount_min = 1, tactics = tactics_FBI_tank, 			  rank = 1 },
				{ unit = "CS_tazer", 		freq = 0.1, amount_min = 2, tactics = tactics_CS_tazer, 			  rank = 3 }
			}
		}

		
	-- FBI
		-- FBI Defend
		self.enemy_spawn_groups.FBI_defend_a = {
			amount = { 3, 4 },
			spawn = {
				{ unit = "FBI_suit_C45_M4", freq = 0.1, amount_min = 5, tactics = tactics_FBI_suit, rank = 2 },
				{ unit = "CS_cop_C45_R870", freq = 0.1, amount_min = 5, tactics = tactics_FBI_suit, rank = 1 }
			}
		}
		self.enemy_spawn_groups.FBI_defend_b = {
			amount = { 3, 4 },
			spawn = {
				{ unit = "FBI_suit_M4_MP5", freq = 0.1, amount_min = 5, tactics = tactics_FBI_suit, rank = 2 },
				{ unit = "FBI_swat_M4", freq = 0.1, amount_min = 5, tactics = tactics_FBI_suit, rank = 1 }
			}
		}
		self.enemy_spawn_groups.FBI_defend_c = {
			amount = { 3, 4 },
			spawn = {
				{ unit = "FBI_swat_M4", freq = 0.1, amount_min = 5, tactics = tactics_FBI_suit, rank = 1 }
			}
		}
		self.enemy_spawn_groups.FBI_defend_d = {
			amount = { 3, 4 },
			spawn = {
				{ unit = "FBI_heavy_G36", freq = 0.1, amount_min = 5, tactics = tactics_FBI_suit, rank = 1 }
			}
		}
		
		-- FBI Stealth
		self.enemy_spawn_groups.FBI_stealth_a = {
			amount = { 2, 3 },
			spawn = {
				{ unit = "FBI_suit_stealth_MP5", freq = 0.1, amount_min = 5, tactics = tactics_FBI_suit_stealth, rank = 1 }
			}
		}
		self.enemy_spawn_groups.FBI_stealth_b = {
			amount = { 2, 4 },
			spawn = {
				{ unit = "FBI_suit_stealth_MP5", freq = 0.1, amount_min = 5, tactics = tactics_FBI_suit_stealth, rank = 1 }
				-- { unit = "FBI_spooc", freq = 0.1, amount_min = 1, tactics = tactics_FBI_suit_stealth, rank = 1 }
			}
		}
		
		-- FBI Swats
		self.enemy_spawn_groups.FBI_swats = {
			amount = { 3, 4 },
			spawn = {
				{ unit = "FBI_swat_M4", freq = 0.1, amount_min = 5, tactics = tactics_FBI_swat_rifle, rank = 2 },
				{ unit = "FBI_swat_M4", freq = 0.1, amount_min = 5, tactics = tactics_FBI_swat_rifle_flank, rank = 3 },
				{ unit = "FBI_swat_R870", freq = 0.1, amount_min = 5, tactics = tactics_FBI_swat_shotgun, rank = 1 }
			}
		}
		
		-- FBI Heavy
		self.enemy_spawn_groups.FBI_heavys = {
			amount = { 3, 4 },
			spawn = {
				{ unit = "FBI_heavy_G36", freq = 0.1, amount_min = 5, tactics = tactics_FBI_swat_rifle, rank = 1 },
				{ unit = "FBI_heavy_G36", freq = 0.1, amount_min = 5, tactics = tactics_FBI_swat_rifle_flank, rank = 2 }
			}
		}
		
		-- FBI Shields
		self.enemy_spawn_groups.FBI_shields = {
			amount = { 6, 8 },
			spawn = {
				{ unit = "FBI_swat_M4", 	freq = 0.1, amount_min = 3, tactics = tactics_FBI_swat_rifle_flank, rank = 6 },
				{ unit = "FBI_swat_R870", 	freq = 0.1, amount_min = 3, tactics = tactics_FBI_swat_shotgun, 	  rank = 5 },
				{ unit = "FBI_heavy_G36_w", freq = 0.1, amount_min = 3, tactics = tactics_FBI_heavy_flank, 	  rank = 4 },
				{ unit = "FBI_shield", 		freq = 0.1, amount_min = 3, tactics = tactics_FBI_shield_flank, 	  rank = 2 },
				{ unit = "FBI_tank", 		freq = 0.1, amount_min = 1, tactics = tactics_FBI_tank, 			  rank = 1 },
				{ unit = "CS_tazer", 		freq = 0.1, amount_min = 2, tactics = tactics_CS_tazer, 			  rank = 3 }
			}
		}
		
		-- FBI Spoocs
		self.enemy_spawn_groups.FBI_spoocs = {
			amount = { 2, 2 },
			spawn = {
				{ unit = "FBI_suit_stealth_MP5", freq = 0.1, amount_min = 5, tactics = tactics_FBI_suit_stealth, rank = 1 }
				-- { unit = "FBI_spooc", freq = 0.1, tactics = tactics_FBI_spooc, rank = 1 }
			}
		}
		
		-- FBI Tanks
		self.enemy_spawn_groups.FBI_tanks = {
			amount = { 6, 8 },
			spawn = {
				{ unit = "FBI_swat_M4", 	freq = 0.1, amount_min = 3, tactics = tactics_FBI_swat_rifle_flank, rank = 6 },
				{ unit = "FBI_swat_R870", 	freq = 0.1, amount_min = 3, tactics = tactics_FBI_swat_shotgun, 	  rank = 5 },
				{ unit = "FBI_heavy_G36_w", freq = 0.1, amount_min = 3, tactics = tactics_FBI_heavy_flank, 	  rank = 4 },
				{ unit = "FBI_shield", 		freq = 0.1, amount_min = 3, tactics = tactics_FBI_shield_flank, 	  rank = 2 },
				{ unit = "FBI_tank", 		freq = 0.1, amount_min = 1, tactics = tactics_FBI_tank, 			  rank = 1 },
				{ unit = "CS_tazer", 		freq = 0.1, amount_min = 2, tactics = tactics_CS_tazer, 			  rank = 3 }
			}
		}
	end
end