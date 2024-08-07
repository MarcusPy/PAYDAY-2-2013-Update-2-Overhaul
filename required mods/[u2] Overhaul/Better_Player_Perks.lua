if RequiredScript == "lib/units/beings/player/playerdamage" then

	function PlayerDamage:_upd_health_regen( t, dt )
		if managers.player:has_category_upgrade( "player", "loot_drop_multiplier" ) and ( managers.player:upgrade_level( "player", "loot_drop_multiplier" ) == 2 ) then
			local max_health = self:_max_health()
			if ( self:get_real_health() < max_health ) then
				local chance = math.random(0,1000)
				local regen_rate = 0.015
				
				--log(chance)
				if ( chance == 666 or chance == 777 ) then
					self:change_health( max_health * regen_rate )
				end
				chance = nil
			end
		end
	end

end

if RequiredScript == "lib/managers/playermanager" then

	function PlayerManager:aquire_default_upgrades()
		-- Default special equipments
		managers.upgrades:aquire_default( "cable_tie" )
		managers.upgrades:aquire_default( "player_special_enemy_highlight" )
		managers.upgrades:aquire_default( "player_hostage_trade" )
		managers.upgrades:aquire_default( "player_sec_camera_highlight" )
		--managers.upgrades:aquire_default( "player_wolverine_health_regen" )
		
		-- managers.upgrades:aquire_default( "temporary_revive_health_boost" )
			
		for i = 1, PlayerManager.WEAPON_SLOTS do
			if not managers.player:weapon_in_slot( i ) then
				self._global.kit.weapon_slots[ i ] = managers.player:availible_weapons( i )[ 1 ]
			end
		end
		
		self:_verify_equipment_kit()
	end

	function PlayerManager:carry_blocked_by_cooldown()
		return self._carry_blocked_cooldown_t and self._carry_blocked_cooldown_t > Application:time() or false
	end

end