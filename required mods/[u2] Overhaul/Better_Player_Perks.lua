-- custom Lucky Charm Ace skill behaviour
if RequiredScript == "lib/units/beings/player/playerdamage" then
	function PlayerDamage:_upd_health_regen(t, dt)
		if self._has_good_luck_charm == nil then
			self._has_good_luck_charm = managers.skilltree:skill_completed("good_luck_charm")
		end
	
		if self._has_good_luck_charm then
			local max_health = self:_max_health()
			if self:get_real_health() < max_health then
				local chance = math.random(1000)
				if chance == 666 or chance == 777 then
					local regen_rate = 0.01
					local health_to_add = max_health * regen_rate
					self:change_health(health_to_add)
				end
			end
		end
	end
--[[
	function PlayerDamage:damage_bullet(attack_data)
		local damage_info = {
			result = {type = "hurt", variant = "bullet"},
			attacker_unit = attack_data.attacker_unit
		}





		--if managers.player:upgrade_value("player", "passive_dodge_chance", 0) >= math.rand(1) or self._unit:movement():running() and managers.player:upgrade_value("player", "run_dodge_chance", 0) >= math.rand(1) then
		if managers.skilltree:skill_completed("moving_target") 
			if 0 < attack_data.damage then
				self:_send_damage_drama(attack_data, attack_data.damage)
			end
			self:_call_listeners(damage_info)
			self:_hit_direction(attack_data.col_ray)
			return
		end






		local dmg_mul = managers.player:temporary_upgrade_value("temporary", "dmg_dampener_outnumbered", 1) * managers.player:upgrade_value("player", "damage_dampener", 1)
		if self._unit:movement()._current_state and self._unit:movement()._current_state:_interacting() then
			dmg_mul = dmg_mul * managers.player:upgrade_value("player", "interacting_damage_multiplier", 1)
		end
		attack_data.damage = attack_data.damage * dmg_mul
		if self._god_mode then
			if 0 < attack_data.damage then
				self:_send_damage_drama(attack_data, attack_data.damage)
			end
			self:_call_listeners(damage_info)
			return
		elseif self._invulnerable then
			self:_call_listeners(damage_info)
			return
		elseif self:incapacitated() then
			return
		elseif PlayerDamage:_look_for_friendly_fire(attack_data.attacker_unit) then
			return
		elseif self:_chk_dmg_too_soon(attack_data.damage) then
			return
		elseif self._revive_miss and math.random() < self._revive_miss then
			self:play_whizby(attack_data.col_ray.position)
			return
		end
		if attack_data.attacker_unit:base()._tweak_table == "tank" then
			managers.achievment:set_script_data("dodge_this_fail", true)
		end
		if 0 < self:get_real_armor() then
			self._unit:sound():play("player_hit")
		else
			self._unit:sound():play("player_hit_permadamage")
		end
		local shake_multiplier = math.clamp(attack_data.damage, 0.2, 2) * managers.player:upgrade_value("player", "damage_shake_multiplier", 1)
		self._unit:camera():play_shaker("player_bullet_damage", 1 * shake_multiplier)
		managers.rumble:play("damage_bullet")
		self:_hit_direction(attack_data.col_ray)
		managers.player:check_damage_carry(attack_data)
		if self._bleed_out then
			self:_bleed_out_damage(attack_data)
			return
		end
		if not self:is_suppressed() then
			return
		end
		local armor_reduction_multiplier = 0
		if 0 >= self:get_real_armor() then
			armor_reduction_multiplier = 1
		end
		local health_subtracted = self:_calc_armor_damage(attack_data)
		attack_data.damage = attack_data.damage * armor_reduction_multiplier
		health_subtracted = health_subtracted + self:_calc_health_damage(attack_data)
		managers.player:activate_temporary_upgrade("temporary", "wolverine_health_regen")
		self._next_allowed_dmg_t = Application:digest_value(managers.player:player_timer():time() + self._dmg_interval, true)
		self._last_received_dmg = health_subtracted
		if not self._bleed_out and 0 < health_subtracted then
			self:_send_damage_drama(attack_data, health_subtracted)
		elseif self._bleed_out then
			managers.challenges:set_flag("bullet_to_bleed_out")
			if attack_data.attacker_unit and attack_data.attacker_unit:alive() and attack_data.attacker_unit:base()._tweak_table == "tank" then
				self._kill_taunt_clbk_id = "kill_taunt" .. tostring(self._unit:key())
				managers.enemy:add_delayed_clbk(self._kill_taunt_clbk_id, callback(self, self, "clbk_kill_taunt", attack_data), managers.player:player_timer():time() + tweak_data.timespeed.downed.fade_in + tweak_data.timespeed.downed.sustain + tweak_data.timespeed.downed.fade_out)
			end
		end
		self:_call_listeners(damage_info)
	end]]
end
