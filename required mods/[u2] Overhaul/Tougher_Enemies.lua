function CharacterTweakData:_init_swat( presets )
	math.randomseed( os.time() ) math.random() math.random() math.random()
	
	self.swat = deep_clone( presets.base )
	self.swat.experience = {}
	self.swat.weapon = presets.weapon.normal
	self.swat.detection = presets.detection.normal
	
-- HEALTH
	self.swat.HEALTH_INIT = math.random(14, 20)
	self.swat.headshot_dmg_mul = self.swat.HEALTH_INIT/2	-- damage multiplier on received headshots. nil means insta-death
	
	self.swat.move_speed = presets.move_speed.fast
	self.swat.surrender_break_time = { 6, 10 } -- How quickly does the character snap back to combat after surrendering. { min, max }. (sec)
	self.swat.suppression = presets.suppression.hard_def
	self.swat.surrender = presets.surrender.normal
	self.swat.ecm_vulnerability = 0.4 -- chance of puking when exposed to ecm feedback
	self.swat.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } } 					-- what type of hurts ecm feedback can inflict (puking, covering ears ect) and their durations
	self.swat.weapon_voice = "2"
	self.swat.experience.cable_tie = "tie_swat"
	self.swat.speech_prefix_p1 = "l"
	self.swat.speech_prefix_p2 = "n"
	self.swat.speech_prefix_count = 4
	self.swat.access = "swat"
	self.swat.dodge = presets.dodge.athletic
	self.swat.follower = true
	self.swat.no_arrest = true			-- The character will never attempt to arrest a criminal. He will fire instead
	self.swat.chatter = presets.enemy_chatter.swat
end

function CharacterTweakData:_init_heavy_swat( presets )
	math.randomseed( os.time() ) math.random() math.random() math.random()
	
	self.heavy_swat = deep_clone( presets.base )
	self.heavy_swat.experience = {}
	self.heavy_swat.weapon = presets.weapon.normal
	self.heavy_swat.detection = presets.detection.normal

-- HEALTH	
	self.heavy_swat.HEALTH_INIT = math.random(25, 35)
	self.heavy_swat.headshot_dmg_mul = self.heavy_swat.HEALTH_INIT/6	-- damage multiplier on received headshots. nil means insta-death
	
	self.heavy_swat.move_speed = presets.move_speed.fast
	self.heavy_swat.surrender_break_time = { 6, 8 } -- How quickly does the character snap back to combat after surrendering. { min, max }. (sec)
	self.heavy_swat.suppression = presets.suppression.hard_agg
	self.heavy_swat.surrender = presets.surrender.normal
	self.heavy_swat.ecm_vulnerability = 0.2 -- chance of puking when exposed to ecm feedback
	self.heavy_swat.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } } 					-- what type of hurts ecm feedback can inflict (puking, covering ears ect) and their durations
	self.heavy_swat.weapon_voice = "2"
	self.heavy_swat.experience.cable_tie = "tie_swat"
	self.heavy_swat.speech_prefix_p1 = "l"
	self.heavy_swat.speech_prefix_p2 = "n"
	self.heavy_swat.speech_prefix_count = 4
	self.heavy_swat.access = "swat"
	self.heavy_swat.dodge = presets.dodge.heavy
	self.heavy_swat.follower = true
	self.heavy_swat.no_arrest = true			-- The character will never attempt to arrest a criminal. He will fire instead
	self.heavy_swat.chatter = presets.enemy_chatter.swat
end

function CharacterTweakData:_init_fbi_swat( presets )
	math.randomseed( os.time() ) math.random() math.random() math.random()
	
	self.fbi_swat = deep_clone( presets.base )
	self.fbi_swat.experience = {}
	self.fbi_swat.weapon = presets.weapon.normal
	self.fbi_swat.detection = presets.detection.normal
	
