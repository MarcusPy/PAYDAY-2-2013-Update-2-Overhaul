if RequiredScript == "lib/managers/mission/elementspecialobjective" then
    function ElementSpecialObjective:nav_link_delay()
        return 0.1
    end
end

if RequiredScript == "lib/tweak_data/groupaitweakdata" then
	-- enables spoocs to spawn, since initially their spawn groups didn't include them
    function GroupAITweakData:_init_enemy_spawn_groups()
        local tactics_CS_cop = { "provide_coverfire", "provide_support", "ranged_fire" }
        local tactics_CS_cop_stealth = { "flank", "provide_coverfire", "provide_support" }
        local tactics_CS_swat_rifle = { "smoke_grenade", "charge", "provide_coverfire", "provide_support", "ranged_fire" }
        local tactics_CS_swat_shotgun = { "smoke_grenade", "charge", "provide_coverfire", "provide_support" }
        local tactics_CS_swat_heavy = { "smoke_grenade", "charge", "provide_coverfire", "provide_support", "shield_cover" }
        local tactics_CS_shield = { "charge", "provide_coverfire", "provide_support", "shield" }
        local tactics_CS_swat_rifle_flank = { "flank", "flash_grenade", "smoke_grenade", "charge", "provide_coverfire", "provide_support" }
        local tactics_CS_swat_shotgun_flank = { "flank", "flash_grenade", "smoke_grenade", "charge", "provide_coverfire", "provide_support" }
        local tactics_CS_swat_heavy_flank = { "flank", "flash_grenade", "smoke_grenade", "charge", "provide_coverfire", "provide_support", "shield_cover" }
        local tactics_CS_shield_flank = { "flank", "charge", "flash_grenade", "provide_coverfire", "provide_support", "shield" }
        local tactics_CS_tazer = { "flank", "charge", "flash_grenade", "provide_coverfire", "provide_support" }
        local tactics_FBI_suit = { "provide_coverfire", "provide_support", "ranged_fire" }
        local tactics_FBI_suit_stealth = { "provide_coverfire", "provide_support" }
        local tactics_FBI_swat_rifle = { "smoke_grenade", "charge", "provide_coverfire", "provide_support", "ranged_fire" }
        local tactics_FBI_swat_shotgun = { "smoke_grenade", "charge", "provide_coverfire", "provide_support" }
        local tactics_FBI_heavy = { "smoke_grenade", "charge", "provide_coverfire", "provide_support", "shield_cover" }
        local tactics_FBI_shield = { "smoke_grenade", "charge", "provide_coverfire", "provide_support", "shield" }
        local tactics_FBI_swat_rifle_flank = { "flank", "smoke_grenade", "flash_grenade", "charge", "provide_coverfire", "provide_support" }
        local tactics_FBI_swat_shotgun_flank = { "flank", "smoke_grenade", "flash_grenade", "charge", "provide_coverfire", "provide_support" }
        local tactics_FBI_heavy_flank = { "flank", "smoke_grenade", "flash_grenade", "charge", "provide_coverfire", "provide_support", "shield_cover" }
        local tactics_FBI_shield_flank = { "flank", "smoke_grenade", "flash_grenade", "charge", "provide_coverfire", "provide_support", "shield" }
        local tactics_FBI_spooc = { "flank", "smoke_grenade", "flash_grenade", "charge", "provide_coverfire" }
        local tactics_FBI_tank = { "charge", "provide_coverfire", "provide_support" }
        

        self.enemy_spawn_groups.CS_defend_a = {
            amount = { 3, 4 },
            spawn = {
                { unit = "CS_cop_C45_R870", freq = 1, tactics = tactics_CS_cop, rank = 1 }
            }
        }
        
        self.enemy_spawn_groups.CS_defend_b = {
            amount = { 3, 4 },
            spawn = {
                { unit = "CS_swat_MP5", freq = 1, amount_min = 1, tactics = tactics_CS_cop, rank = 1 }
            }
        }
        
        self.enemy_spawn_groups.CS_defend_c = {
            amount = { 3, 4 },
            spawn = {
                { unit = "CS_heavy_M4", freq = 1, amount_min = 1, tactics = tactics_CS_cop, rank = 1 }
            }
        }
        
        self.enemy_spawn_groups.CS_cops = {
            amount = { 3, 4 },
            spawn = {
                { unit = "CS_cop_C45_R870", freq = 1, amount_min = 1, tactics = tactics_CS_cop, rank = 1 }
            }
        }
        
        self.enemy_spawn_groups.CS_stealth_a = {
            amount = { 2, 3 },
            spawn = {
                { unit = "CS_cop_stealth_MP5", freq = 1, amount_min = 1, tactics = tactics_CS_cop_stealth, rank = 1 }
            }
        }
        
        self.enemy_spawn_groups.CS_swats = {
            amount = { 3, 4 },
            spawn = {
                { unit = "CS_swat_MP5", freq = 1, tactics = tactics_CS_swat_rifle, rank = 2 },
                { unit = "CS_swat_R870", freq = 0.4, amount_max = 2, tactics = tactics_CS_swat_shotgun, rank = 1 },
                { unit = "CS_swat_MP5", freq = 0.2, tactics = tactics_CS_swat_rifle_flank, rank = 3 },
            }
        }
        
        self.enemy_spawn_groups.CS_heavys = {
            amount = { 3, 4 },
            spawn = {
                { unit = "CS_heavy_M4", freq = 1, tactics = tactics_CS_swat_rifle, rank = 1 },
                { unit = "CS_heavy_M4", freq = 0.35, tactics = tactics_CS_swat_rifle_flank, rank = 2 },
            }
        }
        
        self.enemy_spawn_groups.CS_shields = {
            amount = { 3, 4 },
            spawn = {
                { unit = "CS_shield", freq = 1, amount_min = 1, amount_max = 1, tactics = tactics_CS_shield, rank = 3 },
                { unit = "CS_shield", freq = 0.1, amount_max = 1, tactics = tactics_CS_shield, rank = 2 },
                { unit = "CS_heavy_M4_w", freq = 1, amount_min = 1, tactics = tactics_CS_swat_heavy, rank = 1 }
            }
        }
        
        self.enemy_spawn_groups.CS_tazers = {
            amount = { 2, 2 },
            spawn = {
                { unit = "CS_tazer", freq = 1, amount_min = 2, amount_max = 2, tactics = tactics_CS_tazer, rank = 1 },
                { unit = "CS_heavy_M4", freq = 1, tactics = tactics_CS_tazer, rank = 2 }
            }
        }
        
        self.enemy_spawn_groups.CS_tanks = {
            amount = { 1, 1 },
            spawn = {
                { unit = "FBI_tank", freq = 1, tactics = tactics_FBI_tank, rank = 1 }
            }
        }
        
        self.enemy_spawn_groups.FBI_defend_a = {
            amount = { 3, 4 },
            spawn = {
                { unit = "FBI_suit_C45_M4", freq = 1, amount_min = 1, tactics = tactics_FBI_suit, rank = 2 },
                { unit = "CS_cop_C45_R870", freq = 1, tactics = tactics_FBI_suit, rank = 1 }
            }
        }
        
        self.enemy_spawn_groups.FBI_defend_b = {
            amount = { 3, 4 },
            spawn = {
                { unit = "FBI_suit_M4_MP5", freq = 1, amount_min = 1, tactics = tactics_FBI_suit, rank = 2 },
                { unit = "FBI_swat_M4", freq = 1, tactics = tactics_FBI_suit, rank = 1 }
            }
        }
        
        self.enemy_spawn_groups.FBI_defend_c = {
            amount = { 3, 4 },
            spawn = {
                { unit = "FBI_swat_M4", freq = 1, tactics = tactics_FBI_suit, rank = 1 }
            }
        }
        
        self.enemy_spawn_groups.FBI_defend_d = {
            amount = { 3, 4 },
            spawn = {
                { unit = "FBI_heavy_G36", freq = 1, tactics = tactics_FBI_suit, rank = 1 }
            }
        }
        
        self.enemy_spawn_groups.FBI_stealth_a = {
            amount = { 2, 3 },
            spawn = {
                { unit = "FBI_suit_stealth_MP5", freq = 1, amount_min = 1, tactics = tactics_FBI_suit_stealth, rank = 1 }
            }
        }
        
        self.enemy_spawn_groups.FBI_stealth_b = {
            amount = { 2, 4 },
            spawn = {
                { unit = "FBI_suit_stealth_MP5", freq = 1, amount_min = 1, tactics = tactics_FBI_suit_stealth, rank = 1 },
                { unit = "FBI_spooc", freq = 1, amount_min = 1, tactics = tactics_FBI_suit_stealth, rank = 2 }
            }
        }
        
        self.enemy_spawn_groups.FBI_swats = {
            amount = { 3, 4 },
            spawn = {
                { unit = "FBI_swat_M4", freq = 1, amount_min = 1, tactics = tactics_FBI_swat_rifle, rank = 2 },
                { unit = "FBI_swat_M4", freq = 0.75, tactics = tactics_FBI_swat_rifle_flank, rank = 3 },
                { unit = "FBI_swat_R870", freq = 0.5, amount_max = 2, tactics = tactics_FBI_swat_shotgun, rank = 1 }
            }
        }
        
        self.enemy_spawn_groups.FBI_heavys = {
            amount = { 3, 4 },
            spawn = {
                { unit = "FBI_heavy_G36", freq = 1, tactics = tactics_FBI_swat_rifle, rank = 1 },
                { unit = "FBI_heavy_G36", freq = 0.5, tactics = tactics_FBI_swat_rifle_flank, rank = 2 }
            }
        }
        
        self.enemy_spawn_groups.FBI_shields = {
            amount = { 3, 4 },
            spawn = {
                { unit = "FBI_shield", freq = 0.3, amount_min = 1, amount_max = 2, tactics = tactics_FBI_shield_flank, rank = 3 },
                { unit = "FBI_heavy_G36_w", freq = 1, amount_min = 1, tactics = tactics_FBI_heavy_flank, rank = 1 }
            }
        }
        
        self.enemy_spawn_groups.FBI_spoocs = {
            amount = { 2, 2 },
            spawn = {
                { unit = "FBI_suit_stealth_MP5", freq = 1, amount_min = 1, tactics = tactics_FBI_suit_stealth, rank = 1 },
                { unit = "FBI_spooc", freq = 1, tactics = tactics_FBI_spooc, rank = 2 }
            }
        }
        
        self.enemy_spawn_groups.FBI_tanks = {
            amount = { 1, 2 },
            spawn = {
                { unit = "FBI_tank", freq = 1, tactics = tactics_FBI_tank, rank = 1 }
            }
        }
    end

	-- forces difficulty scaling to around max, rather than adjusting it based on the number of players
    function GroupAITweakData:_init_task_data()
        local is_console = SystemInfo:platform() ~= Idstring("WIN32")
        
        self.max_nr_simultaneous_boss_types = 0 
        self.difficulty_curve_points = { 0.5 }
        self.optimal_trade_distance = { 0, 0 }
        self.bain_assault_praise_limits = { 1, 3 }
        
        self.besiege = {
            regroup = { duration = { 15, 15, 15 } },
            assault = {
                anticipation_duration = { { 30, 1 }, { 30, 1 }, { 45, 0.5 } },
                build_duration = 35,
                sustain_duration_min = { 0, 80, 120 },
                sustain_duration_max = { 0, 80, 120 },
                sustain_duration_balance_mul = { 1, 1, 1, 1 },
                fade_duration = 5,
                delay = { 80, 70, 30 },
                hostage_hesitation_delay = { 30, 30, 30 },
                force = { 3, 5, 7 },
                force_pool = { 5, 25, 50 },
                force_balance_mul = { 1, 1.5, 2, 2.25 },
                force_pool_balance_mul = { 1, 1.5, 2, 3 },
                groups = {
                    CS_swats = { 0, 1, 0.7 },
                    CS_heavys = { 0, 0, 0.5 },
                    CS_shields = { 0, 0, 0.1 },
                }
            },
            reenforce = {
                interval = { 10, 20, 30 },
                groups = {
                    CS_defend_a = { 1, 0.2, 0 },
                    CS_defend_b = { 0, 1, 1 },
                }
            },
            recon = {
                interval = { 5, 5, 5 },
                force = { 2, 4, 6 },
                interval_variation = 40,
                groups = {
                    CS_stealth_a = { 1, 1, 0 },
                    CS_swats = { 0, 1, 1 },
                }
            }
        }
    end

    function GroupAITweakData:_set_hard()
        self.max_nr_simultaneous_boss_types = 1

        self.besiege.assault.groups = {
            CS_swats = { 0, 1, 0 },
            CS_heavys = { 0, 0.2, 1 },
            CS_shields = { 0, 0.02, 1 },
            CS_tazers = { 0, 0.01, 0.2 },
            CS_tanks = { 0, 0.01, 0.1 },
            FBI_spoocs = { 0, 0, 0.05 },
        }

        self.besiege.reenforce.groups = {
            CS_defend_a = { 1, 0, 0 },
            CS_defend_b = { 2, 1, 0 },
            CS_defend_c = { 0, 0, 1 },
        }

        self.besiege.assault.delay = { 30, 30, 30 }
        self.besiege.recon.groups = {
            CS_stealth_a = { 1, 0, 0 },
            CS_swats = { 0, 1, 1 },
            CS_tazers = { 0, 0, 0.2 },
            FBI_stealth_b = { 0, 0, 0.1 },
        }

        self.besiege.assault.force_balance_mul = { 1.5, 1.5, 1.5, 1.5 }
        self.besiege.assault.force_pool_balance_mul = { 1.5, 1.5, 1.5, 1.5 }
    end

    function GroupAITweakData:_set_overkill()
        self.max_nr_simultaneous_boss_types = 2

        self.besiege.assault.groups = {
            FBI_swats = { 0, 1, 0.25 },
            FBI_heavys = { 0, 0.2, 1 },
            FBI_shields = { 0, 0.2, 1 },
            FBI_tanks = { 0, 0.01, 0.05 },
            FBI_spooc = { 0, 0.1, 0.3 },
            CS_tazers = { 0, 0.1, 0.2 },
        }

        self.besiege.reenforce.groups = {
            CS_defend_a = { 1, 0, 0 },
            CS_defend_b = { 2, 1, 0 },
            CS_defend_c = { 0, 0, 1 },
            FBI_defend_a = { 0, 1, 0 },
            FBI_defend_b = { 0, 0, 1 },
        }

        self.besiege.assault.delay = { 25, 25, 25 }
        self.besiege.recon.groups = {
            FBI_stealth_a = { 1, 1, 0 },
            FBI_stealth_b = { 0, 0, 1 },
        }

        self.besiege.assault.force_balance_mul = { 2, 2, 2, 2 }
        self.besiege.assault.force_pool_balance_mul = { 2, 2, 2, 2 }
    end

    function GroupAITweakData:_set_overkill_145()
        self.max_nr_simultaneous_boss_types = 3

        self.besiege.assault.groups = {
            FBI_swats = { 0, 1, 0 },
            FBI_heavys = { 0, 1, 1 },
            FBI_shields = { 0, 0.5, 1 },
            FBI_tanks = { 0, 0.1, 0.1 },
            FBI_spooc = { 0, 0.2, 0.4 },
            CS_tazers = { 0, 0.1, 0.2 },
        }

        self.besiege.reenforce.groups = {
            CS_defend_a = { 0.1, 0, 0 },
            FBI_defend_b = { 1, 1, 0 },
            FBI_defend_c = { 0, 1, 0 },
            FBI_defend_d = { 0, 0, 1 },
        }

        self.besiege.assault.delay = { 20, 20, 20 }
        self.besiege.recon.groups = {
            FBI_stealth_a = { 1, 0.5, 0 },
            FBI_stealth_b = { 0, 1, 1 },
        }

        self.besiege.assault.force_balance_mul = { 2.5, 2.5, 2.5, 2.5 }
        self.besiege.assault.force_pool_balance_mul = { 2.5, 2.5, 2.5, 2.5 }
    end
end