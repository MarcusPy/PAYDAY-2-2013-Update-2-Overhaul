local ids_func = Idstring
local table_contains = table.contains

local big_idstring_table = {
	ids_func("units/payday2/characters/ene_tazer_1/ene_tazer_1"),
	ids_func("units/payday2/characters/ene_tazer_1/ene_tazer_1_husk"), 		
	ids_func("units/payday2/characters/ene_swat_heavy_1/ene_swat_heavy_1"),
	ids_func("units/payday2/characters/ene_swat_heavy_1/ene_swat_heavy_1_husk"),
	ids_func("units/payday2/characters/ene_shield_2/ene_shield_2"),
	ids_func("units/payday2/characters/ene_shield_2/ene_shield_2_husk"),
}	

local enemies_plink = {
	ids_func("units/payday2/characters/ene_swat_1/ene_swat_1"),
	ids_func("units/payday2/characters/ene_swat_1/ene_swat_1_husk"),
	ids_func("units/payday2/characters/ene_swat_2/ene_swat_2"),
	ids_func("units/payday2/characters/ene_swat_2/ene_swat_2_husk"),
	ids_func("units/payday2/characters/ene_tazer_1/ene_tazer_1"),
	ids_func("units/payday2/characters/ene_tazer_1/ene_tazer_1_husk"), 	
	ids_func("units/payday2/characters/ene_swat_heavy_1/ene_swat_heavy_1"),
	ids_func("units/payday2/characters/ene_swat_heavy_1/ene_swat_heavy_1_husk"),
	ids_func("units/payday2/characters/ene_fbi_swat_1/ene_fbi_swat_1"),
	ids_func("units/payday2/characters/ene_fbi_swat_1/ene_fbi_swat_1_husk"),
	ids_func("units/payday2/characters/ene_fbi_swat_2/ene_fbi_swat_2"),
	ids_func("units/payday2/characters/ene_fbi_swat_2/ene_fbi_swat_2_husk"),
	ids_func("units/payday2/characters/ene_fbi_heavy_1/ene_fbi_heavy_1"),
	ids_func("units/payday2/characters/ene_fbi_heavy_1/ene_fbi_heavy_1_husk"),
	ids_func("units/payday2/characters/ene_shield_2/ene_shield_1"),
	ids_func("units/payday2/characters/ene_shield_2/ene_shield_1_husk"),
	ids_func("units/payday2/characters/ene_shield_2/ene_shield_2"),
	ids_func("units/payday2/characters/ene_shield_2/ene_shield_2_husk"),
}

function CopDamage:damage_bullet( attack_data )
	if self._dead or self._invulnerable then
		return
	end
	