-- HEALTH
	self.fbi_swat.HEALTH_INIT = math.random(18, 24)
	self.fbi_swat.headshot_dmg_mul = self.fbi_swat.HEALTH_INIT/4	-- damage multiplier on received headshots. nil means insta-death
	
	self.fbi_swat.move_speed = presets.move_speed.very_fast
	self.fbi_swat.surrender_break_time = { 6, 10 } -- How quickly does the character snap back to combat after surrendering. { min, max }. (sec)
	self.fbi_swat.suppression = presets.suppression.hard_def
	self.fbi_swat.surrender = presets.surrender.normal
	self.fbi_swat.ecm_vulnerability = 0.4 -- chance of puking when exposed to ecm feedback
	self.fbi_swat.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } } 					-- what type of hurts ecm feedback can inflict (puking, covering ears ect) and their durations
	self.fbi_swat.weapon_voice = "2"
	self.fbi_swat.experience.cable_tie = "tie_swat"
	self.fbi_swat.speech_prefix_p1 = "l"
	self.fbi_swat.speech_prefix_p2 = "n"
	self.fbi_swat.speech_prefix_count = 4
	self.fbi_swat.access = "swat"
	self.fbi_swat.dodge = presets.dodge.athletic
	self.fbi_swat.follower = true
	self.fbi_swat.no_arrest = true			-- The character will never attempt to arrest a criminal. He will fire instead
	self.fbi_swat.chatter = presets.enemy_chatter.swat
end

function CharacterTweakData:_init_fbi_heavy_swat( presets )
	math.randomseed( os.time() ) math.random() math.random() math.random()
	
	self.fbi_heavy_swat = deep_clone( presets.base )
	self.fbi_heavy_swat.experience = {}
	self.fbi_heavy_swat.weapon = presets.weapon.normal
	self.fbi_heavy_swat.detection = presets.detection.normal
	
-- HEALTH
	self.fbi_heavy_swat.HEALTH_INIT = math.random(28, 38)
	self.fbi_heavy_swat.headshot_dmg_mul = self.fbi_heavy_swat.HEALTH_INIT/10	-- damage multiplier on received headshots. nil means insta-death
	
	self.fbi_heavy_swat.move_speed = presets.move_speed.fast
	self.fbi_heavy_swat.surrender_break_time = { 6, 8 } -- How quickly does the character snap back to combat after surrendering. { min, max }. (sec)
	self.fbi_heavy_swat.suppression = presets.suppression.hard_agg
	self.fbi_heavy_swat.surrender = presets.surrender.normal
	self.fbi_heavy_swat.ecm_vulnerability = 0.2 -- chance of puking when exposed to ecm feedback
	self.fbi_heavy_swat.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } }  -- what type of hurts ecm feedback can inflict (puking, covering ears ect) and their durations
	self.fbi_heavy_swat.weapon_voice = "2"
	self.fbi_heavy_swat.experience.cable_tie = "tie_swat"
	self.fbi_heavy_swat.speech_prefix_p1 = "l"
	self.fbi_heavy_swat.speech_prefix_p2 = "n"
	self.fbi_heavy_swat.speech_prefix_count = 4
	self.fbi_heavy_swat.access = "swat"
	self.fbi_heavy_swat.dodge = presets.dodge.heavy
	self.fbi_heavy_swat.follower = true
	self.fbi_heavy_swat.no_arrest = true			-- The character will never attempt to arrest a criminal. He will fire instead
	self.fbi_heavy_swat.chatter = presets.enemy_chatter.swat
end

function CharacterTweakData:_init_sniper( presets )
	math.randomseed( os.time() ) math.random() math.random() math.random()
	
	self.sniper = deep_clone( presets.base )
	self.sniper.experience = {}
	self.sniper.weapon = presets.weapon.sniper
	self.sniper.detection = presets.detection.sniper

-- HEALTH
	self.sniper.HEALTH_INIT = math.random(4, 6)
	self.sniper.headshot_dmg_mul = self.sniper.HEALTH_INIT/2	-- damage multiplier on received headshots. nil means insta-death
	
	self.sniper.move_speed = presets.move_speed.normal
	self.sniper.shooting_death = false		-- The character will sometimes empty his magazine spraying random when killed
	--self.sniper.surrender_break_time = { 10, 20 } -- How quickly does the character snap back to combat after surrendering. { min, max }. (sec)
	self.sniper.suppression = presets.suppression.easy
	--self.sniper.surrender = presets.surrender.normal
	self.sniper.ecm_vulnerability = 0.5 -- chance of puking when exposed to ecm feedback
	self.sniper.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } } 					-- what type of hurts ecm feedback can inflict (puking, covering ears ect) and their durations
	self.sniper.weapon_voice = "1"
	self.sniper.experience.cable_tie = "tie_swat"
	self.sniper.speech_prefix_p1 = "l"
	self.sniper.speech_prefix_p2 = "n"
	self.sniper.speech_prefix_count = 4
	self.sniper.priority_shout = "f34"
	self.sniper.access = "sniper"
	self.sniper.no_retreat = true
	self.sniper.no_arrest = true			-- The character will never attempt to arrest a criminal. He will fire instead
	self.sniper.chatter = presets.enemy_chatter.no_chatter
