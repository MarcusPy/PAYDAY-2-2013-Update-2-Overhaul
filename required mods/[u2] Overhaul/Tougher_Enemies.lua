if RequiredScript == "lib/units/civilians/civiliandamage" then
	-- civs no longer die to 1 melee, now they are immune and get intimidated instead
	function CivilianDamage:damage_melee( attack_data )
		self._unit:brain():on_intimidated( 1, attack_data.attacker_unit )
		return
	end
	
	-- allows to kill civs when headshot_only mode is on
	function CivilianDamage:damage_bullet( attack_data )
		attack_data.damage = 10
		return CopDamage.damage_bullet( self, attack_data, true )
	end
end

if RequiredScript == "lib/units/enemies/cop/copdamage" then
	function CopDamage:damage_bullet( attack_data, is_civ )
		if self._dead or self._invulnerable then
			return
		end
		
		if self._has_plate then
			if attack_data.col_ray.body and attack_data.col_ray.body:name() == self._ids_plate_name then
				return
			end
		end
		
		local result
		local body_index = self._unit:get_body_index( attack_data.col_ray.body:name() )
		local head = self._head_body_name and attack_data.col_ray.body and attack_data.col_ray.body:name() == self._ids_head_body_name
		
		local damage = attack_data.damage
		
		damage = damage * ( self._marked_dmg_mul or 1 )
		if self._unit:movement():cool() then
			damage = self._HEALTH_INIT
		end
		
		local headshot_multiplier = 1
		if attack_data.attacker_unit == managers.player:player_unit() then
			managers.hud:on_hit_confirmed()
			headshot_multiplier = managers.player:upgrade_value( "weapon", "passive_headshot_damage_multiplier", 1 )
			
			if tweak_data.character[ self._unit:base()._tweak_table ].priority_shout then
				damage = damage * managers.player:upgrade_value( "weapon", "special_damage_taken_multiplier", 1 )
			end
		end
		
		if self._damage_reduction_multiplier then
			damage = damage * self._damage_reduction_multiplier
		elseif head then
			if self._char_tweak.headshot_dmg_mul then
				damage = damage * self._char_tweak.headshot_dmg_mul * headshot_multiplier
			else
				damage = self._health * 10
			end
		end
		
		local damage_percent = math.ceil( math.clamp( damage / self._HEALTH_INIT_PRECENT, 1, 100 ) )
		damage = damage_percent * self._HEALTH_INIT_PRECENT
		
		if _G.u2_core.settings.gameplay.headshot_only and not is_civ then
			if not head then
				return
			end
			damage_percent = 0
			damage = 0
			self:_spawn_head_gadget( { position = attack_data.col_ray.body:position(), rotation = attack_data.col_ray.body:rotation(), dir = attack_data.col_ray.ray } )
			attack_data.damage = self._health
			result = { type = "death", variant = attack_data.variant }
			self:die( attack_data.variant )
		elseif damage >= self._health then
			if head then
				if damage > math.random(10) then
					self:_spawn_head_gadget( { position = attack_data.col_ray.body:position(), rotation = attack_data.col_ray.body:rotation(), dir = attack_data.col_ray.ray } )
				end
			end
			
			attack_data.damage = self._health
			result = { type = "death", variant = attack_data.variant }
			self:die( attack_data.variant )
		else
			attack_data.damage = damage
			local result_type = self:get_damage_type(damage_percent)
			result = { type = result_type, variant = attack_data.variant }
			self._health = self._health - damage
			self._health_ratio = self._health / self._HEALTH_INIT
		end
		
		attack_data.result = result
		attack_data.pos = attack_data.col_ray.position
		
		if result.type == "death" then
			local data = { name = self._unit:base()._tweak_table, head_shot = head, weapon_unit = attack_data.weapon_unit, variant = attack_data.variant }
			if managers.groupai:state():all_criminals()[ attack_data.attacker_unit:key() ] then
				managers.statistics:killed_by_anyone( data )
			end
			
			if attack_data.attacker_unit == managers.player:player_unit() then
				self:_comment_death( attack_data.attacker_unit, self._unit:base()._tweak_table )
				self:_show_death_hint( self._unit:base()._tweak_table )
				local attacker_state = managers.player:current_state()
				data.attacker_state = attacker_state
				managers.statistics:killed( data )
				
				if attack_data.attacker_unit:character_damage():bleed_out() then
					if not self:_type_civilian( self._unit:base()._tweak_table ) then
						local messiah_revive = false
						if managers.player:has_category_upgrade( "player", "pistol_revive_from_bleed_out" ) then
							if data.weapon_unit:base():weapon_tweak_data()[ "category" ] == "pistol" then
								if attack_data.attacker_unit:character_damage():consume_messiah_charge() then
									messiah_revive = true
								end
							end
						end
						if messiah_revive then
							attack_data.attacker_unit:character_damage():revive( true )
						end
					end
				end
				
				if( not self:_type_civilian( self._unit:base()._tweak_table ) ) then
					if( managers.player:has_category_upgrade( "temporary", "overkill_damage_multiplier" ) ) then
						local weapon_category = attack_data.weapon_unit:base():weapon_tweak_data()["category"]
						if( weapon_category == "shotgun" or weapon_category == "saw" ) then
							managers.player:activate_temporary_upgrade( "temporary", "overkill_damage_multiplier" )
						end
					end
				end
				
				if self:_type_civilian( self._unit:base()._tweak_table ) then
					managers.money:civilian_killed()
				end
			elseif attack_data.attacker_unit:in_slot( managers.slot:get_mask( "criminals_no_deployables" ) ) then
				self:_AI_comment_death( attack_data.attacker_unit, self._unit:base()._tweak_table )
			elseif attack_data.attacker_unit:base().sentry_gun then
				if Network:is_server() then
					local server_info = attack_data.weapon_unit:base():server_information()
					if server_info and server_info.owner_peer_id ~= managers.network:session():local_peer():id() then
						local owner_peer = managers.network:session():peer( server_info.owner_peer_id )
						if owner_peer then
							owner_peer:send_queued_sync( "sync_player_kill_statistic", data.name, data.head_shot and true or false, data.weapon_unit, data.variant )
						end
					else
						data.attacker_state = managers.player:current_state()
						managers.statistics:killed( data )
					end
				end
			end
		end
		
		local hit_offset_height = math.clamp( attack_data.col_ray.position.z - self._unit:movement():m_pos().z, 0 , 300 )
		
		local attacker = attack_data.attacker_unit
		if attacker:id() == -1 then
			attacker = self._unit
		end
		
		self:_send_bullet_attack_result( attack_data, attacker, damage_percent, body_index, hit_offset_height )
		self:_on_damage_received( attack_data )
		
		return result
	end
	
	function CopDamage:damage_explosion( attack_data )
		if _G.u2_core.settings.gameplay.headshot_only then
			return
		end
		
		if self._dead or self._invulnerable then
			return
		end
		
		local result
		local damage = attack_data.damage
		
		damage = damage * ( self._marked_dmg_mul or 1 )
		damage = math.clamp( damage, 0, self._HEALTH_INIT )
		local damage_percent = math.ceil( damage / self._HEALTH_INIT_PRECENT )
		damage = damage_percent * self._HEALTH_INIT_PRECENT
		
		if damage >= self._health then
			attack_data.damage = self._health
			result = { type = "death", variant = attack_data.variant }
			self:die( attack_data.variant )
		else
			attack_data.damage = damage
			local result_type = attack_data.variant == "stun" and "hurt_sick" or self:get_damage_type(damage_percent)
			result = { type = result_type, variant = attack_data.variant }
			self._health = self._health - damage
			self._health_ratio = self._health / self._HEALTH_INIT
		end
		
		attack_data.result = result
		attack_data.pos = attack_data.col_ray.position
		
		local head
		if self._head_body_name and attack_data.variant ~= "stun" then
			head = attack_data.col_ray.body and self._head_body_key and attack_data.col_ray.body:key() == self._head_body_key
			local body = self._unit:body( self._head_body_name )
			self:_spawn_head_gadget( { position = body:position(), rotation = body:rotation(), dir = -attack_data.col_ray.ray } )
		end
		
		local attacker = attack_data.attacker_unit
		if not attacker or attacker:id() == -1 then
			attacker = self._unit
		end
		
		if result.type == "death" then
			local data = { name = self._unit:base()._tweak_table, owner = attack_data.owner, weapon_unit = attack_data.weapon_unit, variant = attack_data.variant, head_shot = head }
			managers.statistics:killed_by_anyone( data )
			
			if attack_data.attacker_unit == managers.player:player_unit() then
				if alive( attack_data.attacker_unit ) then
					self:_comment_death( attack_data.attacker_unit, self._unit:base()._tweak_table )
				end
				self:_show_death_hint( self._unit:base()._tweak_table )
				managers.statistics:killed( data )
				
				if self:_type_civilian( self._unit:base()._tweak_table ) then
					managers.money:civilian_killed()
				end
			end
		end
		
		self:_send_explosion_attack_result( attack_data, attacker, damage_percent, self:_get_attack_variant_index( attack_data.result.variant ) )
		self:_on_damage_received( attack_data )
		
		return result
	end
	
	function CopDamage:damage_melee( attack_data )
		if _G.u2_core.settings.gameplay.headshot_only then
			return
		end
		
		if self._dead or self._invulnerable then
			return
		end
		
		local result
		local head = self._head_body_name and attack_data.col_ray.body and attack_data.col_ray.body:name() == self._ids_head_body_name
		local damage = attack_data.damage
		
		damage = damage * ( self._marked_dmg_mul or 1 )
		if self._unit:movement():cool() then
			damage = self._HEALTH_INIT
		end
		if self._damage_reduction_multiplier then
			damage = damage * self._damage_reduction_multiplier
		end
		local damage_effect = attack_data.damage_effect
		local damage_effect_percent
		
		damage = math.clamp( damage, self._HEALTH_INIT_PRECENT, self._HEALTH_INIT )
		local damage_percent = math.ceil( damage / self._HEALTH_INIT_PRECENT )
		damage = damage_percent * self._HEALTH_INIT_PRECENT
		
		if damage >= self._health then
			damage_effect_percent = 1
			attack_data.damage = self._health
			result = { type = "death", variant = attack_data.variant }
			self:die( attack_data.variant )
		else
			attack_data.damage = damage
			damage_effect = math.clamp( damage_effect, self._HEALTH_INIT_PRECENT, self._HEALTH_INIT )
			damage_effect_percent = math.ceil( damage_effect / self._HEALTH_INIT_PRECENT )
			damage_effect_percent = math.clamp( damage_effect_percent, 1, 100 )
			local result_type = attack_data.shield_knock and self._char_tweak.damage.shield_knocked and "shield_knock" or attack_data.variant == "counter_tased" and "counter_tased" or self:get_damage_type(damage_effect_percent)
			result = { type = result_type, variant = attack_data.variant }
			self._health = self._health - damage
			self._health_ratio = self._health / self._HEALTH_INIT
		end
		
		attack_data.result = result
		attack_data.pos = attack_data.col_ray.position
		
		if result.type == "death" then
			local data = { name = self._unit:base()._tweak_table, head_shot = head, weapon_unit = attack_data.weapon_unit, variant = attack_data.variant }
			managers.statistics:killed_by_anyone( data )
			
			if attack_data.attacker_unit == managers.player:player_unit() then
				self:_comment_death( attack_data.attacker_unit, self._unit:base()._tweak_table )
				self:_show_death_hint( self._unit:base()._tweak_table )
				managers.statistics:killed( data )
				
				if self:_type_civilian( self._unit:base()._tweak_table ) then
					managers.money:civilian_killed()
				end
			end
		end
		
		local hit_offset_height = math.clamp( attack_data.col_ray.position.z - self._unit:movement():m_pos().z, 0 , 300 )
		
		local variant
		if result.type == "shield_knock" then
			variant = 1
		elseif result.type == "counter_tased" then
			variant = 2
		else
			variant = 0
		end
		
		self:_send_melee_attack_result( attack_data, damage_percent, damage_effect_percent, hit_offset_height, variant )
		self:_on_damage_received( attack_data )
		
		return result
	end
