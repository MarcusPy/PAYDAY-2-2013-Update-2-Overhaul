local old_check_use = PlayerStandard._check_use_item
function PlayerStandard:_check_use_item(t, input)
	if input.btn_use_item_release and self._throw_time and t and t < self._throw_time then
		managers.player:drop_carry()
		self._throw_time = nil
		return true
	else return old_check_use(self, t, input) 
	end
end

local old_PlayerStandard__start_action_reload = PlayerStandard._start_action_reload
function PlayerStandard:_start_action_reload( t, ... )
	local weapon = self._equipped_unit:base()
	if weapon and weapon:can_reload() and not self:_is_reloading() then
		local ammo_mag_left = weapon:get_ammo_remaining_in_clip()
		local ammo_total_left = weapon:get_ammo_total()
		weapon:set_ammo_total(ammo_total_left-ammo_mag_left)
		weapon:set_ammo_remaining_in_clip(0)
	end
	old_PlayerStandard__start_action_reload(self, t, ...)
end

-- make this a setting
function PlayerStandard:_get_walk_headbob()
	return 0
end