end

function CharacterTweakData:_init_tank( presets )
	math.randomseed( os.time() ) math.random() math.random() math.random()
	
	self.tank = deep_clone( presets.base )
	self.tank.experience = {}
	
	self.tank.weapon = deep_clone( presets.weapon.expert )
	self.tank.weapon.r870.FALLOFF[1].dmg_mul = 6
	self.tank.weapon.r870.FALLOFF[2].dmg_mul = 4
	self.tank.weapon.r870.FALLOFF[3].dmg_mul = 2
	self.tank.weapon.r870.RELOAD_SPEED = 1
	
	self.tank.detection = presets.detection.normal
	
-- HEALTH
	self.tank.HEALTH_INIT = math.random(180, 220)
	self.tank.headshot_dmg_mul = self.tank.HEALTH_INIT/24	-- damage multiplier on received headshots. nil means insta-death
	
	self.tank.move_speed = presets.move_speed.slow
	self.tank.allowed_stances = { cbt = true }
	self.tank.allowed_poses = { stand = true }
	self.tank.crouch_move = false
	self.tank.allow_crouch = false
	self.tank.no_run_start = true
	self.tank.no_run_stop = true
	self.tank.no_retreat = true		-- The character will never retreat regardless of health ratio
	self.tank.no_arrest = true			-- The character will never attempt to arrest a criminal. He will fire instead
	self.tank.surrender = nil
	self.tank.ecm_vulnerability = 0.1 -- chance of puking when exposed to ecm feedback
	self.tank.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } } 					-- what type of hurts ecm feedback can inflict (puking, covering ears ect) and their durations
	self.tank.weapon_voice = "3"
	self.tank.experience.cable_tie = "tie_swat"
	self.tank.access = "tank"
	self.tank.speech_prefix_p1 = "bdz"
	self.tank.speech_prefix_p2 = nil
	self.tank.speech_prefix_count = nil
	self.tank.priority_shout = "f30"
	self.tank.rescue_hostages = false
	
	self.tank.damage.hurt_severity = presets.hurt_severities.only_light_hurt
	self.tank.chatter = presets.enemy_chatter.no_chatter
	self.tank.announce_incomming = "incomming_tank"	-- swats will anounce the arrival of this unit
end

function CharacterTweakData:_init_spooc( presets )
	math.randomseed( os.time() ) math.random() math.random() math.random()
	
	self.spooc = deep_clone( presets.base )
	self.spooc.experience = {}
	self.spooc.weapon = deep_clone( presets.weapon.normal )
	self.spooc.detection = presets.detection.normal
	
-- HEALTH
	self.spooc.HEALTH_INIT = math.random(20, 28)
	self.spooc.headshot_dmg_mul = self.spooc.HEALTH_INIT/6	-- damage multiplier on received headshots. nil means insta-death
	
	self.spooc.move_speed = presets.move_speed.lightning
	self.spooc.SPEED_SPRINT = 670		-- max sprint velocity. Used in spooc attack. (cm/sec)
	self.spooc.no_retreat = true		-- The character will never retreat regardless of health ratio
	self.spooc.no_arrest = true
	self.spooc.damage.hurt_severity = presets.hurt_severities.no_hurts
	self.spooc.surrender_break_time = { 4, 6 } -- How quickly does the character snap back to combat after surrendering. { min, max }. (sec)
	self.spooc.suppression = nil -- presets.suppression.no_supress
	self.spooc.surrender = presets.surrender.special
	self.spooc.ecm_vulnerability = 0.15 -- chance of puking when exposed to ecm feedback
	self.spooc.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } } 					-- what type of hurts ecm feedback can inflict (puking, covering ears ect) and their durations
	self.spooc.priority_shout = "f33"
	self.spooc.rescue_hostages = false
	
