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
end