-- ULF : FBI Heavy swat plating
	if self._has_plate then
		if attack_data.col_ray.body and attack_data.col_ray.body:name() == self._ids_plate_name then -- ULF : This could be combined with the checks for head body
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
	
	if self._damage_reduction_multiplier then	-- converted enemy take no headshots
		damage = damage * self._damage_reduction_multiplier
	elseif head then
		if self._char_tweak.headshot_dmg_mul then
			damage = damage * self._char_tweak.headshot_dmg_mul * headshot_multiplier
		else
			damage = self._health * 10 -- insta-death
		end
	end
	
	-- Clamp the damage received within limits
	local damage_percent = math.ceil( math.clamp( damage / self._HEALTH_INIT_PRECENT, 1, 100 ) ) -- Cannot give less than 1% damage
	damage = damage_percent * self._HEALTH_INIT_PRECENT
	
	if damage >= self._health then
		if head then
			-- ULF -- Might need synch to look good, but lets try without
			if damage > math.random(10) then
				self:_spawn_head_gadget( { position = attack_data.col_ray.body:position(), rotation = attack_data.col_ray.body:rotation(), dir = attack_data.col_ray.ray } )
			end

			local my_unit = self._unit	
			local sound_ext = my_unit:sound()	

			local smashablefuckers = table_contains(big_idstring_table, my_unit:name())
			local metalplink = table_contains(enemies_plink, my_unit:name())

			local head_obj = ids_func("Head")
			local head_object_get = my_unit:get_object(head_obj)
			
			local world_g = World		
			local sound_ext = my_unit:sound()	
			
			if head_object_get and smashablefuckers then
				world_g:effect_manager():spawn({
					effect = ids_func("effects/particles/bullet_hit/glass_breakable/bullet_hit_glass_breakable"),
					parent = head_object_get		
				})			
				world_g:effect_manager():spawn({
					effect = ids_func("effects/payday2/particles/impacts/blood/blood_tendrils"),
					parent = head_object_get		
				})
				world_g:effect_manager():spawn({
					effect = ids_func("effects/payday2/particles/impacts/blood/blood_distance_dust_med"),
					parent = head_object_get		
				})	
				world_g:effect_manager():spawn({
					effect = ids_func("effects/particles/bullet_hit/sheet_metal/bullet_hit_sheet_metal"),
					parent = head_object_get		
				})
				world_g:effect_manager():spawn({
					effect = ids_func("effects/payday2/particles/impacts/metal_impact_pd2"),
					parent = head_object_get		
				})
				world_g:effect_manager():spawn({
					effect = ids_func("effects/payday2/particles/impacts/sparks/sparks_random_01"),
					parent = head_object_get		
				})
				sound_ext:play("swat_heavy_visor_shatter", nil, nil)
				sound_ext:play("swat_heavy_visor_shatter", nil, nil)
				sound_ext:play("swat_heavy_visor_shatter", nil, nil)
			elseif head_object_get and metalplink then
				world_g:effect_manager():spawn({
					effect = ids_func("effects/payday2/particles/impacts/metal_impact_pd2"),
					parent = head_object_get		
				})
				world_g:effect_manager():spawn({
					effect = ids_func("effects/payday2/particles/impacts/sparks/sparks_random_01"),
					parent = head_object_get		
				})
				world_g:effect_manager():spawn({
					effect = ids_func("effects/payday2/particles/impacts/blood/blood_tendrils"),
					parent = head_object_get		
				})
				world_g:effect_manager():spawn({
				effect = ids_func("effects/particles/bullet_hit/sheet_metal/bullet_hit_sheet_metal"),
					parent = head_object_get		
				})
				world_g:effect_manager():spawn({
					effect = ids_func("effects/payday2/particles/impacts/blood/blood_distance_dust_med"),
					parent = head_object_get		
				})	
			elseif head_object_get then --idk if this affects helmetless creatures
				world_g:effect_manager():spawn({
					effect = ids_func("effects/payday2/particles/impacts/blood/blood_tendrils"),
					parent = head_object_get		
				})
				world_g:effect_manager():spawn({
					effect = ids_func("effects/payday2/particles/impacts/blood/blood_tendrils"),
					parent = head_object_get		
				})
				world_g:effect_manager():spawn({
					effect = ids_func("effects/payday2/particles/impacts/blood/blood_distance_dust_med"),
					parent = head_object_get		
				})	
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
			
			-- Check if we have skill to auto revive from bleed out
			if attack_data.attacker_unit:character_damage():bleed_out() then
				if not self:_type_civilian( self._unit:base()._tweak_table ) then
					-- local is_singleplayer = Global.game_settings.single_player
					local messiah_revive = false
					
					if managers.player:has_category_upgrade( "player", "pistol_revive_from_bleed_out" ) then --  managers.player:temporary_upgrade_value( "temporary", "pistol_revive_from_bleed_out" ) ~= 0 then
						if data.weapon_unit:base():weapon_tweak_data()[ "category" ] == "pistol" then
							if attack_data.attacker_unit:character_damage():consume_messiah_charge() then
								messiah_revive = true
							end
						end
					end
					if messiah_revive then
						-- if is_singleplayer then
						-- 	local title = managers.localization:text( "hud_payback_success_title" )
						-- 	local text = managers.localization:text( "hud_payback_success_text", { revives=attack_data.attacker_unit:character_damage()._revives } ) 
						-- 	local icon = nil
						-- 	managers.hud:present_mid_text( { text = text, title = title, icon = icon, time = 2, event = "stinger_objectivecomplete" } )
						-- end
					
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
			if Network:is_server() then	-- it should always be the server here. sentry guns don't deal damage on clients
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
	
	return result		--Return the defense maneuver if any
end