end

if RequiredScript == "lib/tweak_data/charactertweakdata" then
	function CharacterTweakData:_multiply_all_hp( hp_mul, hs_mul )
		if _G.u2_core.settings.gameplay.headshot_only then
			hp_mul = 1e5
			hs_mul = hp_mul
			
			self.security.HEALTH_INIT 		= hp_mul
			self.cop.HEALTH_INIT 			= hp_mul
			self.fbi.HEALTH_INIT 			= hp_mul
			self.swat.HEALTH_INIT 			= hp_mul
			self.heavy_swat.HEALTH_INIT		= hp_mul
			self.fbi_heavy_swat.HEALTH_INIT = hp_mul
			self.sniper.HEALTH_INIT 		= hp_mul
			self.gangster.HEALTH_INIT 		= hp_mul
			self.tank.HEALTH_INIT 			= hp_mul
			self.spooc.HEALTH_INIT 			= hp_mul
			self.shield.HEALTH_INIT 		= hp_mul
			self.taser.HEALTH_INIT 			= hp_mul
			self.biker_escape.HEALTH_INIT 	= hp_mul
			
			self.security.headshot_dmg_mul 		 = hs_mul
			self.cop.headshot_dmg_mul 			 = hs_mul
			self.fbi.headshot_dmg_mul	 		 = hs_mul
			self.swat.headshot_dmg_mul 			 = hs_mul
			self.heavy_swat.headshot_dmg_mul 	 = hs_mul
			self.fbi_heavy_swat.headshot_dmg_mul = hs_mul
			self.sniper.headshot_dmg_mul 		 = hs_mul
			self.gangster.headshot_dmg_mul	 	 = hs_mul
			self.tank.headshot_dmg_mul	 		 = hs_mul
			self.spooc.headshot_dmg_mul 		 = hs_mul
			self.shield.headshot_dmg_mul	 	 = hs_mul
			self.taser.headshot_dmg_mul 		 = hs_mul
			self.biker_escape.headshot_dmg_mul 	 = hs_mul
		elseif _G.u2_core.settings.gameplay.hp_mult > 1 then
			hp_mul = _G.u2_core.settings.gameplay.hp_mult
			self.security.HEALTH_INIT 		= math.round(self.security.HEALTH_INIT 		 * hp_mul)
			self.cop.HEALTH_INIT 			= math.round(self.cop.HEALTH_INIT 			 * hp_mul)
			self.fbi.HEALTH_INIT 			= math.round(self.fbi.HEALTH_INIT 			 * hp_mul)
			self.swat.HEALTH_INIT 			= math.round(self.swat.HEALTH_INIT 			 * hp_mul)
			self.heavy_swat.HEALTH_INIT		= math.round(self.heavy_swat.HEALTH_INIT 	 * hp_mul)
			self.fbi_heavy_swat.HEALTH_INIT = math.round(self.fbi_heavy_swat.HEALTH_INIT * hp_mul)
			self.sniper.HEALTH_INIT 		= math.round(self.sniper.HEALTH_INIT 		 * hp_mul)
			self.gangster.HEALTH_INIT 		= math.round(self.gangster.HEALTH_INIT 		 * hp_mul)
			self.tank.HEALTH_INIT 			= math.round(self.tank.HEALTH_INIT 			 * hp_mul)
			self.spooc.HEALTH_INIT 			= math.round(self.spooc.HEALTH_INIT 		 * hp_mul)
			self.shield.HEALTH_INIT 		= math.round(self.shield.HEALTH_INIT 		 * hp_mul)
			self.taser.HEALTH_INIT 			= math.round(self.taser.HEALTH_INIT 		 * hp_mul)
			self.biker_escape.HEALTH_INIT 	= math.round(self.biker_escape.HEALTH_INIT 	 * hp_mul)
		end
	end

	local hs_mul_no_helmet = 999
	local hs_mul_helmet = 3

	function CharacterTweakData:_init_gangster( presets )
		self.gangster = deep_clone( presets.base )
		self.gangster.experience = {}
		self.gangster.weapon = presets.weapon.normal
		self.gangster.detection = presets.detection.normal
		self.gangster.HEALTH_INIT = 12
		self.gangster.headshot_dmg_mul = hs_mul_no_helmet
		self.gangster.move_speed = presets.move_speed.fast
		self.gangster.suspicious = nil
		self.gangster.suppression = presets.suppression.easy
		self.gangster.surrender = nil
		self.gangster.ecm_vulnerability = 0.7
		self.gangster.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } }
		self.gangster.no_arrest = true
		self.gangster.no_retreat = true
		self.gangster.weapon_voice = "3"
		self.gangster.experience.cable_tie = "tie_swat"
		self.gangster.speech_prefix_p1 = "l"
		self.gangster.speech_prefix_p2 = "n"
		self.gangster.speech_prefix_count = 4
		self.gangster.access = "gangster"
		self.gangster.rescue_hostages = false
		self.gangster.use_radio = nil
		self.gangster.dodge = presets.dodge.average
		self.gangster.challenges = { type = "gangster" }
		self.gangster.chatter = presets.enemy_chatter.no_chatter
	end

	function CharacterTweakData:_init_biker_escape( presets )
		self.biker_escape = deep_clone( self.gangster )
		self.biker_escape.move_speed = presets.move_speed.very_fast
		self.biker_escape.suppression = nil
	end

	function CharacterTweakData:_init_security( presets )
		self.security = deep_clone( presets.base )
		self.security.experience = {}
		self.security.weapon = presets.weapon.normal
		self.security.detection = presets.detection.guard
		self.security.HEALTH_INIT = 10
		self.security.headshot_dmg_mul = hs_mul_no_helmet
		self.security.move_speed = presets.move_speed.normal
		self.security.crouch_move = nil
		self.security.surrender_break_time = { 20, 30 }
		self.security.suppression = presets.suppression.easy
		self.security.surrender = presets.surrender.easy
		self.security.ecm_vulnerability = 0.8
		self.security.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } }
		self.security.weapon_voice = "3"
		self.security.experience.cable_tie = "tie_swat"
		self.security.speech_prefix_p1 = "l"
		self.security.speech_prefix_p2 = "n"
		self.security.speech_prefix_count = 4
		self.security.access = "security"
		self.security.rescue_hostages = false
		self.security.use_radio = nil
		self.security.silent_priority_shout = "Dia_10"
		self.security.dodge = presets.dodge.poor
		self.security.deathguard = false
		self.security.chatter = presets.enemy_chatter.cop
		self.security.has_alarm_pager = true
	end

	function CharacterTweakData:_init_cop( presets )
		self.cop = deep_clone( presets.base )
		self.cop.experience = {}
		self.cop.weapon = presets.weapon.normal
		self.cop.detection = presets.detection.normal
		self.cop.HEALTH_INIT = 10
		self.cop.headshot_dmg_mul = hs_mul_no_helmet
		self.cop.move_speed = presets.move_speed.normal
		self.cop.surrender_break_time = { 10, 15 }
		self.cop.suppression = presets.suppression.easy
		self.cop.surrender = presets.surrender.normal
		self.cop.ecm_vulnerability = 0.8
		self.cop.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } }
		self.cop.weapon_voice = "1"
		self.cop.experience.cable_tie = "tie_swat"
		self.cop.speech_prefix_p1 = "l"
		self.cop.speech_prefix_p2 = "n"
		self.cop.speech_prefix_count = 4
		self.cop.access = "cop"
		self.cop.dodge = presets.dodge.average
		self.cop.follower = true
		self.cop.deathguard = true
		self.cop.chatter = presets.enemy_chatter.cop
	end

	function CharacterTweakData:_init_fbi( presets )
		self.fbi = deep_clone( presets.base )
		self.fbi.experience = {}
		self.fbi.weapon = presets.weapon.normal
		self.fbi.detection = presets.detection.normal
		self.fbi.HEALTH_INIT = 15
		self.fbi.headshot_dmg_mul = hs_mul_no_helmet
		self.fbi.move_speed = presets.move_speed.normal
		self.fbi.surrender_break_time = { 7, 12 }
		self.fbi.suppression = presets.suppression.easy
		self.fbi.surrender = presets.surrender.normal
		self.fbi.ecm_vulnerability = 0.6
		self.fbi.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } }
		self.fbi.weapon_voice = "2"
		self.fbi.experience.cable_tie = "tie_swat"
		self.fbi.speech_prefix_p1 = "l"
		self.fbi.speech_prefix_p2 = "n"
		self.fbi.speech_prefix_count = 4
		self.fbi.access = "fbi"
		self.fbi.dodge = presets.dodge.athletic
		self.fbi.follower = true
		self.fbi.deathguard = true
		self.fbi.no_arrest = true
		self.fbi.chatter = presets.enemy_chatter.cop
	end

	function CharacterTweakData:_init_swat( presets )
		self.swat = deep_clone( presets.base )
		self.swat.experience = {}
		self.swat.weapon = presets.weapon.normal
		self.swat.detection = presets.detection.normal
		self.swat.HEALTH_INIT = 15
		self.swat.headshot_dmg_mul = hs_mul_helmet
		self.swat.move_speed = presets.move_speed.fast
		self.swat.surrender_break_time = { 6, 10 }
		self.swat.suppression = presets.suppression.hard_def
		self.swat.surrender = presets.surrender.normal
		self.swat.ecm_vulnerability = 0.4
		self.swat.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } }
		self.swat.weapon_voice = "2"
		self.swat.experience.cable_tie = "tie_swat"
		self.swat.speech_prefix_p1 = "l"
		self.swat.speech_prefix_p2 = "n"
		self.swat.speech_prefix_count = 4
		self.swat.access = "swat"
		self.swat.dodge = presets.dodge.athletic
		self.swat.follower = true
		self.swat.no_arrest = true
		self.swat.chatter = presets.enemy_chatter.swat
	end

	function CharacterTweakData:_init_heavy_swat( presets )
		self.heavy_swat = deep_clone( presets.base )
		self.heavy_swat.experience = {}
		self.heavy_swat.weapon = presets.weapon.normal
		self.heavy_swat.detection = presets.detection.normal
		self.heavy_swat.HEALTH_INIT = 25
		self.heavy_swat.headshot_dmg_mul = hs_mul_helmet
		self.heavy_swat.move_speed = presets.move_speed.fast
		self.heavy_swat.surrender_break_time = { 6, 8 }
		self.heavy_swat.suppression = presets.suppression.hard_agg
		self.heavy_swat.surrender = presets.surrender.normal
		self.heavy_swat.ecm_vulnerability = 0.2
		self.heavy_swat.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } }
		self.heavy_swat.weapon_voice = "2"
		self.heavy_swat.experience.cable_tie = "tie_swat"
		self.heavy_swat.speech_prefix_p1 = "l"
		self.heavy_swat.speech_prefix_p2 = "n"
		self.heavy_swat.speech_prefix_count = 4
		self.heavy_swat.access = "swat"
		self.heavy_swat.dodge = presets.dodge.heavy
		self.heavy_swat.follower = true
		self.heavy_swat.no_arrest = true
		self.heavy_swat.chatter = presets.enemy_chatter.swat
	end

	function CharacterTweakData:_init_fbi_swat( presets )
		self.fbi_swat = deep_clone( presets.base )
		self.fbi_swat.experience = {}
		self.fbi_swat.weapon = presets.weapon.normal
		self.fbi_swat.detection = presets.detection.normal
		self.fbi_swat.HEALTH_INIT = 30
		self.fbi_swat.headshot_dmg_mul = hs_mul_helmet
		self.fbi_swat.move_speed = presets.move_speed.very_fast
		self.fbi_swat.surrender_break_time = { 6, 10 }
		self.fbi_swat.suppression = presets.suppression.hard_def
		self.fbi_swat.surrender = presets.surrender.normal
		self.fbi_swat.ecm_vulnerability = 0.4
		self.fbi_swat.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } }
		self.fbi_swat.weapon_voice = "2"
		self.fbi_swat.experience.cable_tie = "tie_swat"
		self.fbi_swat.speech_prefix_p1 = "l"
		self.fbi_swat.speech_prefix_p2 = "n"
		self.fbi_swat.speech_prefix_count = 4
		self.fbi_swat.access = "swat"
		self.fbi_swat.dodge = presets.dodge.athletic
		self.fbi_swat.follower = true
		self.fbi_swat.no_arrest = true
		self.fbi_swat.chatter = presets.enemy_chatter.swat
	end

	function CharacterTweakData:_init_fbi_heavy_swat( presets )
		self.fbi_heavy_swat = deep_clone( presets.base )
		self.fbi_heavy_swat.experience = {}
		self.fbi_heavy_swat.weapon = presets.weapon.normal
		self.fbi_heavy_swat.detection = presets.detection.normal
		self.fbi_heavy_swat.HEALTH_INIT = 35
		self.fbi_heavy_swat.headshot_dmg_mul = hs_mul_helmet
		self.fbi_heavy_swat.move_speed = presets.move_speed.fast
		self.fbi_heavy_swat.surrender_break_time = { 6, 8 }
		self.fbi_heavy_swat.suppression = presets.suppression.hard_agg
		self.fbi_heavy_swat.surrender = presets.surrender.normal
		self.fbi_heavy_swat.ecm_vulnerability = 0.2
		self.fbi_heavy_swat.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } }
		self.fbi_heavy_swat.weapon_voice = "2"
		self.fbi_heavy_swat.experience.cable_tie = "tie_swat"
		self.fbi_heavy_swat.speech_prefix_p1 = "l"
		self.fbi_heavy_swat.speech_prefix_p2 = "n"
		self.fbi_heavy_swat.speech_prefix_count = 4
		self.fbi_heavy_swat.access = "swat"
		self.fbi_heavy_swat.dodge = presets.dodge.heavy
		self.fbi_heavy_swat.follower = true
		self.fbi_heavy_swat.no_arrest = true
		self.fbi_heavy_swat.chatter = presets.enemy_chatter.swat
	end

	function CharacterTweakData:_init_sniper( presets )
		self.sniper = deep_clone( presets.base )
		self.sniper.experience = {}
		self.sniper.weapon = presets.weapon.sniper
		self.sniper.detection = presets.detection.sniper
		self.sniper.HEALTH_INIT = 10
		self.sniper.headshot_dmg_mul = hs_mul_no_helmet
		self.sniper.move_speed = presets.move_speed.normal
		self.sniper.shooting_death = false
		self.sniper.suppression = presets.suppression.easy
		self.sniper.ecm_vulnerability = 0.5
		self.sniper.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } }
		self.sniper.weapon_voice = "1"
		self.sniper.experience.cable_tie = "tie_swat"
		self.sniper.speech_prefix_p1 = "l"
		self.sniper.speech_prefix_p2 = "n"
		self.sniper.speech_prefix_count = 4
		self.sniper.priority_shout = "f34"
		self.sniper.access = "sniper"
		self.sniper.no_retreat = true
		self.sniper.no_arrest = true
		self.sniper.chatter = presets.enemy_chatter.no_chatter
	end

	function CharacterTweakData:_init_tank( presets )
		self.tank = deep_clone( presets.base )
		self.tank.experience = {}
		self.tank.weapon = deep_clone( presets.weapon.expert )
		self.tank.weapon.r870.FALLOFF[1].dmg_mul = 6
		self.tank.weapon.r870.FALLOFF[2].dmg_mul = 4
		self.tank.weapon.r870.FALLOFF[3].dmg_mul = 2
		self.tank.weapon.r870.RELOAD_SPEED = 1
		self.tank.detection = presets.detection.normal
		self.tank.HEALTH_INIT = 200
		self.tank.headshot_dmg_mul = hs_mul_helmet
		self.tank.move_speed = presets.move_speed.slow
		self.tank.allowed_stances = { cbt = true }
		self.tank.allowed_poses = { stand = true }
		self.tank.crouch_move = false
		self.tank.allow_crouch = false
		self.tank.no_run_start = true
		self.tank.no_run_stop = true
		self.tank.no_retreat = true
		self.tank.no_arrest = true
		self.tank.surrender = nil
		self.tank.ecm_vulnerability = 0.1
		self.tank.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } }
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
		self.tank.announce_incomming = "incomming_tank"
	end

	function CharacterTweakData:_init_spooc( presets )
		self.spooc = deep_clone( presets.base )
		self.spooc.experience = {}
		self.spooc.weapon = deep_clone( presets.weapon.normal )
		self.spooc.detection = presets.detection.normal
		self.spooc.HEALTH_INIT = 50
		self.spooc.headshot_dmg_mul = hs_mul_helmet
		self.spooc.move_speed = presets.move_speed.lightning
		self.spooc.SPEED_SPRINT = 670
		self.spooc.no_retreat = true
		self.spooc.no_arrest = true
		self.spooc.damage.hurt_severity = presets.hurt_severities.no_hurts
		self.spooc.surrender_break_time = { 4, 6 }
		self.spooc.suppression = nil
		self.spooc.surrender = presets.surrender.special
		self.spooc.ecm_vulnerability = 0.15
		self.spooc.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } }
		self.spooc.priority_shout = "f33"
		self.spooc.rescue_hostages = false
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
		self.spooc.announce_incomming = "incomming_spooc"
	end

	function CharacterTweakData:_init_shield( presets )
		self.shield = deep_clone( presets.base )
		self.shield.experience = {}
		self.shield.weapon = deep_clone( presets.weapon.normal )
		self.shield.detection = presets.detection.normal
		self.shield.HEALTH_INIT = 25
		self.shield.headshot_dmg_mul = hs_mul_helmet
		self.shield.allowed_stances = { cbt = true }
		self.shield.allowed_poses = { crouch = true }
		self.shield.move_speed = presets.move_speed.fast
		self.shield.no_run_start = true
		self.shield.no_run_stop = true
		self.shield.no_retreat = true
		self.shield.no_stand = true
		self.shield.no_arrest = true
		self.shield.surrender = nil
		self.shield.ecm_vulnerability = 0.4
		self.shield.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } }
		self.shield.priority_shout = "f31"
		self.shield.rescue_hostages = false
		self.shield.deathguard = true
		self.shield.no_equip_anim = true
		self.shield.wall_fwd_offset = 100
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
		self.shield.announce_incomming = "incomming_shield"
	end

	function CharacterTweakData:_init_taser( presets )
		self.taser = deep_clone( presets.base )
		self.taser.experience = {}
		self.taser.weapon = deep_clone( presets.weapon.normal )
		self.taser.weapon.m4.tase_distance = 1200
		self.taser.weapon.m4.aim_delay_tase = { 0, 0.1 }
		self.taser.detection = presets.detection.normal
		self.taser.HEALTH_INIT = 100
		self.taser.headshot_dmg_mul = hs_mul_helmet
		self.taser.move_speed = presets.move_speed.fast
		self.taser.no_retreat = true
		self.taser.no_arrest = true
		self.taser.surrender = presets.surrender.normal
		self.taser.ecm_vulnerability = 0.1
		self.taser.ecm_hurts = { ears = { min_duration = 1, max_duration = 3 } }
		self.taser.surrender_break_time = { 4, 6 }
		self.taser.suppression = nil
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
		self.taser.announce_incomming = "incomming_taser"
	end
end