-- TODO : How to we solve this without to much reduntant code
	self.spooc.weapon.beretta92.choice_chance = 0
	self.spooc.weapon.m4.choice_chance = 1
	self.spooc.weapon.r870.choice_chance = 0
	self.spooc.weapon.mp5.choice_chance = 1
	self.spooc.weapon_voice = "3"
	
	self.spooc.experience.cable_tie = "tie_swat"
	self.spooc.speech_prefix_p1 = "l"
	self.spooc.speech_prefix_p2 = "n"
	self.spooc.speech_prefix_count = 4
	self.spooc.access = "spooc"
	
	self.spooc.dodge = presets.dodge.ninja
	
	self.spooc.follower = true
	self.spooc.chatter = presets.enemy_chatter.no_chatter
	self.spooc.announce_incomming = "incomming_spooc"	-- swats will anounce the arrival of this unit
end
	
function CharacterTweakData:_init_shield( presets )
	math.randomseed( os.time() ) math.random() math.random() math.random()
	
	self.shield = deep_clone( presets.base )
	self.shield.experience = {}
	self.shield.weapon = deep_clone( presets.weapon.normal )
	self.shield.detection = presets.detection.normal
	
-- HEALTH
	self.shield.HEALTH_INIT = math.random(18, 25)
	self.shield.headshot_dmg_mul = self.shield.HEALTH_INIT/6	-- damage multiplier on received headshots. nil means insta-death
	
	self.shield.allowed_stances = { cbt = true }
	self.shield.allowed_poses = { crouch = true }
	self.shield.move_speed = presets.move_speed.fast
	self.shield.no_run_start = true
	self.shield.no_run_stop = true
	self.shield.no_retreat = true		-- The character will never retreat regardless of health ratio
	self.shield.no_stand = true			-- The unit may not be in standing pose
	self.shield.no_arrest = true		-- The character will never attempt to arrest a criminal. He will fire instead
	self.shield.surrender = nil
	self.shield.ecm_vulnerability = 0.4 -- chance of puking when exposed to ecm feedback
	self.shield.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } } 					-- what type of hurts ecm feedback can inflict (puking, covering ears ect) and their durations
	self.shield.priority_shout = "f31"
	self.shield.rescue_hostages = false
	self.shield.deathguard = true
	self.shield.no_equip_anim = true
	self.shield.wall_fwd_offset = 100				-- leave space at the front when in cover
	
	self.shield.damage.hurt_severity = presets.hurt_severities.no_hurts
	self.shield.damage.shield_knocked = true
	
	self.shield.weapon.mp9 = {}
	self.shield.weapon.mp9.choice_chance = 1
	self.shield.weapon.mp9.aim_delay = { 0, 0.3 }
	self.shield.weapon.mp9.focus_delay = 6
	self.shield.weapon.mp9.focus_dis = 250
	self.shield.weapon.mp9.spread = 60
	self.shield.weapon.mp9.miss_dis = 15
	self.shield.weapon.mp9.RELOAD_SPEED = 2
	self.shield.weapon.mp9.melee_speed = nil
	self.shield.weapon.mp9.melee_dmg = nil
	self.shield.weapon.mp9.range = { close = 500, optimal = 700, far = 1200 }
	
	self.shield.weapon.mp9.FALLOFF = {
		{ r=0, acc={0.1, 0.6}, dmg_mul=4, recoil={0.35,0.55}, mode={ 0.2, 2, 4, 10 } },
		{ r=700, acc={0.1, 0.6}, dmg_mul=1, recoil={0.35,0.55}, mode={ 0.2, 2, 4, 10 } },
		{ r=1000, acc={0.1, 0.4}, dmg_mul=1, recoil={0.35,0.55}, mode={ 0.2, 2, 4, 10 } },
		{ r=2000, acc={0.1, 0.25}, dmg_mul=1, recoil={0.35,0.55}, mode={ 2, 5, 6, 4 } },
		{ r=10000, acc={0.1, 0.25}, dmg_mul=1, recoil={0.35,0.55}, mode={ 6, 4, 2, 1 } }
	}
	
	self.shield.weapon.c45 = {}
	self.shield.weapon.c45.choice_chance = 1
	self.shield.weapon.c45.aim_delay = { 0, 0.3 }
	self.shield.weapon.c45.focus_delay = 6
	self.shield.weapon.c45.focus_dis = 250
	self.shield.weapon.c45.spread = 60
	self.shield.weapon.c45.miss_dis = 15
	self.shield.weapon.c45.RELOAD_SPEED = 2
	self.shield.weapon.c45.melee_speed = nil
	self.shield.weapon.c45.melee_dmg = nil
	self.shield.weapon.c45.range = { close = 500, optimal = 700, far = 1200 }
	
	self.shield.weapon.c45.FALLOFF = {
		{ r=0, acc={0.1, 0.6}, dmg_mul=4, recoil={0.35,0.55}, mode={ 1, 0, 0, 0 } },
		{ r=700, acc={0.1, 0.6}, dmg_mul=1, recoil={0.35,0.55}, mode={ 1, 0, 0, 0 } },
		{ r=1000, acc={0.1, 0.4}, dmg_mul=1, recoil={0.35,0.55}, mode={ 1, 0, 0, 0 } },
		{ r=2000, acc={0.05, 0.2}, dmg_mul=1, recoil={0.35,0.55}, mode={ 1, 0, 0, 0 } },
		{ r=10000, acc={0, 0.15}, dmg_mul=1, recoil={0.35,0.55}, mode={ 1, 0, 0, 0 } }
	}
	
	self:_process_weapon_usage_table( self.shield.weapon )
	
	self.shield.weapon_voice = "3"
	self.shield.experience.cable_tie = "tie_swat"
	self.shield.speech_prefix_p1 = "l"
	self.shield.speech_prefix_p2 = "n"
	self.shield.speech_prefix_count = 4
	self.shield.access = "shield"
	self.shield.chatter = presets.enemy_chatter.shield
	self.shield.announce_incomming = "incomming_shield"	-- swats will anounce the arrival of this unit
