if RequiredScript == "lib/tweak_data/charactertweakdata" then
	local _presets_orig = CharacterTweakData._presets
	function CharacterTweakData:_presets(tweak_data, ...)
		math.randomseed( os.time() )
		math.randomseed( os.time() )
		math.randomseed( os.time() )
	
		local presets = _presets_orig(self, tweak_data, ...)
		
			presets.gang_member_damage_1 = {
				HEALTH_INIT = 500,
				REGENERATE_TIME = math.huge,
				REGENERATE_TIME_AWAY = math.huge,
				DOWNED_TIME = 30,
				TASED_TIME = 10,
				BLEED_OUT_HEALTH_INIT = 25,
				ARRESTED_TIME = 20,
				INCAPACITATED_TIME = 20,
				hurt_severity = {
					health_reference = "current",
					zones = {
						{ health_limit=0.4, none=0.3, light=0.6, moderate=0.1 },
						{ health_limit=0.7, none=0.1, light=0.7, moderate=0.2 },
						{ none=0.1, light=0.5, moderate=0.3, heavy=0.1 },
					}
				},
				MIN_DAMAGE_INTERVAL = 0.25,
				respawn_time_penalty = 0,
				base_respawn_time_penalty = 0		
			}

			presets.gang_member_damage_2 = {
				HEALTH_INIT = 500,
				REGENERATE_TIME = math.huge,
				REGENERATE_TIME_AWAY = math.huge,
				DOWNED_TIME = 30,
				TASED_TIME = 10,
				BLEED_OUT_HEALTH_INIT = 25,
				ARRESTED_TIME = 20,
				INCAPACITATED_TIME = 20,
				hurt_severity = {
					health_reference = "current",
					zones = {
						{ health_limit=0.4, none=0.3, light=0.6, moderate=0.1 },
						{ health_limit=0.7, none=0.1, light=0.7, moderate=0.2 },
						{ none=0.1, light=0.5, moderate=0.3, heavy=0.1 },
					}
				},
				MIN_DAMAGE_INTERVAL = 0.25,
				respawn_time_penalty = 0,
				base_respawn_time_penalty = 0		
			}

			presets.gang_member_damage_3 = {
				HEALTH_INIT = 500,
				REGENERATE_TIME = math.huge,
				REGENERATE_TIME_AWAY = math.huge,
				DOWNED_TIME = 30,
				TASED_TIME = 10,
				BLEED_OUT_HEALTH_INIT = 25,
				ARRESTED_TIME = 20,
				INCAPACITATED_TIME = 20,
				hurt_severity = {
					health_reference = "current",
					zones = {
						{ health_limit=0.4, none=0.3, light=0.6, moderate=0.1 },
						{ health_limit=0.7, none=0.1, light=0.7, moderate=0.2 },
						{ none=0.1, light=0.5, moderate=0.3, heavy=0.1 },
					}
				},
				MIN_DAMAGE_INTERVAL = 0.25,
				respawn_time_penalty = 0,
				base_respawn_time_penalty = 0		
			}

			presets.gang_member_damage_4 = {
				HEALTH_INIT = 500,
				REGENERATE_TIME = math.huge,
				REGENERATE_TIME_AWAY = math.huge,
				DOWNED_TIME = 30,
				TASED_TIME = 10,
				BLEED_OUT_HEALTH_INIT = 25,
				ARRESTED_TIME = 20,
				INCAPACITATED_TIME = 20,
				hurt_severity = {
					health_reference = "current",
					zones = {
						{ health_limit=0.4, none=0.3, light=0.6, moderate=0.1 },
						{ health_limit=0.7, none=0.1, light=0.7, moderate=0.2 },
						{ none=0.1, light=0.5, moderate=0.3, heavy=0.1 },
					}
				},
				MIN_DAMAGE_INTERVAL = 0.25,
				respawn_time_penalty = 0,
				base_respawn_time_penalty = 0			
			}			
			
		return presets
	end	

	--[[
	local guns = {
		Idstring( "units/payday2/weapons/wpn_npc_m4/wpn_npc_m4" ),
		Idstring( "units/payday2/weapons/wpn_npc_ak47/wpn_npc_ak47" ),
		Idstring( "units/payday2/weapons/wpn_npc_r870/wpn_npc_r870" ),
		Idstring( "units/payday2/weapons/wpn_npc_mp5/wpn_npc_mp5" ),
		Idstring( "units/payday2/weapons/wpn_npc_sniper/wpn_npc_sniper" ),
		
		Idstring( "units/payday2/weapons/wpn_npc_raging_bull/wpn_npc_raging_bull" ),
		Idstring( "units/payday2/weapons/wpn_npc_beretta92/wpn_npc_beretta92" ),
		Idstring( "units/payday2/weapons/wpn_npc_c45/wpn_npc_c45" ),
		Idstring( "units/payday2/weapons/wpn_npc_mac11/wpn_npc_mac11" ),
		Idstring( "units/payday2/weapons/wpn_npc_mp9/wpn_npc_mp9" ),
		Idstring( "units/payday2/weapons/wpn_npc_sawnoff_shotgun/wpn_npc_sawnoff_shotgun" ),
		Idstring( "units/payday2/weapons/wpn_npc_mac11/wpn_npc_mac11" )
	}
	]]

	local primaries = {
		Idstring( "units/payday2/weapons/wpn_npc_m4/wpn_npc_m4" ),
		Idstring( "units/payday2/weapons/wpn_npc_ak47/wpn_npc_ak47" ),
		Idstring( "units/payday2/weapons/wpn_npc_r870/wpn_npc_r870" ),
		Idstring( "units/payday2/weapons/wpn_npc_mp5/wpn_npc_mp5" )
	}

	local secondaries = {
		Idstring( "units/payday2/weapons/wpn_npc_raging_bull/wpn_npc_raging_bull" ),
		Idstring( "units/payday2/weapons/wpn_npc_beretta92/wpn_npc_beretta92" ),
		Idstring( "units/payday2/weapons/wpn_npc_c45/wpn_npc_c45" ),
		Idstring( "units/payday2/weapons/wpn_npc_mac11/wpn_npc_mac11" ),
		Idstring( "units/payday2/weapons/wpn_npc_mp9/wpn_npc_mp9" ),
		Idstring( "units/payday2/weapons/wpn_npc_sawnoff_shotgun/wpn_npc_sawnoff_shotgun" ),
		Idstring( "units/payday2/weapons/wpn_npc_mac11/wpn_npc_mac11" )
	}

	local _init_russian_orig = CharacterTweakData._init_russian
	function CharacterTweakData:_init_russian( presets, ... )
		_init_russian_orig(self, presets, ...)

		math.randomseed( os.time() )
		math.randomseed( os.time() )
		math.randomseed( os.time() )
		
		self.russian = {}
		self.russian.damage = presets.gang_member_damage_1
		self.russian.weapon = deep_clone( presets.weapon.gang_member )
		self.russian.weapon.weapons_of_choice = {
			--primary = guns[math.random(#guns)],
			--secondary = Idstring( "units/payday2/weapons/wpn_npc_raging_bull/wpn_npc_raging_bull" )
			primary = primaries[math.random(#primaries)],
			secondary = secondaries[math.random(#secondaries)]
		}
		
		self.russian.detection = presets.detection.gang_member
		
		self.russian.dodge = presets.dodge.ninja --test
		
		self.russian.move_speed = presets.move_speed.lightning
		self.russian.crouch_move = true
		self.russian.speech_prefix = "rb2"
		self.russian.weapon_voice = "1"
		self.russian.access = "teamAI1"
		self.russian.arrest = {
			timeout = 60 * 4, -- minimum delay between arrest attempts. (sec)
			aggression_timeout = 6, -- do not attempt to arrest if the player has performed aggression in this timeframe. (sec)
			arrest_timeout = 60 * 4
		}
	end

	local _init_german_orig = CharacterTweakData._init_german
	function CharacterTweakData:_init_german( presets, ... )
		_init_german_orig(self, presets, ...)
		
		math.randomseed( os.time() )
		math.randomseed( os.time() )
		math.randomseed( os.time() )
			
		self.german = {}
		self.german.damage = presets.gang_member_damage_2
		self.german.weapon = deep_clone( presets.weapon.gang_member )
		self.german.weapon.weapons_of_choice = {
			--primary = guns[math.random(#guns)],
			--secondary = Idstring( "units/payday2/weapons/wpn_npc_raging_bull/wpn_npc_raging_bull" )
			primary = primaries[math.random(#primaries)],
			secondary = secondaries[math.random(#secondaries)]
		}
		
		self.german.detection = presets.detection.gang_member
		
		self.german.dodge = presets.dodge.ninja --test
		
		self.german.move_speed = presets.move_speed.lightning
		self.german.crouch_move = true
		self.german.speech_prefix = "rb2"
		self.german.weapon_voice = "2"
		self.german.access = "teamAI2"
		self.german.arrest = {
			timeout = 60 * 4, -- minimum delay between arrest attempts. (sec)
			aggression_timeout = 6, -- do not attempt to arrest if the player has performed aggression in this timeframe. (sec)
			arrest_timeout = 60 * 4
		}
	end
	
	local _init_spanish_orig = CharacterTweakData._init_spanish
	function CharacterTweakData:_init_spanish( presets, ... )
		_init_spanish_orig(self, presets, ...)
		
		math.randomseed( os.time() )
		math.randomseed( os.time() )
		math.randomseed( os.time() )
			
		self.spanish = {}
		self.spanish.damage = presets.gang_member_damage_3
		self.spanish.weapon = deep_clone( presets.weapon.gang_member )
		self.spanish.weapon.weapons_of_choice = {
			--primary = guns[math.random(#guns)],
			--secondary = Idstring( "units/payday2/weapons/wpn_npc_raging_bull/wpn_npc_raging_bull" )
			primary = primaries[math.random(#primaries)],
			secondary = secondaries[math.random(#secondaries)]
		}
		self.spanish.detection = presets.detection.gang_member
		
		self.spanish.dodge = presets.dodge.ninja --test
		
		self.spanish.move_speed = presets.move_speed.lightning
		self.spanish.crouch_move = true
		self.spanish.speech_prefix = "rb2"
		self.spanish.weapon_voice = "3"
		self.spanish.access = "teamAI3"
		self.spanish.arrest = {
			timeout = 60 * 4, -- minimum delay between arrest attempts. (sec)
			aggression_timeout = 6, -- do not attempt to arrest if the player has performed aggression in this timeframe. (sec)
			arrest_timeout = 60 * 4
		}
	end

	local _init_american_orig = CharacterTweakData._init_american
	function CharacterTweakData:_init_american( presets, ... )
		_init_american_orig(self, presets, ...)
		
		math.randomseed( os.time() )
		math.randomseed( os.time() )
		math.randomseed( os.time() )
			
		self.american = {}
		self.american.damage = presets.gang_member_damage_4
		self.american.weapon = deep_clone( presets.weapon.gang_member )
		self.american.weapon.weapons_of_choice = {
			--primary = guns[math.random(#guns)],
			--secondary = Idstring( "units/payday2/weapons/wpn_npc_raging_bull/wpn_npc_raging_bull" )
			primary = primaries[math.random(#primaries)],
			secondary = secondaries[math.random(#secondaries)]
		}
		
		self.american.detection = presets.detection.gang_member
		
		self.american.dodge = presets.dodge.ninja --test
		
		self.american.move_speed = presets.move_speed.lightning
		self.american.crouch_move = true
		self.american.speech_prefix = "rb2"
		self.american.weapon_voice = "3"
		self.american.access = "teamAI4"
		self.american.arrest = {
			timeout = 60 * 4, -- minimum delay between arrest attempts. (sec)
			aggression_timeout = 6, -- do not attempt to arrest if the player has performed aggression in this timeframe. (sec)
			arrest_timeout = 60 * 4
		}
	end
	
end

if RequiredScript == "lib/managers/criminalsmanager" then
	CriminalsManager = CriminalsManager or class()
	CriminalsManager.MAX_NR_TEAM_AI = 3
end