end

function CharacterTweakData:_init_taser( presets )
	math.randomseed( os.time() ) math.random() math.random() math.random()
	
	self.taser = deep_clone( presets.base )
	
	self.taser.experience = {}
	
	self.taser.weapon = deep_clone( presets.weapon.normal )
	self.taser.weapon.m4.tase_distance = 1200
	self.taser.weapon.m4.aim_delay_tase = { 0, 0.1 }
	
	self.taser.detection = presets.detection.normal
	
-- HEALTH
	self.taser.HEALTH_INIT = math.random(45, 60)
	self.taser.headshot_dmg_mul = self.taser.HEALTH_INIT/8	-- damage multiplier on received headshots. nil means insta-death
	
	self.taser.move_speed = presets.move_speed.fast
	self.taser.no_retreat = true		-- The character will never retreat regardless of health ratio
	self.taser.no_arrest = true			-- The character will never attempt to arrest a criminal. He will fire instead
	self.taser.surrender = presets.surrender.normal
	self.taser.ecm_vulnerability = 0.1 -- chance of puking when exposed to ecm feedback
	self.taser.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } } 					-- what type of hurts ecm feedback can inflict (puking, covering ears ect) and their durations
	self.taser.surrender_break_time = { 4, 6 } -- How quickly does the character snap back to combat after surrendering. { min, max }. (sec)
	self.taser.suppression = nil -- presets.suppression.no_supress
	self.taser.damage.hurt_severity = presets.hurt_severities.only_light_hurt
	self.taser.weapon_voice = "3"
	self.taser.experience.cable_tie = "tie_swat"
	self.taser.speech_prefix_p1 = "l"
	self.taser.speech_prefix_p2 = "n"
	self.taser.speech_prefix_count = 4
	self.taser.access = "taser"
	self.taser.dodge = presets.dodge.heavy
	self.taser.priority_shout = "f32"
	self.taser.rescue_hostages = false
	self.taser.follower = true
	self.taser.chatter = presets.enemy_chatter.no_chatter
	self.taser.announce_incomming = "incomming_taser"	-- swats will anounce the arrival of this unit
end